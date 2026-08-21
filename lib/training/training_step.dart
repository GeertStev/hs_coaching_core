import 'package:hs_coaching_core/training/training_parameter_row.dart';
import 'package:hs_coaching_core/training/training_path.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

/// Eén herhalings-context: welke iteratie van welke `TrainingGroup` een
/// stap in zit. Een stap kan door meerdere geneste herhalende groepen
/// omringd zijn (max-diepte-3 laat tot 2 geneste `TrainingGroup`-niveaus
/// boven een oefening toe) — `TrainingStep.repeats` bevat er dus voor elk
/// zo'n niveau (met `repeatCount > 1`) één, van buiten naar binnen.
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
  /// omringende groep een `repeatCount > 1` heeft.
  final List<TrainingStepRepeat> repeats;

  bool get isTimed => durationMillis != null;
}
