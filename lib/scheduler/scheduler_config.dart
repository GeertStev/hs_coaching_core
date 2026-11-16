import 'package:freezed_annotation/freezed_annotation.dart';

import 'scheduler_models.dart';

part 'scheduler_config.freezed.dart';
part 'scheduler_config.g.dart';

/// Alle getallen uit de ploegindeling van het Teamscheduler-blad (tabblad
/// "Scheduler"). De standaardwaarden zijn die van het blad; niets hiervan
/// staat elders in de code.
///
/// Pad (later): onderdeel van `clubs/{clubId}/schedulerConfig/default`.
@freezed
abstract class SchedulerConfig with _$SchedulerConfig {
  @JsonSerializable(explicitToJson: true)
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

    /// De opstellingen waaruit de trainer per ploeg kiest.
    @Default(defaultCompositions) List<TeamComposition> compositions,

    /// Ploegnamen in de volgorde waarin ze voorgesteld worden. Een oefen-
    /// wedstrijd is altijd de eerste tegen de tweede.
    @Default(defaultTeamNames) List<String> teamNames,
  }) = _SchedulerConfig;

  factory SchedulerConfig.fromJson(Map<String, dynamic> json) =>
      _$SchedulerConfigFromJson(json);
}

const _f = PlayerPosition.forward;
const _c = PlayerPosition.center;
const _w = PlayerPosition.wing;
const _g = PlayerPosition.goalie;

/// De opstellingen uit het tabblad "TeamComposition" van het blad.
const List<TeamComposition> defaultCompositions = [
  TeamComposition(name: '1-2-3', slots: [_f, _w, _w, _g, _g, _g]),
  TeamComposition(name: '1-3-2', slots: [_f, _w, _c, _w, _g, _g]),
  TeamComposition(name: '2-2-2', slots: [_f, _f, _w, _w, _g, _g]),
  TeamComposition(name: '2-1-3', slots: [_f, _f, _c, _g, _g, _g]),
  TeamComposition(name: '2-3-1', slots: [_f, _f, _c, _w, _w, _g]),
  TeamComposition(name: '3-1-2', slots: [_f, _f, _f, _c, _g, _g]),
  TeamComposition(name: '3-2-1', slots: [_f, _f, _f, _w, _w, _g]),
  TeamComposition(name: '3-3', slots: [_f, _f, _f, _w, _c, _w]),
  TeamComposition(name: '1-2-1', slots: [_f, _w, _w, _g]),
  TeamComposition(name: '1-3-1', slots: [_f, _c, _w, _w, _g]),
  TeamComposition(name: '2-2', slots: [_f, _f, _w, _w]),
];

/// De ploegnamen uit het blad.
const List<String> defaultTeamNames = [
  'White',
  'Black',
  'Lila',
  'Orca A',
  'Orca 1',
  'Holy Squid',
  'Guest',
];
