import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_status.dart';
import 'package:hs_coaching_core/training/training_step.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

TrainingStep _timedStep(int durationMillis, {String id = 'e1'}) => TrainingStep(
  path: const [0],
  groupIndex: 0,
  phase: TrainingStepPhase.work,
  durationMillis: durationMillis,
  exerciseId: id,
  exerciseTitle: 'Sprint',
  groupName: '',
  parameterRows: const [],
  repeats: const [],
  siblingIndex: 0,
  siblingCount: 1,
);

TrainingStep _untimedStep() => TrainingStep(
  path: const [1],
  groupIndex: 0,
  phase: TrainingStepPhase.work,
  durationMillis: null,
  exerciseId: 'e2',
  exerciseTitle: 'Reps-only',
  groupName: '',
  parameterRows: const [],
  repeats: const [],
  siblingIndex: 0,
  siblingCount: 1,
);

void main() {
  group('computeTrainingProgress', () {
    test('lege stappenlijst is meteen finished', () {
      final progress = computeTrainingProgress(
        steps: const [],
        status: TrainingStatus.idle,
        anchorStepIndex: -1,
        elapsedSinceAnchorMillis: 0,
      );

      expect(progress.isFinished, isTrue);
      expect(progress.currentStep, isNull);
    });

    test('anker vóór de start (-1): geen huidige stap, niet finished', () {
      final progress = computeTrainingProgress(
        steps: [_timedStep(10000)],
        status: TrainingStatus.idle,
        anchorStepIndex: -1,
        elapsedSinceAnchorMillis: 0,
      );

      expect(progress.isFinished, isFalse);
      expect(progress.isBeforeStart, isTrue);
      expect(progress.currentStep, isNull);
    });

    test('anker voorbij de laatste stap is finished', () {
      final progress = computeTrainingProgress(
        steps: [_timedStep(10000)],
        status: TrainingStatus.running,
        anchorStepIndex: 1,
        elapsedSinceAnchorMillis: 0,
      );

      expect(progress.isFinished, isTrue);
      expect(progress.stepIndex, 1);
    });

    test('ongetimede stap: remaining null, blijft staan', () {
      final progress = computeTrainingProgress(
        steps: [_untimedStep(), _timedStep(10000)],
        status: TrainingStatus.running,
        anchorStepIndex: 0,
        elapsedSinceAnchorMillis: 999999,
      );

      expect(progress.stepIndex, 0);
      expect(progress.remaining, isNull);
      expect(progress.isTicking, isFalse);
    });

    test('getimede stap, nog niet afgelopen: resterende tijd correct', () {
      final progress = computeTrainingProgress(
        steps: [_timedStep(10000)],
        status: TrainingStatus.running,
        anchorStepIndex: 0,
        elapsedSinceAnchorMillis: 4000,
      );

      expect(progress.remaining, const Duration(milliseconds: 6000));
      expect(progress.isTicking, isTrue);
    });

    test('afgelopen getimede stap loopt door naar de volgende stap', () {
      final progress = computeTrainingProgress(
        steps: [
          _timedStep(10000),
          _timedStep(20000, id: 'e2'),
        ],
        status: TrainingStatus.running,
        anchorStepIndex: 0,
        elapsedSinceAnchorMillis: 15000,
      );

      expect(progress.stepIndex, 1);
      expect(progress.remaining, const Duration(milliseconds: 15000));
    });

    test('doorlopen stopt bij de eerste ongetimede stap', () {
      final progress = computeTrainingProgress(
        steps: [_timedStep(10000), _untimedStep(), _timedStep(10000)],
        status: TrainingStatus.running,
        anchorStepIndex: 0,
        elapsedSinceAnchorMillis: 60000,
      );

      expect(progress.stepIndex, 1);
      expect(progress.remaining, isNull);
    });

    test('doorlopen voorbij de laatste getimede stap is finished', () {
      final progress = computeTrainingProgress(
        steps: [_timedStep(10000), _timedStep(10000)],
        status: TrainingStatus.running,
        anchorStepIndex: 0,
        elapsedSinceAnchorMillis: 20000,
      );

      expect(progress.isFinished, isTrue);
      expect(progress.stepIndex, 2);
    });

    test('gepauzeerd: zelfde positie, tikt niet', () {
      final progress = computeTrainingProgress(
        steps: [_timedStep(10000), _timedStep(10000)],
        status: TrainingStatus.paused,
        anchorStepIndex: 0,
        elapsedSinceAnchorMillis: 12000,
      );

      expect(progress.stepIndex, 1);
      expect(progress.remaining, const Duration(milliseconds: 8000));
      expect(progress.isTicking, isFalse);
    });

    test('remainingSeconds rondt naar boven af', () {
      final progress = computeTrainingProgress(
        steps: [_timedStep(10000)],
        status: TrainingStatus.running,
        anchorStepIndex: 0,
        elapsedSinceAnchorMillis: 9100,
      );

      expect(progress.remainingSeconds, 1);
    });
  });

  group('trainingElapsedMillis', () {
    test('running telt de tijd sinds de start bij het geaccumuleerde op', () {
      const training = Training(
        status: TrainingStatus.running,
        authoritativeStartTimeMillis: 1000,
        accumulatedElapsedMillis: 500,
      );

      expect(trainingElapsedMillis(training, 3000), 2500);
    });

    test('gepauzeerd telt alleen het geaccumuleerde', () {
      const training = Training(
        status: TrainingStatus.paused,
        authoritativeStartTimeMillis: 1000,
        accumulatedElapsedMillis: 500,
      );

      expect(trainingElapsedMillis(training, 3000), 500);
    });
  });
}
