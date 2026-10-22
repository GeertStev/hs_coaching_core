import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/training/training_node.dart';
import 'package:hs_coaching_core/training/training_status.dart';

part 'training.freezed.dart';
part 'training.g.dart';

/// De root van de Training-feature: één huidige training per display-
/// document (`settings/training`), net als `Chrono`/`Tabata` — geen
/// aparte kaart-collectie, geen "current id"-indirectie. [children] zijn
/// [TrainingNode]s (losse oefeningen of groepen, elke groep kan zelf weer
/// [TrainingNode]-kinderen bevatten) — zie `training_validation.dart` voor
/// de runtime max-diepte-3-invariant die het type zelf niet meer afdwingt.
///
/// [status]..[currentStepIndex] (runtime-status) staan in hetzelfde document
/// als [children] (configuratie), zelfde reden als Chrono/Tabata — zie
/// `chrono.dart`/`tabata.dart`.
///
/// De positie is een combinatie van een expliciete stap-pointer en verstreken
/// tijd. [currentStepIndex] is het "anker": de index in de platgeslagen
/// tijdlijn (`flattenTraining`) waar de klok voor het laatst (her)startte.
/// Vanaf dat anker loopt `computeTrainingProgress` met de verstreken tijd
/// zelf door de opeenvolgende getimede stappen, net als Tabata — zowel de
/// coach-app als de display rekenen dat lokaal uit, dus de sessie loopt door
/// ook als de tablet slaapt. Een ongetimede stap
/// (`TrainingExerciseGroup.workSeconds == 0`, bv. "4x50m crawl, rust naar
/// eigen inzicht") heeft geen klok: daar stopt het doorrekenen en wacht de
/// sessie op een handmatige "volgende" van de coach, die het anker verzet.
///
/// Een index (i.p.v. een pad in de boom) is nodig omdat dezelfde oefening in
/// elke herhaling van een `TrainingGroup` opnieuw voorkomt: alleen de index
/// onderscheidt ronde 1 van ronde 2. Next/previous verzetten het anker en
/// herstarten de klok; previous herstart steeds de stap waar je op terugkomt.
@freezed
abstract class Training with _$Training {
  @JsonSerializable(explicitToJson: true)
  const factory Training({
    @Default(<TrainingNode>[]) List<TrainingNode> children,

    // --- Runtime status (Firestore, zelfde document als configuratie) ---
    @Default(TrainingStatus.idle) TrainingStatus status,

    /// Start moment van de lopende run vanaf [currentStepIndex], expressed in RTDB server-clock
    /// milliseconds (zie `serverNowMillis` in
    /// `core/providers/server_time_offset_provider.dart`).
    @Default(0) int authoritativeStartTimeMillis,

    /// Tijd geaccumuleerd sinds [currentStepIndex] vóór de lopende run —
    /// zelfde pauze-boekhouding als Chrono/Tabata.
    @Default(0) int accumulatedElapsedMillis,

    /// Index in `flattenTraining(this)` van de stap waar de klok voor het
    /// laatst (her)startte — zie de doc comment hierboven. `-1` zolang de
    /// sessie nog niet gestart is.
    @Default(-1) int currentStepIndex,
  }) = _Training;

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
}
