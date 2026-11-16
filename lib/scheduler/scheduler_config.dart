import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduler_config.freezed.dart';
part 'scheduler_config.g.dart';

/// Alle getallen uit de ploegindeling van het Teamscheduler-blad (tabblad
/// "Scheduler"). De standaardwaarden zijn die van het blad; niets hiervan
/// staat elders in de code.
///
/// Pad (later): onderdeel van `clubs/{clubId}/schedulerConfig/default`.
@freezed
abstract class SchedulerConfig with _$SchedulerConfig {
  const factory SchedulerConfig({
    /// Speeltijd waarmee de vermoeidheid en de verwachte score rekenen.
    @Default(30) int gameMinutes,

    /// Drempel voor een positie waar niemand meer bij kan: zo hoog dat geen
    /// enkele kandidaat nog boven nul uitkomt.
    @Default(100000) double blockedThreshold,

    /// Aftrek voor een speler-positie zonder rating (mag daar niet spelen of
    /// staat vast op een andere positie).
    @Default(10000) double noRatingPenalty,

    /// Bonus voor een schaarse positie: er zijn bijna evenveel vrije plaatsen
    /// als kandidaten (verschil hoogstens [scarcePositionMargin]).
    @Default(2000) double scarcePositionBonus,
    @Default(1) int scarcePositionMargin,

    /// Aftrek als de vrije plaatsen op de positie nodig zijn voor spelers die
    /// daar vast staan.
    @Default(10000) double reservedSlotPenalty,

    /// Onder deze score telt een kandidaat niet meer mee voor het gemiddelde
    /// en het aantal kandidaten van een positie.
    @Default(-5000) double candidateCutoff,

    /// Ervaring: aantal minuten waartegen de speeltijd op een positie wordt
    /// afgewogen.
    @Default(6000) double experienceMinutes,

    /// Het blad telt bij elke speeltijd dit kleine getal op, zodat er nooit
    /// door nul gedeeld wordt.
    @Default(0.01) double playtimeOffset,
  }) = _SchedulerConfig;

  factory SchedulerConfig.fromJson(Map<String, dynamic> json) =>
      _$SchedulerConfigFromJson(json);
}
