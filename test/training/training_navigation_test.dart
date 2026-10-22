import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/training_navigation.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_status.dart';

TrainingSessionProgress _at(int stepIndex, {int totalSteps = 3}) =>
    TrainingSessionProgress(
      status: stepIndex >= totalSteps
          ? TrainingStatus.finished
          : TrainingStatus.running,
      currentStep: null,
      stepIndex: stepIndex,
      totalSteps: totalSteps,
      remaining: null,
    );

void main() {
  group('nextStepIndex', () {
    test('vóór de start gaat naar de eerste stap', () {
      expect(nextStepIndex(_at(-1)), 0);
    });

    test('gaat één stap vooruit', () {
      expect(nextStepIndex(_at(1)), 2);
    });

    test('vanaf de laatste stap naar voorbij het einde', () {
      expect(nextStepIndex(_at(2)), 3);
    });

    test('blijft voorbij het einde staan', () {
      expect(nextStepIndex(_at(3)), 3);
    });
  });

  group('previousStepIndex', () {
    test('vóór de start: niets', () {
      expect(previousStepIndex(_at(-1)), isNull);
    });

    test('blijft op de eerste stap staan', () {
      expect(previousStepIndex(_at(0)), 0);
    });

    test('gaat één stap terug', () {
      expect(previousStepIndex(_at(2)), 1);
    });

    test('vanuit een afgelopen sessie naar de laatste stap', () {
      expect(previousStepIndex(_at(3)), 2);
    });
  });
}
