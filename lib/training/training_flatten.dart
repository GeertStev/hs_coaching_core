import 'dart:math' as math;

import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_exercise.dart';
import 'package:hs_coaching_core/training/training_exercise_group.dart';
import 'package:hs_coaching_core/training/training_group.dart';
import 'package:hs_coaching_core/training/training_node.dart';
import 'package:hs_coaching_core/training/training_path.dart';
import 'package:hs_coaching_core/training/training_step.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

/// Slaat [training] plat tot een geordende lijst `TrainingStep`s — de
/// sessie-tijdlijn die de live-sessiecontroller (coach-app en display)
/// gebruikt. Rolt elke `TrainingGroup.repeatCount` uit tot losse herhaalde
/// substappen (zoals Tabata's rondes/sets), en itereert per oefening over
/// haar timing-rij(en) (`TrainingExercise.groups`). Een oefening met
/// `repeatCount > 1` wordt op dezelfde manier uitgerold: alle rijen, N keer
/// na elkaar, met een eigen (binnenste) `TrainingStepRepeat`.
///
/// Heeft een oefening twee of meer rijen (group split, bv. Hard/Easy), dan
/// lopen die tegelijk: één stap per herhaling, zo lang als de langste rij
/// (werk + rust), met de rijen in `TrainingStep.parallelGroups`.
///
/// Een enkele rij levert een werk-stap op (getimed als `workSeconds > 0`,
/// anders ongetimed) en een rust-stap als `restSeconds > 0`. Een rij met
/// enkel rust (`workSeconds == 0`, `restSeconds > 0`, bv. rust tussen twee
/// sets) levert alleen de rust-stap op: die loopt vanzelf af, de coach hoeft
/// dus niet eerst een ongetimede werk-stap weg te tikken. Een rij
/// zonder enige timing (workSeconds == restSeconds == 0, het normale "pure
/// reps/afstand"-geval) levert dus precies één ongetimede stap op, niet
/// twee, zodat de coach niet twee keer hoeft te tikken voor iets zonder
/// klok. Een oefening zonder timing-rijen (`groups` leeg) levert om dezelfde
/// reden ook precies één ongetimede stap op.
///
/// `deltaSeconds` verschuift `workSeconds` per iteratie van de dichtstbije
/// omringende herhaling (`repeatCount > 1`, de oefening zelf meegerekend) — zelfde idee als
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
  final repeatCount = exercise.repeatCount < 1 ? 1 : exercise.repeatCount;
  for (var iteration = 1; iteration <= repeatCount; iteration++) {
    _flattenExerciseOnce(
      exercise,
      path: path,
      repeats: repeatCount > 1
          ? [
              ...repeats,
              TrainingStepRepeat(
                groupId: exercise.id,
                groupTitle: 'Round',
                iteration: iteration,
                repeatCount: repeatCount,
              ),
            ]
          : repeats,
      siblingIndex: siblingIndex,
      siblingCount: siblingCount,
      into: into,
    );
  }
}

void _flattenExerciseOnce(
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

  // `null` = ongetimed; 0 = enkel rust (de rij rust meteen).
  int? workMillisFor(TrainingExerciseGroup row) {
    if (row.workSeconds <= 0) return row.restSeconds > 0 ? 0 : null;
    final deltaMillis = row.deltaSeconds * 1000 * (nearestIteration - 1);
    return math.max(row.workSeconds * 1000 + deltaMillis, 1000);
  }

  // Group split: twee of meer rijen lopen tegelijk, als één stap die zo lang
  // duurt als de langste rij (werk + rust van de getimede rijen).
  if (exercise.groups.length > 1) {
    final parallelGroups = [
      for (final row in exercise.groups)
        TrainingParallelGroup(
          name: row.name,
          parameterRows: row.parameterRows,
          workMillis: workMillisFor(row),
          restMillis: row.restSeconds * 1000,
        ),
    ];
    int? durationMillis;
    for (final group in parallelGroups) {
      final work = group.workMillis;
      if (work == null) continue;
      final total = work + group.restMillis;
      if (durationMillis == null || total > durationMillis) {
        durationMillis = total;
      }
    }
    into.add(
      TrainingStep(
        path: path,
        groupIndex: 0,
        phase: TrainingStepPhase.work,
        durationMillis: durationMillis,
        exerciseId: exercise.id,
        exerciseTitle: exercise.title,
        groupName: '',
        parameterRows: const [],
        repeats: repeats,
        siblingIndex: siblingIndex,
        siblingCount: siblingCount,
        parallelGroups: parallelGroups,
      ),
    );
    return;
  }

  final row = exercise.groups.single;
  if (_hasWorkStep(row)) {
    into.add(
      TrainingStep(
        path: path,
        groupIndex: 0,
        phase: TrainingStepPhase.work,
        durationMillis: workMillisFor(row),
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

  if (row.restSeconds > 0) {
    into.add(
      TrainingStep(
        path: path,
        groupIndex: 0,
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

/// Of een enkele rij een werk-stap oplevert: altijd, behalve bij enkel rust.
bool _hasWorkStep(TrainingExerciseGroup row) =>
    row.workSeconds > 0 || row.restSeconds <= 0;

/// Aantal stappen dat [flattenTraining] voor één herhaling van [exercise]
/// oplevert: 1 zonder rijen of bij een group split, anders werk (+ rust),
/// of enkel rust. Gebruikt door de weergavelaag (`display/display_steps.dart`)
/// om stappen aan een herhaling te koppelen.
int stepCountPerRepetition(TrainingExercise exercise) {
  if (exercise.groups.length != 1) return 1;
  final row = exercise.groups.single;
  return (_hasWorkStep(row) ? 1 : 0) + (row.restSeconds > 0 ? 1 : 0);
}
