import 'package:hs_coaching_core/training/training_parameter_row.dart';
import 'package:hs_coaching_core/training/training_path.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

/// Eén herhalings-context: welke iteratie van welke `TrainingGroup` (of van
/// de oefening zelf, via `TrainingExercise.repeatCount`) een stap in zit.
/// Een stap kan door meerdere geneste herhalende groepen omringd zijn
/// (max-diepte-3 laat tot 2 geneste `TrainingGroup`-niveaus boven een
/// oefening toe) — `TrainingStep.repeats` bevat er dus voor elk zo'n niveau
/// (met `repeatCount > 1`) één, van buiten naar binnen; een herhalende
/// oefening komt als binnenste niveau achteraan, met [groupId] = de id van
/// de oefening en [groupTitle] `'Round'`.
class TrainingStepRepeat {
  const TrainingStepRepeat({
    required this.groupId,
    required this.groupTitle,
    required this.iteration,
    required this.repeatCount,
  });

  final String groupId;
  final String? groupTitle;

  /// 1-gebaseerd: welke herhaling dit is.
  final int iteration;
  final int repeatCount;
}

/// Eén stap in de platgeslagen sessie-tijdlijn van een `Training` — zie
/// `training_flatten.dart`'s `flattenTraining`. Bevat genoeg context om
/// zowel de coach-controls als de display te renderen zonder terug de boom
/// in te hoeven.
class TrainingStep {
  const TrainingStep({
    required this.path,
    required this.groupIndex,
    required this.phase,
    required this.durationMillis,
    required this.exerciseId,
    required this.exerciseTitle,
    required this.groupName,
    required this.parameterRows,
    required this.repeats,
    required this.siblingIndex,
    required this.siblingCount,
    this.parallelGroups = const [],
  });

  final TrainingPath path;
  final int groupIndex;
  final TrainingStepPhase phase;

  /// `null` = ongetimed: deze stap heeft geen klok om op te wachten en
  /// vereist een handmatige "volgende"-druk van de coach.
  final int? durationMillis;

  final String exerciseId;
  final String exerciseTitle;

  /// Naam van de timing-rij (`TrainingExerciseGroup.name`) — leeg zolang de
  /// oefening maar één rij heeft, zie `training_exercise_group.dart`.
  final String groupName;
  final List<TrainingParameterRow> parameterRows;

  /// Herhalings-context van buiten naar binnen; leeg als geen enkele
  /// omringende groep (of de oefening zelf) een `repeatCount > 1` heeft.
  final List<TrainingStepRepeat> repeats;

  /// 0-gebaseerde positie van de oefening binnen haar ouder (de omringende
  /// groep, of de root) — de "Stap x/y" binnen een set. Alle timing-rijen en
  /// werk/rust-fases van één oefening delen dezelfde waarde.
  final int siblingIndex;

  /// Aantal kinderen (oefeningen + subgroepen) van die ouder.
  final int siblingCount;

  /// Gevuld zodra de oefening twee of meer timing-rijen heeft (een "group
  /// split", bv. Hard/Easy): die rijen lopen **tegelijk**, elk met een eigen
  /// werk/rust, en de stap duurt zo lang als de langste rij (werk + rust).
  /// Zo'n stap is dan altijd [TrainingStepPhase.work] met [groupName] leeg
  /// en [parameterRows] leeg — de fase en resterende tijd per rij volgen uit
  /// [parallelGroupStatesAt]. Leeg voor een gewone oefening met één rij.
  final List<TrainingParallelGroup> parallelGroups;

  bool get isTimed => durationMillis != null;
  bool get isGroupSplit => parallelGroups.isNotEmpty;
}

/// Eén rij van een group split-stap, zie [TrainingStep.parallelGroups].
class TrainingParallelGroup {
  const TrainingParallelGroup({
    required this.name,
    required this.parameterRows,
    required this.workMillis,
    required this.restMillis,
  });

  final String name;
  final List<TrainingParameterRow> parameterRows;

  /// Werktijd in deze herhaling (delta al toegepast); `null` = ongetimed.
  final int? workMillis;
  final int restMillis;
}

/// Fase en resterende tijd van één [TrainingParallelGroup] op een moment.
class TrainingParallelGroupState {
  const TrainingParallelGroupState({
    required this.phase,
    required this.remainingMillis,
  });

  final TrainingStepPhase phase;

  /// `null` = ongetimed (de rij wacht op de coach).
  final int? remainingMillis;
}

/// Leidt per rij van een group split-stap de fase af uit de verstreken tijd
/// binnen de stap: eerst werk, daarna rust tot de stap om is. Een kortere
/// rij rust dus langer dan haar eigen rusttijd, tot de langste rij klaar is.
List<TrainingParallelGroupState> parallelGroupStatesAt(
  TrainingStep step,
  int elapsedInStepMillis,
) {
  final stepDuration = step.durationMillis;
  return [
    for (final group in step.parallelGroups)
      if (group.workMillis == null || stepDuration == null)
        const TrainingParallelGroupState(
          phase: TrainingStepPhase.work,
          remainingMillis: null,
        )
      else if (elapsedInStepMillis < group.workMillis!)
        TrainingParallelGroupState(
          phase: TrainingStepPhase.work,
          remainingMillis: group.workMillis! - elapsedInStepMillis,
        )
      else
        TrainingParallelGroupState(
          phase: TrainingStepPhase.rest,
          remainingMillis: stepDuration - elapsedInStepMillis < 0
              ? 0
              : stepDuration - elapsedInStepMillis,
        ),
  ];
}
