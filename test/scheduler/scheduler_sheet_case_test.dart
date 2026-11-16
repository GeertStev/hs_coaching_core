import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/scheduler/rating_config.dart';
import 'package:hs_coaching_core/scheduler/scheduler_models.dart';
import 'package:hs_coaching_core/scheduler/team_scheduler.dart';

/// Vergelijkt `scheduleTeams` stap voor stap met het tabblad "Scheduler" van
/// een kopie van het blad (14 aanwezigen, twee keer 2-3-1 met één wissel op
/// de vleugel). De fixture bevat alleen indexen en getallen.
void main() {
  final json =
      jsonDecode(
            File(
              'test/scheduler/fixtures/scheduler_case_2026-11-16.json',
            ).readAsStringSync(),
          )
          as Map<String, dynamic>;
  PlayerPosition position(Object? code) =>
      PlayerPosition.fromCode(code! as String)!;

  final ratings = <String, Map<PlayerPosition, int>>{
    for (final raw in (json['players'] as List).cast<Map<String, dynamic>>())
      raw['player'] as String: {
        for (final entry in (raw['ratings'] as Map<String, dynamic>).entries)
          if (entry.value != 0) position(entry.key): entry.value as int,
      },
  };
  final players = [
    for (final entry in ratings.entries)
      SquadPlayer(
        id: entry.key,
        firstName: entry.key,
        positions: entry.value.keys.toList(),
        startRatings: entry.value,
      ),
  ];
  final teams = [
    for (final raw in (json['teams'] as List).cast<Map<String, dynamic>>())
      TeamSetup(
        name: raw['name'] as String,
        slots: [for (final code in raw['slots'] as List) position(code)],
        substitutes: {
          for (final entry
              in (raw['substitutes'] as Map<String, dynamic>).entries)
            position(entry.key): entry.value as int,
        },
      ),
  ];
  final expected = (json['picks'] as List).cast<Map<String, dynamic>>();
  const config = RatingConfig();

  final result = scheduleTeams(
    teams: teams,
    attendees: [for (final p in players) Attendee(playerId: p.id)],
    players: players,
    ratingOf: (id, position) => ratings[id]?[position]?.toDouble(),
  );

  test('dezelfde speler, positie en ploeg in elke stap als het blad', () {
    expect(
      [
        for (final p in result.picks)
          '${p.playerId} ${p.position.code} ${p.team}',
      ],
      [
        for (final p in expected)
          '${p['player']} ${p['position']} ${p['team']}',
      ],
    );
    expect(result.unassigned, isEmpty);
  });

  test('ploegsterkte, winstkans en vergelijking per positie als het blad', () {
    final white = result.teams[0];
    final black = result.teams[1];
    expect(white.rating(config) * 6, closeTo(expected.last['white'] as int, 1));
    expect(black.rating(config) * 6, closeTo(expected.last['black'] as int, 1));
    expect(white.rating(config), closeTo(json['teamRatingWhite'] as int, 1));
    expect(black.rating(config), closeTo(json['teamRatingBlack'] as int, 1));
    expect(
      winChance(white, black, config),
      closeTo(json['winChanceWhite'] as double, 0.001),
    );
    final advantage = json['positionAdvantageWhite'] as Map<String, dynamic>;
    for (final entry in advantage.entries) {
      expect(
        positionAdvantage(white, black, position(entry.key), config),
        closeTo(entry.value as double, 0.006),
        reason: entry.key,
      );
    }
    // De wissel is de derde keuze op de vleugel.
    expect(white.subs.single.playerId, '006');
    expect(black.subs.single.playerId, '022');
  });
}
