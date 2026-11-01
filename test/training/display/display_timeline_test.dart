import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/display/display_step.dart';
import 'package:hs_coaching_core/training/display/display_timeline.dart';
import 'package:hs_coaching_core/training/display/display_transition.dart';
import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_exercise_group.dart';
import 'package:hs_coaching_core/training/training_flatten.dart';
import 'package:hs_coaching_core/training/training_parameter_row.dart';

import 'example_training.dart';

/// (set, subset, oefening, herhaling) 1-gebaseerd, null = niet in het pad;
/// zelfde vorm als de tabel in spec §3.5 en `check_steps.py`.
List<int?> _key(DisplayStep step) => [
  step.path.set == null ? null : step.path.set!.index + 1,
  step.path.subset == null ? null : step.path.subset!.index + 1,
  step.path.exercise.index + 1,
  step.path.repetition.index + 1,
];

void main() {
  group('voorbeeldstructuur (spec §3.5)', () {
    final timeline = buildDisplayTimeline(exampleTraining);
    final steps = timeline.steps;

    test('19 stappen met de paden uit de tabel', () {
      expect(steps, hasLength(19));
      expect(steps.map(_key).toList(), [
        [null, null, 1, 1], // 1 warmup
        [1, null, 1, 1], // 2 set 1, group split
        [1, 1, 1, 1],
        [1, 1, 1, 2],
        [1, 1, 2, 1],
        [1, 1, 2, 2],
        [1, 2, 1, 1],
        [1, 2, 1, 2],
        [1, 2, 2, 1],
        [1, 2, 2, 2], // 10
        [2, null, 1, 1], // 11 set 2, group split
        [2, 1, 1, 1],
        [2, 1, 1, 2],
        [2, 1, 2, 1],
        [2, 1, 2, 2],
        [2, 2, 1, 1],
        [2, 2, 1, 2],
        [2, 2, 2, 1],
        [2, 2, 2, 2],
      ]);
      expect(steps[0].exerciseTitle, 'Warmup');
      expect(steps[1].isGroupSplit, isTrue);
      expect(steps[10].isGroupSplit, isTrue);
    });

    test('overgangen zoals in de tabel', () {
      final transitions = [
        for (var i = 0; i < steps.length; i++)
          transitionBetween(
            steps[i],
            i + 1 < steps.length ? steps[i + 1] : null,
          ),
      ];
      const t = DisplayTransition.values;
      expect(transitions, [
        t.byName('enterSet'), // 1
        t.byName('enterSubset'), // 2
        t.byName('nextRepetition'), // 3
        t.byName('newExercise'), // 4 → 5
        t.byName('nextRepetition'), // 5
        t.byName('repeatSubset'), // 6 → 7
        t.byName('nextRepetition'),
        t.byName('newExercise'),
        t.byName('nextRepetition'),
        t.byName('repeatSet'), // 10 → 11
        t.byName('enterSubset'),
        t.byName('nextRepetition'),
        t.byName('newExercise'),
        t.byName('nextRepetition'),
        t.byName('repeatSubset'),
        t.byName('nextRepetition'),
        t.byName('newExercise'),
        t.byName('nextRepetition'),
        t.byName('done'), // 19 → klaar
      ]);
    });

    test('werktijd per herhaling, rust constant', () {
      List<int> work(int i) =>
          steps[i].groups.map((g) => g.workSeconds).toList();
      List<int> rest(int i) =>
          steps[i].groups.map((g) => g.restSeconds).toList();
      expect(work(0), [10]);
      expect(work(1), [15, 10]); // Hard, Easy
      expect(work(2), [10]);
      expect(work(3), [5]); // d−
      expect(work(4), [10]);
      expect(work(5), [15]); // d+
      expect(rest(3), [10]);
      expect(rest(5), [10]);
      expect(steps[3].repetitionWorkSeconds, [10, 5]);
      expect(steps[5].repetitionWorkSeconds, [10, 15]);
    });

    test('banen vóór de stap en totaal (groep met de meeste banen)', () {
      expect(timeline.lengthsBefore(0), 0);
      expect(timeline.lengthsBefore(1), 35);
      expect(timeline.lengthsBefore(3), 62);
      expect(timeline.lengthsBefore(9), 74);
      expect(timeline.totalLengths, 117);
      expect(steps[1].groups.map((g) => g.lengths), [25, 20]);
    });

    test('koppeling vanuit flattenTraining dekt elke fase', () {
      final phases = flattenTraining(exampleTraining);
      // warmup 2 + per set (group split 1 + 8 × werk/rust 2) × 2
      expect(phases, hasLength(2 + 2 * (1 + 16)));
      expect(timeline.displayIndexByStep, hasLength(phases.length));
      for (var i = 0; i < phases.length; i++) {
        final step = steps[timeline.displayIndexByStep[i]];
        expect(phases[i].exerciseId, step.exerciseId);
        expect(
          i,
          inInclusiveRange(
            step.firstStepIndex,
            step.firstStepIndex + step.stepCount - 1,
          ),
        );
      }
    });
  });

  group('randgevallen', () {
    TrainingExerciseGroup row({int work = 10, int rest = 10, int delta = 0}) =>
        TrainingExerciseGroup(
          id: 'r',
          workSeconds: work,
          restSeconds: rest,
          deltaSeconds: delta,
          parameterRows: const [TrainingParameterRow(id: 'p', reps: 4)],
        );

    test('oefening met één herhaling: één stap, één node in de track', () {
      final steps = buildDisplayTimeline(
        Training(
          children: [
            exerciseNode('e', 'E', groups: [row()]),
          ],
        ),
      ).steps;
      expect(steps, hasLength(1));
      expect(steps.single.path.repetition.count, 1);
      expect(steps.single.repetitionWorkSeconds, [10]);
      expect(transitionBetween(steps.single, null), DisplayTransition.done);
    });

    test('structuur zonder set: alleen oefeningen', () {
      final steps = buildDisplayTimeline(
        Training(
          children: [
            exerciseNode('a', 'A', groups: [row()]),
            exerciseNode('b', 'B', groups: [row()]),
          ],
        ),
      ).steps;
      expect(steps.map(_key).toList(), [
        [null, null, 1, 1],
        [null, null, 2, 1],
      ]);
      expect(steps.first.path.exercise.count, 2);
      expect(
        transitionBetween(steps[0], steps[1]),
        DisplayTransition.newExercise,
      );
    });

    test('set zonder subset, en twee verschillende sets na elkaar', () {
      final steps = buildDisplayTimeline(
        Training(
          children: [
            groupNode('s1', 'Set A', [
              exerciseNode('a', 'A', groups: [row()]),
            ]),
            groupNode('s2', 'Set B', [
              exerciseNode('b', 'B', groups: [row()]),
            ]),
            exerciseNode('c', 'Cooldown', groups: [row()]),
          ],
        ),
      ).steps;
      expect(steps.map(_key).toList(), [
        [1, null, 1, 1],
        [1, null, 1, 1],
        [null, null, 1, 1],
      ]);
      expect(transitionBetween(steps[0], steps[1]), DisplayTransition.newSet);
      expect(
        transitionBetween(steps[1], steps[2]),
        DisplayTransition.newExercise,
      );
    });

    test('nul delta: werktijd blijft gelijk', () {
      final steps = buildDisplayTimeline(
        Training(
          children: [
            exerciseNode('e', 'E', repeatCount: 3, groups: [row()]),
          ],
        ),
      ).steps;
      expect(steps.first.repetitionWorkSeconds, [10, 10, 10]);
      expect(steps.map((s) => s.groups.single.workSeconds), [10, 10, 10]);
    });

    test('grote negatieve delta klemt op 1 s', () {
      final steps = buildDisplayTimeline(
        Training(
          children: [
            exerciseNode('e', 'E', repeatCount: 3, groups: [row(delta: -8)]),
          ],
        ),
      ).steps;
      expect(steps.first.repetitionWorkSeconds, [10, 2, 1]);
    });

    test('groep zonder lijnen telt 0 banen', () {
      final steps = buildDisplayTimeline(
        Training(
          children: [
            exerciseNode(
              'e',
              'E',
              groups: const [TrainingExerciseGroup(id: 'g', workSeconds: 10)],
            ),
            exerciseNode('leeg', 'Zonder rijen'),
          ],
        ),
      );
      expect(steps.steps.first.lengths, 0);
      expect(steps.steps.last.groups, isEmpty);
      expect(steps.totalLengths, 0);
      expect(steps.displayIndexByStep, [0, 1]);
    });

    test(
      'delta volgt de subset-herhaling als de oefening zelf niet herhaalt',
      () {
        final steps = buildDisplayTimeline(
          Training(
            children: [
              groupNode('s', 'Set', repeatCount: 2, [
                exerciseNode('e', 'E', groups: [row(delta: 5)]),
              ]),
            ],
          ),
        ).steps;
        expect(steps.map((s) => s.groups.single.workSeconds), [10, 15]);
        expect(
          transitionBetween(steps[0], steps[1]),
          DisplayTransition.repeatSet,
        );
      },
    );
  });
}
