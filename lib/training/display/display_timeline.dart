import 'dart:math' as math;

import 'package:hs_coaching_core/training/display/display_step.dart';
import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_exercise.dart';
import 'package:hs_coaching_core/training/training_exercise_group.dart';
import 'package:hs_coaching_core/training/training_flatten.dart';
import 'package:hs_coaching_core/training/training_node.dart';

/// De weergavestappen van een training plus de koppeling vanuit de fijnere
/// `flattenTraining`-tijdlijn (waar `Training.currentStepIndex` in wijst).
class TrainingDisplayTimeline {
  TrainingDisplayTimeline(this.steps)
    : displayIndexByStep = [
        for (var i = 0; i < steps.length; i++)
          for (var k = 0; k < steps[i].stepCount; k++) i,
      ],
      _lengthsBefore = _cumulativeLengths(steps);

  final List<DisplayStep> steps;

  /// Per index in `flattenTraining`: de index van de weergavestap.
  final List<int> displayIndexByStep;

  final List<int> _lengthsBefore;

  /// Banen vóór het begin van weergavestap [displayIndex]; voorbij het einde
  /// het totaal.
  int lengthsBefore(int displayIndex) =>
      _lengthsBefore[displayIndex.clamp(0, steps.length)];

  int get totalLengths => _lengthsBefore.last;

  static List<int> _cumulativeLengths(List<DisplayStep> steps) {
    final result = <int>[0];
    for (final step in steps) {
      result.add(result.last + step.lengths);
    }
    return result;
  }
}

/// Slaat [training] plat tot weergavestappen: één per herhaling van elke
/// oefening, in dezelfde volgorde als `flattenTraining`. Pure Dart, getest in
/// `test/training/display/display_timeline_test.dart`.
TrainingDisplayTimeline buildDisplayTimeline(Training training) {
  final builder = _Builder();
  builder.walk(
    training.children,
    depth: 0,
    set: null,
    subset: null,
    nearestIteration: 1,
  );
  return TrainingDisplayTimeline(builder.steps);
}

class _Builder {
  final steps = <DisplayStep>[];
  var _nextStepIndex = 0;

  void walk(
    List<TrainingNode> nodes, {
    required int depth,
    required LevelPosition? set,
    required LevelPosition? subset,
    required int nearestIteration,
  }) {
    final exercises = [
      for (final node in nodes)
        if (node is TrainingNodeExercise) node.exercise,
    ];
    for (final node in nodes) {
      switch (node) {
        case TrainingNodeGroup(:final group):
          final count = math.max(1, group.repeatCount);
          for (var i = 0; i < count; i++) {
            final position = LevelPosition(
              nodeId: group.id,
              index: i,
              count: count,
            );
            walk(
              group.children,
              depth: depth + 1,
              set: depth == 0 ? position : set,
              subset: depth == 0 ? subset : position,
              nearestIteration: count > 1 ? i + 1 : nearestIteration,
            );
          }
        case TrainingNodeExercise(:final exercise):
          _addExercise(
            exercise,
            set: set,
            subset: subset,
            exercisePosition: LevelPosition(
              nodeId: exercise.id,
              index: exercises.indexOf(exercise),
              count: exercises.length,
            ),
            parentIteration: nearestIteration,
          );
      }
    }
  }

  void _addExercise(
    TrainingExercise exercise, {
    required LevelPosition? set,
    required LevelPosition? subset,
    required LevelPosition exercisePosition,
    required int parentIteration,
  }) {
    final count = math.max(1, exercise.repeatCount);
    int iterationFor(int repetition) =>
        count > 1 ? repetition : parentIteration;

    final firstRow = exercise.groups.isEmpty ? null : exercise.groups.first;
    final repetitionWork = [
      for (var r = 1; r <= count; r++)
        firstRow == null ? 0 : _workSeconds(firstRow, iterationFor(r)),
    ];
    final stepCount = stepCountPerRepetition(exercise);

    for (var r = 1; r <= count; r++) {
      steps.add(
        DisplayStep(
          path: DisplayStepPath(
            set: set,
            subset: subset,
            exercise: exercisePosition,
            repetition: LevelPosition(
              nodeId: exercise.id,
              index: r - 1,
              count: count,
            ),
          ),
          exerciseId: exercise.id,
          exerciseTitle: exercise.title,
          groups: [
            for (final row in exercise.groups)
              DisplayGroup(
                name: row.name,
                workSeconds: _workSeconds(row, iterationFor(r)),
                restSeconds: row.restSeconds,
                deltaSeconds: row.deltaSeconds,
                lines: row.parameterRows,
              ),
          ],
          repetitionWorkSeconds: repetitionWork,
          firstStepIndex: _nextStepIndex,
          stepCount: stepCount,
        ),
      );
      _nextStepIndex += stepCount;
    }
  }
}

/// Zelfde formule als `flattenTraining`: werk + (n − 1) × delta, minimaal
/// 1 s; 0 blijft 0 (ongetimed).
int _workSeconds(TrainingExerciseGroup row, int iteration) {
  if (row.workSeconds <= 0) return 0;
  return math.max(row.workSeconds + row.deltaSeconds * (iteration - 1), 1);
}
