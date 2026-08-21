import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/training/training_node.dart';
import 'package:hs_coaching_core/training/training_path.dart';
import 'package:hs_coaching_core/training/training_status.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

part 'training.freezed.dart';
part 'training.g.dart';

/// De root van de Training-feature: één huidige training per display-
/// document (`settings/training`), net als `Chrono`/`Tabata` — geen
/// aparte kaart-collectie, geen "current id"-indirectie. [children] zijn
/// [TrainingNode]s (losse oefeningen of groepen, elke groep kan zelf weer
/// [TrainingNode]-kinderen bevatten) — zie `training_validation.dart` voor
/// de runtime max-diepte-3-invariant die het type zelf niet meer afdwingt.
///
/// [status]..[currentPhase] (runtime-status) staan in hetzelfde document als
/// [children] (configuratie), zelfde reden als Chrono/Tabata — zie
/// `chrono.dart`/`tabata.dart`. In tegenstelling tot Tabata kan de huidige
/// positie NIET zuiver uit verstreken tijd + boomvorm worden afgeleid:
/// `TrainingExerciseGroup.workSeconds`/`restSeconds` mogen legitiem 0 blijven
/// (bv. een zuivere reps/afstand-set als "4x50m crawl, rust naar eigen
/// inzicht"), en zo'n stap heeft dus geen klok om op te wachten. Vandaar
/// [currentPath]/[currentGroupIndex]/[currentPhase] als expliciete pointer
/// i.p.v. een afgeleide waarde — zie `training_flatten.dart`
/// (`flattenTraining`, de platte sessie-tijdlijn van `TrainingStep`s) en
/// `training_navigation.dart` (`nextStepPointer`/`previousStepPointer`) voor
/// hoe die pointer verplaatst wordt.
///
/// Getimede stappen tellen automatisch af en schuiven vanzelf door — de
/// coach-app's `TrainingScreenController` roept zelf `next` aan zodra de
/// tijd om is, klokdrift-gecorrigeerd via RTDB's `.info/serverTimeOffset`
/// net als Chrono/Tabata (nooit de data zelf in RTDB). Ongetimede stappen
/// wachten op een handmatige "volgende"-druk van de coach — de sessie kan
/// daar niet zelf voorbij tikken. Next/previous zijn ook tijdens een
/// getimede stap altijd handmatig te gebruiken (o.a. om vroegtijdig af te
/// breken); previous herstart steeds de klok van de stap waar je op
/// terugkomt.
@freezed
abstract class Training with _$Training {
  @JsonSerializable(explicitToJson: true)
  const factory Training({
    @Default(<TrainingNode>[]) List<TrainingNode> children,

    // --- Runtime status (Firestore, zelfde document als configuratie) ---
    @Default(TrainingStatus.idle) TrainingStatus status,

    /// Start moment van de huidige stap, expressed in RTDB server-clock
    /// milliseconds (zie `serverNowMillis` in
    /// `core/providers/server_time_offset_provider.dart`).
    @Default(0) int authoritativeStartTimeMillis,

    /// Tijd geaccumuleerd binnen de huidige stap vóór de lopende sessie —
    /// zelfde pauze-boekhouding als Chrono/Tabata.
    @Default(0) int accumulatedElapsedMillis,

    /// Pad naar de huidige `TrainingNode` (altijd een oefening — een groep
    /// zelf is nooit "de huidige stap"). Leeg zolang de sessie nog niet
    /// gestart is.
    @Default(<int>[]) TrainingPath currentPath,

    /// Index van de huidige `TrainingExerciseGroup`-rij binnen de oefening
    /// op [currentPath] — een oefening kan tot `kMaxTrainingExerciseGroups`
    /// timing-rijen hebben, elk een eigen (mogelijk ongetimede) stap.
    @Default(0) int currentGroupIndex,

    /// Werk- of rustfase binnen die timing-rij.
    @Default(TrainingStepPhase.work) TrainingStepPhase currentPhase,
  }) = _Training;

  factory Training.fromJson(Map<String, dynamic> json) =>
      _$TrainingFromJson(json);
}
