import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduler_models.freezed.dart';
part 'scheduler_models.g.dart';

/// Positie in het water. De code (F, C, W, G) is ook de waarde in JSON en
/// in de sleutel "speler-positie" van het oude Teamscheduler-blad.
enum PlayerPosition {
  @JsonValue('F')
  forward('F', 'Forward'),
  @JsonValue('C')
  center('C', 'Center'),
  @JsonValue('W')
  wing('W', 'Wing'),
  @JsonValue('G')
  goalie('G', 'Goalie');

  const PlayerPosition(this.code, this.label);

  final String code;
  final String label;

  /// Positie bij een code uit het blad, of `null` bij een onbekende code.
  static PlayerPosition? fromCode(String code) {
    for (final position in values) {
      if (position.code == code) return position;
    }
    return null;
  }
}

/// Een speler in de spelerslijst van de club (Team scheduler).
///
/// Pad: `clubs/{clubId}/players/{playerId}`. Staat los van de app-leden
/// (`members/{uid}`): gasten en spelers zonder account doen ook mee.
/// [uid] koppelt de speler optioneel aan een lid.
///
/// De rating zelf staat nergens opgeslagen: die volgt uit [startRatings],
/// het wedstrijdlog en de aanpassingen (`rating_engine.dart`).
@freezed
abstract class SquadPlayer with _$SquadPlayer {
  const factory SquadPlayer({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String id,
    required String firstName,
    @Default('') String surname,
    @Default('') String nickname,
    @Default('') String totem,
    @Default(true) bool active,

    /// Posities waarop de scheduler deze speler mag zetten.
    @Default(<PlayerPosition>[]) List<PlayerPosition> positions,

    /// Startrating per positie. Een positie zonder startrating heeft geen
    /// rating en doet niet mee in de berekening.
    @Default(<PlayerPosition, int>{}) Map<PlayerPosition, int> startRatings,
    String? uid,
  }) = _SquadPlayer;

  const SquadPlayer._();

  factory SquadPlayer.fromJson(Map<String, dynamic> json) =>
      _$SquadPlayerFromJson(json);

  /// Naam in lijsten en op het scherm: de bijnaam als die er is.
  String get displayName => nickname.isNotEmpty ? nickname : firstName;
}

/// Soort handmatige aanpassing van een rating.
enum RatingAdjustmentType {
  /// De hele wijziging in één keer.
  instant,

  /// De wijziging gelijk verdeeld over de dagen tussen begin en einde.
  linear,
}

/// Handmatige aanpassing (blessure, nieuwe speler, terugkeer...). Geldt voor
/// alle posities van de speler.
///
/// Pad: `clubs/{clubId}/ratingAdjustments/{id}`. Datums zijn kalenderdagen
/// als `yyyy-MM-dd`, zonder tijdzone.
@freezed
abstract class RatingAdjustment with _$RatingAdjustment {
  const factory RatingAdjustment({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String id,
    required String playerId,
    required RatingAdjustmentType type,
    required String start,
    required String end,
    required double change,
    @Default('') String reason,
  }) = _RatingAdjustment;

  factory RatingAdjustment.fromJson(Map<String, dynamic> json) =>
      _$RatingAdjustmentFromJson(json);
}

/// Eén speler op één positie in een opstelling.
@freezed
abstract class LineupEntry with _$LineupEntry {
  const factory LineupEntry({
    required String playerId,
    required PlayerPosition position,
  }) = _LineupEntry;

  factory LineupEntry.fromJson(Map<String, dynamic> json) =>
      _$LineupEntryFromJson(json);
}

/// Eén ploeg in een gespeelde oefenwedstrijd.
@freezed
abstract class GameSide with _$GameSide {
  @JsonSerializable(explicitToJson: true)
  const factory GameSide({
    /// Naam van de opstelling, bv. "2-3-1".
    @Default('') String composition,
    required int score,

    /// Spelers die de hele tijd in het water liggen.
    @Default(<LineupEntry>[]) List<LineupEntry> base,

    /// Wissels: delen de speeltijd op hun positie met de basisspelers.
    @Default(<LineupEntry>[]) List<LineupEntry> subs,
  }) = _GameSide;

  const GameSide._();

  factory GameSide.fromJson(Map<String, dynamic> json) =>
      _$GameSideFromJson(json);

  /// Basisspelers en wissels samen.
  List<LineupEntry> get entries => [...base, ...subs];
}

/// Eén gespeelde oefenwedstrijd in het wedstrijdlog.
///
/// Pad: `clubs/{clubId}/practiceGames/{gameId}`. Het log is de bron van alle
/// ratings en statistieken; een score verbeteren herrekent alles.
@freezed
abstract class PracticeGame with _$PracticeGame {
  @JsonSerializable(explicitToJson: true)
  const factory PracticeGame({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String id,

    /// Kalenderdag als `yyyy-MM-dd`.
    required String date,
    required int durationMinutes,
    required GameSide white,
    required GameSide black,
  }) = _PracticeGame;

  factory PracticeGame.fromJson(Map<String, dynamic> json) =>
      _$PracticeGameFromJson(json);
}

/// Een opstelling: welke positie op elke plaats in het water ligt.
@freezed
abstract class TeamComposition with _$TeamComposition {
  const factory TeamComposition({
    required String name,
    required List<PlayerPosition> slots,
  }) = _TeamComposition;

  factory TeamComposition.fromJson(Map<String, dynamic> json) =>
      _$TeamCompositionFromJson(json);
}

/// Dagnummer van een kalenderdag `yyyy-MM-dd` (dagen sinds 1970-01-01).
/// Gooit een [FormatException] bij een ongeldige datum.
int dayNumber(String isoDate) {
  final parts = isoDate.split('-');
  if (parts.length != 3) {
    throw FormatException('Invalid date, expected yyyy-MM-dd', isoDate);
  }
  final year = int.parse(parts[0]);
  final month = int.parse(parts[1]);
  final day = int.parse(parts[2]);
  final date = DateTime.utc(year, month, day);
  if (date.year != year || date.month != month || date.day != day) {
    throw FormatException('Invalid date, expected yyyy-MM-dd', isoDate);
  }
  return date.millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;
}
