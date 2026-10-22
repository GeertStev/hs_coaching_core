import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_exercise.dart';
import 'package:hs_coaching_core/training/training_exercise_group.dart';
import 'package:hs_coaching_core/training/training_flatten.dart';
import 'package:hs_coaching_core/training/training_group.dart';
import 'package:hs_coaching_core/training/training_node.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

TrainingNode _exerciseNode(
  String id,
  String title, {
  List<TrainingExerciseGroup> groups = const [],
}) => TrainingNode.exercise(
  exercise: TrainingExercise(id: id, title: title, groups: groups),
);

void main() {
  group('flattenTraining — ongetimede oefeningen (0-seconden-edge-case)', () {
    test('oefening zonder groups levert precies één ongetimede stap op', () {
      final training = Training(children: [_exerciseNode('e1', 'Techniek')]);

      final steps = flattenTraining(training);

      expect(steps, hasLength(1));
      expect(steps.single.isTimed, isFalse);
      expect(steps.single.phase, TrainingStepPhase.work);
      expect(steps.single.exerciseTitle, 'Techniek');
    });

    test(
      'rij met workSeconds == restSeconds == 0 levert precies één '
      'ongetimede stap op, geen aparte rust-stap',
      () {
        final training = Training(
          children: [
            _exerciseNode(
              'e1',
              '4x50m crawl',
              groups: const [
                TrainingExerciseGroup(id: 'g1', workSeconds: 0, restSeconds: 0),
              ],
            ),
          ],
        );

        final steps = flattenTraining(training);

        expect(steps, hasLength(1));
        expect(steps.single.isTimed, isFalse);
      },
    );

    test('workSeconds > 0 zonder restSeconds levert alleen een werk-stap op', () {
      final training = Training(
        children: [
          _exerciseNode(
            'e1',
            'Sprint',
            groups: const [
              TrainingExerciseGroup(id: 'g1', workSeconds: 30, restSeconds: 0),
            ],
          ),
        ],
      );

      final steps = flattenTraining(training);

      expect(steps, hasLength(1));
      expect(steps.single.isTimed, isTrue);
      expect(steps.single.durationMillis, 30000);
      expect(steps.single.phase, TrainingStepPhase.work);
    });

    test('workSeconds > 0 én restSeconds > 0 levert werk + rust op', () {
      final training = Training(
        children: [
          _exerciseNode(
            'e1',
            'Intervallen',
            groups: const [
              TrainingExerciseGroup(id: 'g1', workSeconds: 20, restSeconds: 10),
            ],
          ),
        ],
      );

      final steps = flattenTraining(training);

      expect(steps, hasLength(2));
      expect(steps[0].phase, TrainingStepPhase.work);
      expect(steps[0].durationMillis, 20000);
      expect(steps[1].phase, TrainingStepPhase.rest);
      expect(steps[1].durationMillis, 10000);
    });
  });

  group('flattenTraining — meerdere timing-rijen per oefening', () {
    test('elke rij levert een eigen groupIndex op', () {
      final training = Training(
        children: [
          _exerciseNode(
            'e1',
            'Wisselslag',
            groups: const [
              TrainingExerciseGroup(id: 'g1', workSeconds: 15, restSeconds: 0),
              TrainingExerciseGroup(id: 'g2', workSeconds: 0, restSeconds: 0),
            ],
          ),
        ],
      );

      final steps = flattenTraining(training);

      expect(steps, hasLength(2));
      expect(steps[0].groupIndex, 0);
      expect(steps[0].isTimed, isTrue);
      expect(steps[1].groupIndex, 1);
      expect(steps[1].isTimed, isFalse);
    });
  });

  group('flattenTraining — herhaalde groepen (repeatCount)', () {
    test('rolt repeatCount uit tot losse herhaalde substappen', () {
      final training = Training(
        children: [
          TrainingNode.group(
            group: TrainingGroup(
              id: 'grp1',
              title: 'Set A',
              repeatCount: 3,
              children: [
                _exerciseNode(
                  'e1',
                  'Kick',
                  groups: const [
                    TrainingExerciseGroup(id: 'g1', workSeconds: 10, restSeconds: 0),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

      final steps = flattenTraining(training);

      expect(steps, hasLength(3));
      for (var i = 0; i < 3; i++) {
        expect(steps[i].repeats, hasLength(1));
        expect(steps[i].repeats.single.groupId, 'grp1');
        expect(steps[i].repeats.single.iteration, i + 1);
        expect(steps[i].repeats.single.repeatCount, 3);
      }
    });

    test('repeatCount == 1 voegt geen herhalings-context toe', () {
      final training = Training(
        children: [
          TrainingNode.group(
            group: TrainingGroup(
              id: 'grp1',
              children: [_exerciseNode('e1', 'Solo')],
            ),
          ),
        ],
      );

      final steps = flattenTraining(training);

      expect(steps, hasLength(1));
      expect(steps.single.repeats, isEmpty);
    });

    test(
      'deltaSeconds verschuift workSeconds per iteratie van de dichtstbije '
      'herhalende groep, geklemd op minimaal 1 seconde',
      () {
        final training = Training(
          children: [
            TrainingNode.group(
              group: TrainingGroup(
                id: 'grp1',
                repeatCount: 3,
                children: [
                  _exerciseNode(
                    'e1',
                    'Progressief sneller',
                    groups: const [
                      TrainingExerciseGroup(
                        id: 'g1',
                        workSeconds: 30,
                        deltaSeconds: -10,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );

        final steps = flattenTraining(training);

        expect(steps, hasLength(3));
        expect(steps[0].durationMillis, 30000); // iteratie 1: geen delta
        expect(steps[1].durationMillis, 20000); // iteratie 2: -10s
        expect(steps[2].durationMillis, 10000); // iteratie 3: -20s
      },
    );

    test('deltaSeconds heeft geen effect op een ongetimede rij', () {
      final training = Training(
        children: [
          TrainingNode.group(
            group: TrainingGroup(
              id: 'grp1',
              repeatCount: 2,
              children: [
                _exerciseNode(
                  'e1',
                  'Reps-only',
                  groups: const [
                    TrainingExerciseGroup(
                      id: 'g1',
                      workSeconds: 0,
                      deltaSeconds: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

      final steps = flattenTraining(training);

      expect(steps, hasLength(2));
      expect(steps[0].isTimed, isFalse);
      expect(steps[1].isTimed, isFalse);
    });

    test(
      'geneste herhalende groepen: repeats bevat beide niveaus, van buiten '
      'naar binnen; delta volgt alleen de dichtstbije (binnenste)',
      () {
        final training = Training(
          children: [
            TrainingNode.group(
              group: TrainingGroup(
                id: 'outer',
                repeatCount: 2,
                children: [
                  TrainingNode.group(
                    group: TrainingGroup(
                      id: 'inner',
                      repeatCount: 2,
                      children: [
                        _exerciseNode(
                          'e1',
                          'Diep genest',
                          groups: const [
                            TrainingExerciseGroup(
                              id: 'g1',
                              workSeconds: 10,
                              deltaSeconds: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

        final steps = flattenTraining(training);

        expect(steps, hasLength(4));
        expect(steps[0].repeats.map((r) => r.groupId), ['outer', 'inner']);
        // outer=1,inner=1 -> 10s; outer=1,inner=2 -> 15s;
        // outer=2,inner=1 -> 10s; outer=2,inner=2 -> 15s
        expect(steps[0].durationMillis, 10000);
        expect(steps[1].durationMillis, 15000);
        expect(steps[2].durationMillis, 10000);
        expect(steps[3].durationMillis, 15000);
      },
    );
  });

  group('flattenTraining — herhalingen en stapnummers', () {
    final training = Training(
      children: [
        TrainingNode.group(
          group: TrainingGroup(
            id: 's1',
            title: 'Set',
            repeatCount: 2,
            children: [
              _exerciseNode(
                'e1',
                'Een',
                groups: const [
                  TrainingExerciseGroup(
                    id: 'g1',
                    workSeconds: 20,
                    deltaSeconds: 5,
                  ),
                ],
              ),
              _exerciseNode(
                'e2',
                'Twee',
                groups: const [
                  TrainingExerciseGroup(id: 'g2', workSeconds: 30),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    test('elke ronde levert eigen stappen op met de juiste iteratie', () {
      final steps = flattenTraining(training);

      expect(steps, hasLength(4));
      expect(steps.map((s) => s.repeats.single.iteration), [1, 1, 2, 2]);
      expect(steps[2].durationMillis, 25000);
    });

    test('siblingIndex/siblingCount tellen de oefening binnen de set', () {
      final steps = flattenTraining(training);

      expect(steps.map((s) => s.siblingIndex), [0, 1, 0, 1]);
      expect(steps.every((s) => s.siblingCount == 2), isTrue);
    });
  });
}
