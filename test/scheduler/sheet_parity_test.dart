import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/scheduler/rating_engine.dart';
import 'package:hs_coaching_core/scheduler/scheduler_models.dart';
import 'package:hs_coaching_core/scheduler/sheet_import.dart';

/// Vergelijkt de engine met het blad "Teamscheduler 4.1" op de export van
/// 2026-11-15 (166 wedstrijden). De fixture is een kopie zonder namen.
///
/// Eén gekende afwijking: in de kolom van 2026-06-20 deelt het blad de
/// wijziging door 12 in plaats van door de 7 spelers van de ploeg (lege
/// cellen tellen daar mee). De engine deelt door het echte aantal; de
/// spelers van die wedstrijd wijken daardoor hoogstens 2 punten af.
const _quirkGameDate = '2026-06-20';
const _exact = 1.01; // het blad toont afgeronde ratings
const _afterQuirk = 2.5;

/// Het blad toont de stand van "morgen" op de dag van de export.
const _asOf = '2026-11-16';

void main() {
  late SheetImport import;
  late RatingResult result;
  late Map<String, dynamic> json;

  setUpAll(() {
    json =
        jsonDecode(
              File(
                'test/scheduler/fixtures/teamscheduler_sheet.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;
    import = parseSheetExport(json);
    result = computeRatings(
      players: import.players,
      games: import.games,
      adjustments: import.adjustments,
      config: import.config,
      asOf: _asOf,
    );
  });

  test('de export bevat 80 spelers, 166 wedstrijden en 34 aanpassingen', () {
    expect(import.players, hasLength(80));
    expect(import.games, hasLength(166));
    expect(import.adjustments, hasLength(34));
    expect(import.compositions, hasLength(11));
    expect(import.config.rankTiers, hasLength(31));
    expect(result.games, hasLength(166));
  });

  test(
    'ploegsterkte, verwachting en relevantie per wedstrijd zoals het blad',
    () {
      final rawGames = json['games'] as List<dynamic>;
      for (var i = 0; i < rawGames.length; i++) {
        final sheet =
            (rawGames[i] as Map<String, dynamic>)['sheetComputed']
                as Map<String, dynamic>;
        final detail = result.games[i];
        final reason = 'game ${detail.game.id}';
        final tolerance = detail.game.date.compareTo(_quirkGameDate) > 0
            ? _afterQuirk
            : _exact;
        expect(
          detail.teamRatingWhite,
          closeTo(sheet['teamRatingWhite'] as num, tolerance),
          reason: reason,
        );
        expect(
          detail.teamRatingBlack,
          closeTo(sheet['teamRatingBlack'] as num, tolerance),
          reason: reason,
        );
        expect(
          detail.expectedWhite(import.config),
          closeTo(sheet['expectedWhite'] as num, 0.011),
          reason: reason,
        );
        expect(
          detail.relevance,
          closeTo(sheet['relevance'] as num, 0.0051),
          reason: reason,
        );
        if (detail.game.date != _quirkGameDate) {
          expect(
            detail.changeWhite,
            closeTo(sheet['changePerPlayerWhite'] as num, 0.51),
            reason: reason,
          );
          expect(
            detail.changeBlack,
            closeTo(sheet['changePerPlayerBlack'] as num, 0.51),
            reason: reason,
          );
        }
      }
    },
  );

  test('rating van elke speler vóór elke wedstrijd zoals het blad', () {
    var compared = 0;
    for (final detail in result.games) {
      final sheet = import.sheetRatingsBefore[detail.game.id]!;
      final tolerance = detail.game.date.compareTo(_quirkGameDate) > 0
          ? _afterQuirk
          : _exact;
      for (final entry in sheet.entries) {
        compared++;
        expect(
          detail.ratingsBefore[entry.key],
          closeTo(entry.value, tolerance),
          reason: 'game ${detail.game.id}, ${entry.key}',
        );
      }
    }
    expect(compared, 2398);
  });

  test('eindrating van elke speler-positie zoals het blad', () {
    final quirkGame = import.games.singleWhere((g) => g.date == _quirkGameDate);
    final inQuirkGame = {
      for (final entry in [
        ...quirkGame.white.entries,
        ...quirkGame.black.entries,
      ])
        entry.playerId,
    };
    expect(import.sheetRatings, hasLength(320));
    for (final entry in import.sheetRatings.entries) {
      expect(
        result.ratings[entry.key],
        closeTo(
          entry.value,
          inQuirkGame.contains(entry.key.playerId) ? _afterQuirk : _exact,
        ),
        reason: '${entry.key}',
      );
    }
  });

  test('speeltijd en doelpunten per speler-positie zoals het blad', () {
    for (final raw in json['players'] as List<dynamic>) {
      final player = raw as Map<String, dynamic>;
      final ratings = player['ratings'] as Map<String, dynamic>;
      for (final entry in ratings.entries) {
        final values = entry.value as Map<String, dynamic>;
        final minutes = values['experienceMinutes'] as num?;
        if (minutes == null) continue;
        final stats =
            result.stats[(
              playerId: player['index'] as String,
              position: PlayerPosition.fromCode(entry.key)!,
            )] ??
            const PositionStats();
        final reason = '${player['index']} ${entry.key}';
        expect(stats.minutes, minutes, reason: reason);
        expect(stats.goalsFor, values['goalsFor'], reason: reason);
        expect(stats.goalsAgainst, values['goalsAgainst'], reason: reason);
      }
    }
  });
}
