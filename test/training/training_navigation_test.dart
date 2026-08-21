import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/training_navigation.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_step.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

TrainingStep _step(List<int> path, int groupIndex, TrainingStepPhase phase) =>
    TrainingStep(
      path: path,
      groupIndex: groupIndex,
      phase: phase,
      durationMillis: 10000,
      exerciseId: path.join('.'),
      exerciseTitle: 'Stap $path/$groupIndex/${phase.name}',
      groupName: '',
      parameterRows: const [],
      repeats: const [],
    );

void main() {
  final steps = [
    _step([0], 0, TrainingStepPhase.work),
    _step([0], 0, TrainingStepPhase.rest),
    _step([1], 0, TrainingStepPhase.work),
  ];

  group('pointerFor', () {
    test('leeg pad -> -1 (nog niet gestart)', () {
      final pointer = pointerFor(
        steps,
        path: const [],
        groupIndex: 0,
        phase: TrainingStepPhase.work,
      );
      expect(pointer.index, -1);
      expect(pointer.isBeforeStart, isTrue);
    });

    test('bestaande combinatie vindt de juiste index', () {
      final pointer = pointerFor(
        steps,
        path: const [1],
        groupIndex: 0,
        phase: TrainingStepPhase.work,
      );
      expect(pointer.index, 2);
    });

    test('niet-bestaande combinatie -> -1', () {
      final pointer = pointerFor(
        steps,
        path: const [5],
        groupIndex: 0,
        phase: TrainingStepPhase.work,
      );
      expect(pointer.index, -1);
    });
  });

  group('nextStepPointer / previousStepPointer', () {
    test('next vanaf -1 (nog niet gestart) gaat naar de eerste stap', () {
      final next = nextStepPointer(steps, const TrainingStepPointer(-1));
      expect(next.index, 0);
    });

    test('next vanaf de laatste stap beweegt voorbij het einde', () {
      final next = nextStepPointer(
        steps,
        TrainingStepPointer(steps.length - 1),
      );
      expect(next.index, steps.length);
    });

    test('previous vanaf de eerste stap blijft op de eerste stap staan', () {
      final previous = previousStepPointer(
        steps,
        const TrainingStepPointer(0),
      );
      expect(previous.index, 0);
    });

    test('previous vanaf een latere stap gaat één terug', () {
      final previous = previousStepPointer(
        steps,
        const TrainingStepPointer(2),
      );
      expect(previous.index, 1);
    });
  });
}
