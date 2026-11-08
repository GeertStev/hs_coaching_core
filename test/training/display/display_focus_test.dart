import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/display/display_position.dart';
import 'package:hs_coaching_core/training/display/display_timeline.dart';
import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_exercise_group.dart';
import 'package:hs_coaching_core/training/training_flatten.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_status.dart';

import 'example_training.dart';

/// Focus (oranje kader) tussen huidige en volgende oefening.
void main() {
  TrainingDisplayPosition Function(int, {TrainingStatus status}) positionsOf(
    Training training,
  ) {
    final phases = flattenTraining(training);
    final timeline = buildDisplayTimeline(training);
    return (elapsedSeconds, {status = TrainingStatus.running}) =>
        displayPositionAt(
          timeline,
          computeTrainingProgress(
            steps: phases,
            status: status,
            anchorStepIndex: status == TrainingStatus.idle ? -1 : 0,
            elapsedSinceAnchorMillis: elapsedSeconds * 1000,
          ),
        );
  }

  TrainingExerciseGroup row({int work = 0, int rest = 0, String id = 'r'}) =>
      TrainingExerciseGroup(id: id, workSeconds: work, restSeconds: rest);

  test('vóór de start staat de focus op de eerste oefening', () {
    final at = positionsOf(exampleTraining);
    final position = at(0, status: TrainingStatus.idle);
    expect(position.focusOnNext, isTrue);
    expect(position.focusOnCurrent, isFalse);
  });

  test('met rust: focus verspringt bij de rust van de laatste herhaling', () {
    // 2× (10 s werk + 5 s rust), daarna een andere oefening.
    final at = positionsOf(
      Training(
        children: [
          exerciseNode(
            'a',
            'A',
            repeatCount: 2,
            groups: [row(work: 10, rest: 5)],
          ),
          exerciseNode('b', 'B', groups: [row(work: 10)]),
        ],
      ),
    );
    expect(at(2).focusOnCurrent, isTrue); // herhaling 1, werk
    expect(at(12).focusOnCurrent, isTrue); // herhaling 1, rust
    expect(at(24).focusOnCurrent, isTrue); // herhaling 2, werk (1 s over)
    expect(at(25).focusOnNext, isTrue); // herhaling 2, rust
    expect(at(29).focusOnNext, isTrue);
    expect(at(30).current?.exerciseId, 'b');
    expect(at(30).focusOnCurrent, isTrue);
  });

  test('zonder rust: focus verspringt 5 s voor het einde', () {
    final at = positionsOf(
      Training(
        children: [
          exerciseNode('a', 'A', repeatCount: 2, groups: [row(work: 20)]),
          exerciseNode('b', 'B', groups: [row(work: 10)]),
        ],
      ),
    );
    expect(at(14).focusOnCurrent, isTrue); // herhaling 1: geen wissel
    expect(at(16).focusOnCurrent, isTrue); // herhaling 1: niet de laatste
    expect(at(34).focusOnCurrent, isTrue); // herhaling 2, nog 6 s
    expect(at(35).focusOnNext, isTrue); // nog 5 s
  });

  test('ongetimede oefening wacht op de coach: focus op de volgende', () {
    final at = positionsOf(
      Training(
        children: [
          exerciseNode('a', 'A', repeatCount: 2, groups: [row()]),
          exerciseNode('b', 'B', groups: [row(work: 10)]),
        ],
      ),
    );
    expect(at(600).isWaitingForCoach, isTrue);
    expect(at(600).focusOnNext, isTrue);
    expect(at(600).nextExercise?.exerciseId, 'b');
  });

  test('getimede oefening wacht niet op de coach', () {
    final at = positionsOf(
      Training(
        children: [
          exerciseNode('a', 'A', groups: [row(work: 10)]),
        ],
      ),
    );
    expect(at(2).isWaitingForCoach, isFalse);
    expect(at(0, status: TrainingStatus.idle).isWaitingForCoach, isFalse);
  });

  test('ongetimede laatste oefening: focus blijft op de huidige', () {
    final at = positionsOf(
      Training(
        children: [
          exerciseNode('a', 'A', groups: [row()]),
        ],
      ),
    );
    expect(at(5).isWaitingForCoach, isTrue);
    expect(at(5).focusOnCurrent, isTrue);
  });

  test('oefening met enkel rust: focus meteen op de volgende', () {
    final at = positionsOf(
      Training(
        children: [
          exerciseNode('rest', 'Rest', groups: [row(rest: 30)]),
          exerciseNode('b', 'B', groups: [row(work: 10)]),
        ],
      ),
    );
    expect(at(1).current?.exerciseId, 'rest');
    expect(at(1).timers.single.remainingSeconds, 29);
    expect(at(1).focusOnNext, isTrue);
  });

  test('laatste oefening: focus blijft op de huidige', () {
    final at = positionsOf(
      Training(
        children: [
          exerciseNode('a', 'A', groups: [row(work: 10, rest: 5)]),
        ],
      ),
    );
    expect(at(12).nextExercise, isNull);
    expect(at(12).focusOnCurrent, isTrue);
  });

  test('group split: focus zodra alle groepen rusten, anders 5 s voor het '
      'einde', () {
    final withRest = positionsOf(
      Training(
        children: [
          exerciseNode(
            'gs',
            'GS',
            groups: [
              row(id: 'h', work: 15, rest: 10),
              row(id: 'e', work: 10, rest: 10),
            ],
          ),
          exerciseNode('b', 'B', groups: [row(work: 10)]),
        ],
      ),
    );
    // Stap = 25 s; Easy rust vanaf 10 s, Hard vanaf 15 s.
    expect(withRest(12).focusOnCurrent, isTrue);
    expect(withRest(15).focusOnNext, isTrue);

    final noRest = positionsOf(
      Training(
        children: [
          exerciseNode(
            'gs',
            'GS',
            groups: [
              row(id: 'h', work: 20),
              row(id: 'e', work: 10, rest: 5),
            ],
          ),
          exerciseNode('b', 'B', groups: [row(work: 10)]),
        ],
      ),
    );
    expect(noRest(14).focusOnCurrent, isTrue);
    expect(noRest(15).focusOnNext, isTrue);
  });
}
