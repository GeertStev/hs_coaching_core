import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_status.dart';
import 'package:hs_coaching_core/training/training_step.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

TrainingStep _timedStep(int durationMillis) => TrainingStep(
  path: const [0],
  groupIndex: 0,
  phase: TrainingStepPhase.work,
  durationMillis: durationMillis,
  exerciseId: 'e1',
  exerciseTitle: 'Sprint',
  groupName: '',
  parameterRows: const [],
  repeats: const [],
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
);

void main() {
  group('computeTrainingProgress', () {
    test('lege stappenlijst is meteen finished', () {
      final progress = computeTrainingProgress(
        steps: const [],
        status: TrainingStatus.idle,
        pointer: const TrainingStepPointer(-1),
        elapsedInStepMillis: 0,
      );

      expect(progress.isFinished, isTrue);
      expect(progress.currentStep, isNull);
    });

    test('pointer vóór de start (-1): geen huidige stap, niet finished', () {
      final steps = [_timedStep(10000)];

      final progress = computeTrainingProgress(
        steps: steps,
        status: TrainingStatus.idle,
        pointer: const TrainingStepPointer(-1),
        elapsedInStepMillis: 0,
      );

      expect(progress.isFinished, isFalse);
      expect(progress.currentStep, isNull);
      expect(progress.stepIndex, -1);
    });

    test('pointer voorbij de laatste stap is finished', () {
      final steps = [_timedStep(10000)];

      final progress = computeTrainingProgress(
        steps: steps,
        status: TrainingStatus.running,
        pointer: const TrainingStepPointer(1),
        elapsedInStepMillis: 0,
      );

      expect(progress.isFinished, isTrue);
    });

    test('ongetimede stap: remaining null, autoAdvanceDue altijd false', () {
      final steps = [_untimedStep()];

      final running = computeTrainingProgress(
        steps: steps,
        status: TrainingStatus.running,
        pointer: const TrainingStepPointer(0),
        elapsedInStepMillis: 999999,
      );

      expect(running.currentStep, isNotNull);
      expect(running.remaining, isNull);
      expect(running.autoAdvanceDue, isFalse);
    });

    test('getimede stap, nog niet afgelopen: resterende tijd correct', () {
      final steps = [_timedStep(10000)];

      final progress = computeTrainingProgress(
        steps: steps,
        status: TrainingStatus.running,
        pointer: const TrainingStepPointer(0),
        elapsedInStepMillis: 4000,
      );

      expect(progress.remaining, const Duration(milliseconds: 6000));
      expect(progress.autoAdvanceDue, isFalse);
    });

    test(
      'getimede stap, afgelopen én running: autoAdvanceDue true, '
      'remaining geklemd op 0',
      () {
        final steps = [_timedStep(10000)];

        final progress = computeTrainingProgress(
          steps: steps,
          status: TrainingStatus.running,
          pointer: const TrainingStepPointer(0),
          elapsedInStepMillis: 15000,
        );

        expect(progress.autoAdvanceDue, isTrue);
        expect(progress.remaining, Duration.zero);
      },
    );

    test(
      'getimede stap, afgelopen maar gepauzeerd: geen auto-advance',
      () {
        final steps = [_timedStep(10000)];

        final progress = computeTrainingProgress(
          steps: steps,
          status: TrainingStatus.paused,
          pointer: const TrainingStepPointer(0),
          elapsedInStepMillis: 15000,
        );

        expect(progress.autoAdvanceDue, isFalse);
      },
    );
  });
}
