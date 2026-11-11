import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/match/engine/duration_millis_converter.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';

part 'match_config.freezed.dart';
part 'match_config.g.dart';

/// Hoe de straftijd loopt tijdens time-outs, officials' time-outs en de rust.
///
/// OPEN-2: default aanvaard, nog niet nagevraagd bij scheidsrechters.
enum PenaltyClockPolicy {
  /// Straftijd loopt alleen als de wedstrijdklok loopt (default).
  matchClockOnly,

  /// Straftijd loopt vanaf de eerste herstart gewoon door, ook als de
  /// wedstrijdklok stilstaat. Alleen een strafworp zet ze stil (17.8.7).
  wallClock,
}

/// Alle instelbare waarden van één wedstrijd (02-match-engine.md §2).
///
/// De defaults zijn CMAS v13. Dit is de **enige** plek in de engine waar
/// duren als getal staan: toernooien wijken af (OPEN-5), dus de rest van de
/// engine leest alles uit deze config. De effectieve config wordt als
/// snapshot in `MatchCreated` bewaard.
@freezed
abstract class MatchConfig with _$MatchConfig {
  const MatchConfig._();

  @JsonSerializable(explicitToJson: true)
  const factory MatchConfig({
    @DurationMillisConverter()
    @Default(Duration(minutes: 15))
    Duration periodLength,
    @DurationMillisConverter()
    @Default(Duration(minutes: 3))
    Duration halfTimeBreak,

    /// Poule = false, knock-out = true.
    @Default(false) bool requiresWinner,
    @DurationMillisConverter()
    @Default(Duration(minutes: 3))
    Duration overtimeBreak,
    @DurationMillisConverter()
    @Default(Duration(minutes: 5))
    Duration overtimePeriod,
    @DurationMillisConverter()
    @Default(Duration(minutes: 1))
    Duration overtimeInterval,
    @DurationMillisConverter()
    @Default(Duration(minutes: 1))
    Duration suddenDeathBreak,

    /// Venster op het einde van een fase waarin de klok bij elke
    /// onderbreking stilstaat (14.2.3.1).
    @DurationMillisConverter()
    @Default(Duration(minutes: 2))
    Duration stoppedClockWindow,
    @DurationMillisConverter()
    @Default(Duration(minutes: 1))
    Duration teamTimeOutLength,

    /// Verstreken tijd van een team time-out waarop de waarschuwing klinkt.
    @DurationMillisConverter()
    @Default(Duration(seconds: 45))
    Duration timeOutWarningAt,
    @DurationMillisConverter()
    @Default(Duration(seconds: 30))
    Duration periodStartWarning,
    @DurationMillisConverter()
    @Default(Duration(seconds: 30))
    Duration goalRestartMax,
    @Default(1) int timeOutsPerTeamPerHalf,

    /// OPEN-2.
    @Default(PenaltyClockPolicy.matchClockOnly)
    PenaltyClockPolicy penaltyClockPolicy,
    @Default('CMAS-13.0') String rulesVersion,

    /// OPEN-1: fases waarin het stilgezette-klokvenster geldt. Sudden death
    /// staat altijd in stilgezette-klokmodus, ook als het hier ontbreekt.
    @Default({MatchPhase.p2, MatchPhase.ot2, MatchPhase.suddenDeath})
    Set<MatchPhase> stoppedClockPhases,

    /// OPEN-10: 2 (CMAS) of 0; enkel relevant als [requiresWinner].
    @Default(2) int overtimePeriods,

    /// OPEN-10.
    @Default(true) bool suddenDeathEnabled,

    /// Vrij label, enkel voor weergave.
    @Default('CMAS standaard') String presetName,
  }) = _MatchConfig;

  factory MatchConfig.fromJson(Map<String, dynamic> json) =>
      _$MatchConfigFromJson(json);

  /// Duur van een speelfase, of `null` voor sudden death en niet-speelfases.
  Duration? playLength(MatchPhase phase) => switch (phase) {
    MatchPhase.p1 || MatchPhase.p2 => periodLength,
    MatchPhase.ot1 || MatchPhase.ot2 => overtimePeriod,
    _ => null,
  };

  /// Duur van een pauzefase, of `null` voor de andere fases.
  Duration? breakLength(MatchPhase phase) => switch (phase) {
    MatchPhase.halfTime => halfTimeBreak,
    MatchPhase.otBreak => overtimeBreak,
    MatchPhase.otInterval => overtimeInterval,
    MatchPhase.sdBreak => suddenDeathBreak,
    _ => null,
  };
}
