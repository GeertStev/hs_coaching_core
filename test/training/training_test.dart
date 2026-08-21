import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_exercise.dart';
import 'package:hs_coaching_core/training/training_exercise_group.dart';
import 'package:hs_coaching_core/training/training_group.dart';
import 'package:hs_coaching_core/training/training_node.dart';
import 'package:hs_coaching_core/training/training_parameter_row.dart';
import 'package:hs_coaching_core/training/training_validation.dart';

/// Round-trip elke geneste laag apart via `jsonEncode`/`jsonDecode` (niet
/// alleen Dart-level `toJson`/`fromJson`) — dat is precies het scenario
/// waarin een vergeten `explicitToJson: true` een geneste Freezed-object
/// ongeserialiseerd laat doorsijpelen en pas bij de `StandardMessageCodec`
/// (Firestore-schrijfpad) crasht, niet bij een simpele Dart round-trip.
Map<String, dynamic> _roundTrip(Map<String, dynamic> json) =>
    jsonDecode(jsonEncode(json)) as Map<String, dynamic>;

void main() {
  test('TrainingExerciseGroup met geneste parameterRows overleeft jsonEncode', () {
    const group = TrainingExerciseGroup(
      id: 'g1',
      name: 'Groep A',
      parameterRows: [
        TrainingParameterRow(id: 'p1', reps: 4, stroke: 'A'),
        TrainingParameterRow(id: 'p2', zone: 'Bov'),
      ],
      workSeconds: 30,
      restSeconds: 10,
      deltaSeconds: 5,
    );
    final decoded = TrainingExerciseGroup.fromJson(_roundTrip(group.toJson()));
    expect(decoded, group);
  });

  test('TrainingExercise met geneste groups overleeft jsonEncode', () {
    const exercise = TrainingExercise(
      id: 'e1',
      title: 'Sprint',
      groups: [
        TrainingExerciseGroup(id: 'g1', workSeconds: 20, restSeconds: 5),
        TrainingExerciseGroup(id: 'g2', name: 'Uitlopen', workSeconds: 10),
      ],
    );
    final decoded = TrainingExercise.fromJson(_roundTrip(exercise.toJson()));
    expect(decoded, exercise);
  });

  test('TrainingNode-union (beide varianten) overleeft jsonEncode', () {
    const groupNode = TrainingNode.group(
      group: TrainingGroup(id: 'grp1', title: 'Groep', children: []),
    );
    const exerciseNode = TrainingNode.exercise(
      exercise: TrainingExercise(id: 'e1', title: 'Exercise'),
    );

    expect(TrainingNode.fromJson(_roundTrip(groupNode.toJson())), groupNode);
    expect(
      TrainingNode.fromJson(_roundTrip(exerciseNode.toJson())),
      exerciseNode,
    );
    expect(groupNode.id, 'grp1');
    expect(exerciseNode.id, 'e1');
  });

  test('TrainingGroup met alleen oefeningen als kind overleeft jsonEncode', () {
    const group = TrainingGroup(
      id: 'grp1',
      title: 'Subset 1',
      repeatCount: 3,
      children: [
        TrainingNode.exercise(exercise: TrainingExercise(id: 'e1', title: 'A')),
        TrainingNode.exercise(exercise: TrainingExercise(id: 'e2', title: 'B')),
      ],
    );
    final decoded = TrainingGroup.fromJson(_roundTrip(group.toJson()));
    expect(decoded, group);
  });

  test(
    'TrainingGroup met geneste TrainingGroup-kind overleeft jsonEncode '
    '(eerste echt recursieve Freezed-model — de plek waar een vergeten '
    'explicitToJson het meest waarschijnlijk misgaat)',
    () {
      const group = TrainingGroup(
        id: 'set1',
        title: 'Set 1',
        repeatCount: 2,
        children: [
          TrainingNode.exercise(
            exercise: TrainingExercise(id: 'e1', title: 'Los'),
          ),
          TrainingNode.group(
            group: TrainingGroup(
              id: 'sub1',
              title: 'Sub',
              children: [
                TrainingNode.exercise(
                  exercise: TrainingExercise(id: 'e2', title: 'In subset'),
                ),
              ],
            ),
          ),
        ],
      );
      final decoded = TrainingGroup.fromJson(_roundTrip(group.toJson()));
      expect(decoded, group);
    },
  );

  test('Training-document (drie niveaus diep) overleeft jsonEncode', () {
    const training = Training(
      children: [
        TrainingNode.exercise(
          exercise: TrainingExercise(id: 'e1', title: 'Warming-up'),
        ),
        TrainingNode.group(
          group: TrainingGroup(
            id: 'set1',
            title: 'Hoofdset',
            repeatCount: 4,
            children: [
              TrainingNode.exercise(
                exercise: TrainingExercise(
                  id: 'e2',
                  title: 'Sprint',
                  groups: [
                    TrainingExerciseGroup(
                      id: 'g1',
                      workSeconds: 25,
                      restSeconds: 10,
                      parameterRows: [
                        TrainingParameterRow(id: 'p1', zone: 'Bov'),
                      ],
                    ),
                  ],
                ),
              ),
              TrainingNode.group(
                group: TrainingGroup(
                  id: 'sub1',
                  title: 'Techniek',
                  repeatCount: 2,
                  children: [
                    TrainingNode.exercise(
                      exercise: TrainingExercise(id: 'e3', title: 'Drill'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final decoded = Training.fromJson(_roundTrip(training.toJson()));
    expect(decoded, training);
  });

  group('subtreeHeight', () {
    test('een losse oefening heeft hoogte 1', () {
      const node = TrainingNode.exercise(
        exercise: TrainingExercise(id: 'e1', title: 'A'),
      );
      expect(subtreeHeight(node), 1);
    });

    test('een lege groep heeft hoogte 1 (zelfde als een oefening)', () {
      const node = TrainingNode.group(
        group: TrainingGroup(id: 'g1', children: []),
      );
      expect(subtreeHeight(node), 1);
    });

    test('een groep met alleen oefeningen heeft hoogte 2', () {
      const node = TrainingNode.group(
        group: TrainingGroup(
          id: 'g1',
          children: [
            TrainingNode.exercise(exercise: TrainingExercise(id: 'e1', title: 'A')),
          ],
        ),
      );
      expect(subtreeHeight(node), 2);
    });

    test('een groep met een geneste groep heeft hoogte 3', () {
      const node = TrainingNode.group(
        group: TrainingGroup(
          id: 'g1',
          children: [
            TrainingNode.group(
              group: TrainingGroup(
                id: 'g2',
                children: [
                  TrainingNode.exercise(
                    exercise: TrainingExercise(id: 'e1', title: 'A'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
      expect(subtreeHeight(node), 3);
    });
  });

  group('isValidTrainingTree', () {
    test('een training binnen de max-diepte-3 is geldig', () {
      const training = Training(
        children: [
          TrainingNode.group(
            group: TrainingGroup(
              id: 'g1',
              children: [
                TrainingNode.group(
                  group: TrainingGroup(
                    id: 'g2',
                    children: [
                      TrainingNode.exercise(
                        exercise: TrainingExercise(id: 'e1', title: 'A'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
      expect(isValidTrainingTree(training), isTrue);
    });

    test('een training die de max-diepte-3 overschrijdt is ongeldig', () {
      const training = Training(
        children: [
          TrainingNode.group(
            group: TrainingGroup(
              id: 'g1',
              children: [
                TrainingNode.group(
                  group: TrainingGroup(
                    id: 'g2',
                    children: [
                      TrainingNode.group(
                        group: TrainingGroup(
                          id: 'g3',
                          children: [
                            TrainingNode.exercise(
                              exercise: TrainingExercise(id: 'e1', title: 'A'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
      expect(isValidTrainingTree(training), isFalse);
    });
  });
}
