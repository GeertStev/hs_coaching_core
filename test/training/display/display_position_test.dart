import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/display/display_position.dart';
import 'package:hs_coaching_core/training/display/display_timeline.dart';
import 'package:hs_coaching_core/training/display/display_transition.dart';
import 'package:hs_coaching_core/training/training_flatten.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_status.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

import 'example_training.dart';

void main() {
  final phases = flattenTraining(exampleTraining);
  final timeline = buildDisplayTimeline(exampleTraining);

  TrainingDisplayPosition at(int elapsedSeconds, {int anchor = 0}) =>
      displayPositionAt(
        timeline,
        computeTrainingProgress(
          steps: phases,
          status: TrainingStatus.running,
          anchorStepIndex: anchor,
          elapsedSinceAnchorMillis: elapsedSeconds * 1000,
        ),
      );

  test('vóór de start: geen huidige stap, Daarna = eerste stap', () {
    final position = displayPositionAt(
      timeline,
      computeTrainingProgress(
        steps: phases,
        status: TrainingStatus.idle,
        anchorStepIndex: -1,
        elapsedSinceAnchorMillis: 0,
      ),
    );
    expect(position.isBeforeStart, isTrue);
    expect(position.current, isNull);
    expect(position.next?.exerciseId, 'warmup');
    expect(position.lengthsDone, 0);
    expect(position.lengthsTotal, 117);
  });

  test('warmup: werk en daarna rust in dezelfde weergavestap', () {
    final work = at(3);
    expect(work.displayIndex, 0);
    expect(work.timers.single.phase, TrainingStepPhase.work);
    expect(work.timers.single.remainingSeconds, 7);
    expect(work.transition, DisplayTransition.enterSet);

    final rest = at(14);
    expect(rest.displayIndex, 0);
    expect(rest.timers.single.phase, TrainingStepPhase.rest);
    expect(rest.timers.single.remainingSeconds, 6);
  });

  test('group split loopt tegelijk; de langste groep bepaalt de stap', () {
    // warmup = 20 s; group split begint op 20 s en duurt 25 s (Hard 15+10).
    final early = at(20 + 6);
    expect(early.displayIndex, 1);
    expect(early.lengthsDone, 35);
    expect(early.timers.map((t) => t.phase), [
      TrainingStepPhase.work,
      TrainingStepPhase.work,
    ]);
    expect(early.timers.map((t) => t.remainingSeconds), [9, 4]);

    final easyResting = at(20 + 12);
    expect(easyResting.timers.map((t) => t.phase), [
      TrainingStepPhase.work,
      TrainingStepPhase.rest,
    ]);
    // Easy rust tot de stap om is (25 − 12 = 13 s), niet enkel 10 s.
    expect(easyResting.timers.map((t) => t.remainingSeconds), [3, 13]);

    final afterSplit = at(20 + 25);
    expect(afterSplit.displayIndex, 2);
  });

  test('stap 10 → set opnieuw, Daarna = group split van set 2', () {
    final index = timeline.steps[9].firstStepIndex;
    final position = at(17, anchor: index); // rust: 15 s werk voorbij
    expect(position.displayIndex, 9);
    expect(position.timers.single.phase, TrainingStepPhase.rest);
    expect(position.timers.single.remainingSeconds, 8);
    expect(position.transition, DisplayTransition.repeatSet);
    expect(position.next?.isGroupSplit, isTrue);
    expect(position.next?.path.set?.index, 1);
    expect(position.lengthsDone, 74);
  });

  test('na de laatste stap: klaar', () {
    final position = at(0, anchor: phases.length);
    expect(position.isFinished, isTrue);
    expect(position.lengthsDone, 117);
    expect(position.next, isNull);
  });
}
