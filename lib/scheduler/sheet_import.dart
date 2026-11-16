import 'rating_config.dart';
import 'rating_engine.dart';
import 'scheduler_models.dart';

/// Inhoud van een export van het blad "Teamscheduler 4.1"
/// (`teamscheduler_export.json`, `schemaVersion` 1), omgezet naar de modellen
/// van de Team scheduler. Pure Dart: het bestand lezen gebeurt in de app.
class SheetImport {
  const SheetImport({
    required this.players,
    required this.adjustments,
    required this.games,
    required this.compositions,
    required this.teamNames,
    required this.config,
    required this.sheetRatings,
    required this.sheetRatingsBefore,
  });

  final List<SquadPlayer> players;
  final List<RatingAdjustment> adjustments;
  final List<PracticeGame> games;
  final List<TeamComposition> compositions;
  final List<String> teamNames;

  /// Rekenregels met de rangen uit de export en de eerste kolom van het blad.
  final RatingConfig config;

  /// Rating per speler-positie zoals het blad die toonde op het moment van
  /// de export. Alleen ter controle, wordt niet opgeslagen.
  final Map<RatingKey, double> sheetRatings;

  /// Per wedstrijd-id: de rating vóór de wedstrijd volgens het blad.
  final Map<String, Map<RatingKey, double>> sheetRatingsBefore;
}

/// De export kan niet gelezen worden.
class SheetImportException implements Exception {
  const SheetImportException(this.message);

  final String message;

  @override
  String toString() => 'SheetImportException: $message';
}

/// Versie van het exportformaat die deze code leest.
const int sheetExportSchemaVersion = 1;

/// Datum van de eerste, lege kolom in het blad (SHEET-1 in
/// `rating_engine.dart`).
const String sheetTimelineStart = '2022-02-01';

/// Zet de gedecodeerde JSON van een export om. Gooit een
/// [SheetImportException] bij een onbekende versie of ontbrekende velden.
SheetImport parseSheetExport(Map<String, dynamic> json) {
  final version = json['schemaVersion'];
  if (version != sheetExportSchemaVersion) {
    throw SheetImportException('Unsupported export version: $version');
  }
  try {
    return _parse(json);
  } on SheetImportException {
    rethrow;
  } on Object catch (error) {
    throw SheetImportException('Invalid export file: $error');
  }
}

SheetImport _parse(Map<String, dynamic> json) {
  final players = <SquadPlayer>[];
  final sheetRatings = <RatingKey, double>{};
  for (final raw in _list(json['players'])) {
    final id = raw['index'] as String;
    final startRatings = <PlayerPosition, int>{};
    final ratings = (raw['ratings'] as Map<String, dynamic>?) ?? const {};
    for (final entry in ratings.entries) {
      final position = _position(entry.key);
      final values = entry.value as Map<String, dynamic>;
      final start = values['start'] as num?;
      if (start == null) continue;
      startRatings[position] = start.round();
      final current = values['current'] as num?;
      if (current != null) {
        sheetRatings[(playerId: id, position: position)] = current.toDouble();
      }
    }
    players.add(
      SquadPlayer(
        id: id,
        firstName: (raw['firstName'] as String?) ?? '',
        surname: (raw['surname'] as String?) ?? '',
        nickname: (raw['nickname'] as String?) ?? '',
        totem: (raw['totem'] as String?) ?? '',
        active: (raw['active'] as bool?) ?? false,
        positions: [
          for (final code in (raw['positions'] as List<dynamic>? ?? const []))
            _position(code as String),
        ],
        startRatings: startRatings,
      ),
    );
  }

  final adjustments = <RatingAdjustment>[];
  var adjustmentNumber = 0;
  for (final raw in _list(json['adjustments'])) {
    adjustmentNumber++;
    adjustments.add(
      RatingAdjustment(
        id: 'sheet-${adjustmentNumber.toString().padLeft(3, '0')}',
        playerId: raw['playerIndex'] as String,
        type: switch (raw['type']) {
          'instant' => RatingAdjustmentType.instant,
          'linear' => RatingAdjustmentType.linear,
          final other => throw SheetImportException(
            'Unknown adjustment type: $other',
          ),
        },
        start: raw['start'] as String,
        end: raw['end'] as String,
        change: (raw['change'] as num).toDouble(),
        reason: (raw['reason'] as String?) ?? '',
      ),
    );
  }

  final games = <PracticeGame>[];
  final sheetRatingsBefore = <String, Map<RatingKey, double>>{};
  final gamesOnDate = <String, int>{};
  for (final raw in _list(json['games'])) {
    final date = raw['date'] as String;
    dayNumber(date);
    final number = gamesOnDate[date] = (gamesOnDate[date] ?? 0) + 1;
    final id = '$date-$number';
    final before = <RatingKey, double>{};

    GameSide side(Map<String, dynamic> rawSide) {
      List<LineupEntry> entries(String field) => [
        for (final rawEntry in _list(rawSide[field]))
          () {
            final entry = LineupEntry(
              playerId: rawEntry['player'] as String,
              position: _position(rawEntry['position'] as String),
            );
            final rating = rawEntry['sheetRatingBefore'] as num?;
            if (rating != null) {
              before[(playerId: entry.playerId, position: entry.position)] =
                  rating.toDouble();
            }
            return entry;
          }(),
      ];

      return GameSide(
        composition: (rawSide['composition'] as String?) ?? '',
        score: (rawSide['score'] as num).round(),
        base: entries('base'),
        subs: entries('subs'),
      );
    }

    games.add(
      PracticeGame(
        id: id,
        date: date,
        durationMinutes: (raw['durationMinutes'] as num).round(),
        white: side(raw['white'] as Map<String, dynamic>),
        black: side(raw['black'] as Map<String, dynamic>),
      ),
    );
    sheetRatingsBefore[id] = before;
  }

  final tiers = [
    for (final raw in _list(json['rankTiers']))
      RankTier(
        threshold: (raw['threshold'] as num).round(),
        name: raw['name'] as String,
        multiplier: (raw['multiplier'] as num).toDouble(),
      ),
  ];

  return SheetImport(
    players: players,
    adjustments: adjustments,
    games: games,
    compositions: [
      for (final raw in _list(json['compositions']))
        TeamComposition(
          name: raw['name'] as String,
          slots: [
            for (final code in raw['slots'] as List<dynamic>)
              _position(code as String),
          ],
        ),
    ],
    teamNames: [
      for (final name in (json['teams'] as List<dynamic>? ?? const []))
        name as String,
    ],
    config: RatingConfig(
      timelineStart: sheetTimelineStart,
      rankTiers: tiers.isEmpty ? defaultRankTiers : tiers,
    ),
    sheetRatings: sheetRatings,
    sheetRatingsBefore: sheetRatingsBefore,
  );
}

List<Map<String, dynamic>> _list(Object? value) => [
  for (final item in (value as List<dynamic>? ?? const []))
    item as Map<String, dynamic>,
];

PlayerPosition _position(String code) =>
    PlayerPosition.fromCode(code) ??
    (throw SheetImportException('Unknown position: $code'));
