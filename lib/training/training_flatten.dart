import 'dart:math' as math;

import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_exercise.dart';
import 'package:hs_coaching_core/training/training_group.dart';
import 'package:hs_coaching_core/training/training_node.dart';
import 'package:hs_coaching_core/training/training_path.dart';
import 'package:hs_coaching_core/training/training_step.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

/// Slaat [training] plat tot een geordende lijst `TrainingStep`s — de
/// sessie-tijdlijn die de live-sessiecontroller (coach-app en display)
/// gebruikt. Rolt elke `TrainingGroup.repeatCount` uit tot losse herhaalde
/// substappen (zoals Tabata's rondes/sets), en itereert per oefening over
/// haar timing-rijen (`TrainingExercise.groups`).
///
/// Elke rij levert altijd een werk-stap op (getimed als `workSeconds > 0`,
/// anders ongetimed) en alleen een rust-stap als `restSeconds > 0` — een rij
/// zonder enige timing (workSeconds == restSeconds == 0, het normale "pure
/// reps/afstand"-geval) levert dus precies één ongetimede stap op, niet
/// twee, zodat de coach niet twee keer hoeft te tikken voor iets zonder
/// klok. Een oefening zonder timing-rijen (`groups` leeg) levert om dezelfde
/// reden ook precies één ongetimede stap op.
///
/// `deltaSeconds` verschuift `workSeconds` per iteratie van de dichtstbije
/// omringende herhalende groep (`repeatCount > 1`) — zelfde idee als
/// Tabata's `stepSeconds`/`workSecondsForRound`, maar hier per timing-rij
/// i.p.v. per hele sessie. Heeft geen effect als `workSeconds == 0`: delta
/// verschuift een al-getimede duur, het vindt geen timing uit het niets uit.
List<TrainingStep> flattenTraining(Training training) {
  final steps = <TrainingStep>[];
  _flattenNodes(
    training.children,
    parentPath: const [],
    repeats: const [],
    into: steps,
  );
  return steps;
}

void _flattenNodes(
  List<TrainingNode> nodes, {
  required TrainingPath parentPath,
  required List<TrainingStepRepeat> repeats,
  required List<TrainingStep> into,
}) {
  for (var i = 0; i < nodes.length; i++) {
    final path = [...parentPath, i];
    switch (nodes[i]) {
      case TrainingNodeGroup(:final group):
        _flattenGroup(group, path: path, repeats: repeats, into: into);
      case TrainingNodeExercise(:final exercise):
        _flattenExercise(
          exercise,
          path: path,
          repeats: repeats,
          siblingIndex: i,
          siblingCount: nodes.length,
          into: into,
        );
    }
  }
}

void _flattenGroup(
  TrainingGroup group, {
  required TrainingPath path,
  required List<TrainingStepRepeat> repeats,
  required List<TrainingStep> into,
}) {
  final repeatCount = group.repeatCount < 1 ? 1 : group.repeatCount;
  for (var iteration = 1; iteration <= repeatCount; iteration++) {
    final childRepeats = repeatCount > 1
        ? [
            ...repeats,
            TrainingStepRepeat(
              groupId: group.id,
              groupTitle: group.title,
              iteration: iteration,
              repeatCount: repeatCount,
            ),
          ]
        : repeats;
    _flattenNodes(
      group.children,
      parentPath: path,
      repeats: childRepeats,
      into: into,
    );
  }
}

void _flattenExercise(
  TrainingExercise exercise, {
  required TrainingPath path,
  required List<TrainingStepRepeat> repeats,
  required int siblingIndex,
  required int siblingCount,
  required List<TrainingStep> into,
}) {
  if (exercise.groups.isEmpty) {
    into.add(
      TrainingStep(
        path: path,
        groupIndex: 0,
        phase: TrainingStepPhase.work,
        durationMillis: null,
        exerciseId: exercise.id,
        exerciseTitle: exercise.title,
        groupName: '',
        parameterRows: const [],
        repeats: repeats,
        siblingIndex: siblingIndex,
        siblingCount: siblingCount,
      ),
    );
    return;
  }

  final nearestIteration = repeats.isEmpty ? 1 : repeats.last.iteration;

  for (var groupIndex = 0; groupIndex < exercise.groups.length; groupIndex++) {
    final row = exercise.groups[groupIndex];
    final deltaMillis = row.deltaSeconds * 1000 * (nearestIteration - 1);
    final workMillis = row.workSeconds > 0
        ? math.max(row.workSeconds * 1000 + deltaMillis, 1000)
        : null;

    into.add(
      TrainingStep(
        path: path,
        groupIndex: groupIndex,
        phase: TrainingStepPhase.work,
        durationMillis: workMillis,
        exerciseId: exercise.id,
        exerciseTitle: exercise.title,
        groupName: row.name,
        parameterRows: row.parameterRows,
        repeats: repeats,
        siblingIndex: siblingIndex,
        siblingCount: siblingCount,
      ),
    );

    if (row.restSeconds > 0) {
      into.add(
        TrainingStep(
          path: path,
          groupIndex: groupIndex,
          phase: TrainingStepPhase.rest,
          durationMillis: row.restSeconds * 1000,
          exerciseId: exercise.id,
          exerciseTitle: exercise.title,
          groupName: row.name,
          parameterRows: row.parameterRows,
          repeats: repeats,
          siblingIndex: siblingIndex,
          siblingCount: siblingCount,
        ),
      );
    }
  }
}
