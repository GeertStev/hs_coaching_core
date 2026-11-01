import 'package:hs_coaching_core/training/training_parameter_row.dart';

/// Positie op één niveau van het kruimelpad (Set, Subset, Oefening of
/// Herhaling): de hoeveelste ([index], 0-gebaseerd) van [count]. [nodeId] is
/// de id van de groep of oefening, zodat een tweede, andere set na een
/// eerste set als "nieuwe set" herkend wordt en niet als "set opnieuw".
class LevelPosition {
  const LevelPosition({
    required this.nodeId,
    required this.index,
    required this.count,
  });

  final String nodeId;
  final int index;
  final int count;

  @override
  bool operator ==(Object other) =>
      other is LevelPosition &&
      other.nodeId == nodeId &&
      other.index == index &&
      other.count == count;

  @override
  int get hashCode => Object.hash(nodeId, index, count);

  @override
  String toString() => '$nodeId ${index + 1}/$count';
}

/// Pad van een weergavestap. Set en Subset zijn positioneel: een groep op
/// root-niveau is de set, een groep daarin de subset; `null` als de oefening
/// niet in zo'n groep zit (bv. een warmup los op root). Hun index/aantal
/// komt uit de herhaling van die groep (`TrainingGroup.repeatCount`).
/// [exercise] is de positie tussen de oefeningen van dezelfde ouder,
/// [repetition] de herhaling van de oefening (`TrainingExercise.repeatCount`).
class DisplayStepPath {
  const DisplayStepPath({
    required this.set,
    required this.subset,
    required this.exercise,
    required this.repetition,
  });

  final LevelPosition? set;
  final LevelPosition? subset;
  final LevelPosition exercise;
  final LevelPosition repetition;

  @override
  String toString() =>
      'set: $set, subset: $subset, '
      'exercise: $exercise, repetition: $repetition';
}

/// Eén timing-rij van een weergavestap, met de werktijd van déze herhaling.
class DisplayGroup {
  const DisplayGroup({
    required this.name,
    required this.workSeconds,
    required this.restSeconds,
    required this.deltaSeconds,
    required this.lines,
  });

  final String name;

  /// Werktijd in deze herhaling (delta toegepast, minimaal 1 s); 0 =
  /// ongetimed.
  final int workSeconds;
  final int restSeconds;
  final int deltaSeconds;
  final List<TrainingParameterRow> lines;

  /// Aantal banen: de som van `reps` over de lijnen (afstand telt niet mee).
  int get lengths => lines.fold(0, (sum, line) => sum + (line.reps ?? 0));
}

/// Eén stap zoals het zwembadscherm hem toont: één herhaling van één
/// oefening, met werk én rust samen (de fijnere `TrainingStep`-tijdlijn
/// splitst die in aparte fases). Een group split heeft twee [groups] die
/// tegelijk lopen.
class DisplayStep {
  const DisplayStep({
    required this.path,
    required this.exerciseId,
    required this.exerciseTitle,
    required this.groups,
    required this.repetitionWorkSeconds,
    required this.firstStepIndex,
    required this.stepCount,
  });

  final DisplayStepPath path;
  final String exerciseId;
  final String exerciseTitle;
  final List<DisplayGroup> groups;

  /// Werktijd van de eerste rij per herhaling van de oefening (voor de
  /// herhalingstrack); evenveel waarden als `path.repetition.count`.
  final List<int> repetitionWorkSeconds;

  /// Index in `flattenTraining` van de eerste fase van deze stap, en het
  /// aantal fases (werk, rust) dat erbij hoort.
  final int firstStepIndex;
  final int stepCount;

  bool get isGroupSplit => groups.length > 1;

  /// Banen van deze stap; bij een group split telt de groep met de meeste.
  int get lengths {
    var max = 0;
    for (final group in groups) {
      if (group.lengths > max) max = group.lengths;
    }
    return max;
  }
}
