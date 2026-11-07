import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/training/display/display_position.dart';
import 'package:hs_coaching_core/training/display/display_progress.dart';
import 'package:hs_coaching_core/training/display/display_timeline.dart';
import 'package:hs_coaching_core/training/training_flatten.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_status.dart';

import 'example_training.dart';

/// Compacte weergave: `id counter/count state`, kinderen tussen haakjes.
String describe(List<ProgressItem> items) => items
    .map((item) {
      final own =
          '${item.nodeId} ${item.counter}/${item.count} ${item.state.name}';
      return switch (item) {
        ProgressGroup(:final children) => '$own [${describe(children)}]',
        ProgressExercise() => own,
      };
    })
    .join(', ');

void main() {
  // Weergavestappen: 0 warmup, 1 group split, 2-3 ex1, 4-5 ex2 (subset ronde
  // 1), 6-7 ex1, 8-9 ex2 (ronde 2), 10 group split set 2, ...
  List<ProgressItem> at(int index) =>
      buildProgressBar(exampleTraining.children, index);

  test('vóór de start staat alles op 0', () {
    expect(
      describe(at(-1)),
      'warmup 0/1 upcoming, set 0/2 upcoming [gs 0/1 upcoming, '
      'sub 0/2 upcoming [ex1 0/2 upcoming, ex2 0/2 upcoming]]',
    );
  });

  test('tweede herhaling van oefening 1 in subset-ronde 1', () {
    expect(
      describe(at(3)),
      'warmup 1/1 done, set 1/2 current [gs 1/1 done, '
      'sub 1/2 current [ex1 2/2 current, ex2 0/2 upcoming]]',
    );
  });

  test('nieuwe subset-ronde zet de oefeningen terug op 0', () {
    expect(
      describe(at(6)),
      'warmup 1/1 done, set 1/2 current [gs 1/1 done, '
      'sub 2/2 current [ex1 1/2 current, ex2 0/2 upcoming]]',
    );
  });

  test('nieuwe set-ronde zet ook de subset terug', () {
    expect(
      describe(at(10)),
      'warmup 1/1 done, set 2/2 current [gs 1/1 current, '
      'sub 0/2 upcoming [ex1 0/2 upcoming, ex2 0/2 upcoming]]',
    );
  });

  test('na het einde staat alles op af', () {
    expect(
      describe(at(19)),
      'warmup 1/1 done, set 2/2 done [gs 1/1 done, '
      'sub 2/2 done [ex1 2/2 done, ex2 2/2 done]]',
    );
  });

  test('breedtegewicht: banen per ronde van de ouder', () {
    final items = at(0);
    expect(items[0].lengths, 35); // warmup
    final set = items[1] as ProgressGroup;
    expect(set.children[0].lengths, 25); // group split: Hard
    final sub = set.children[1] as ProgressGroup;
    expect(sub.children[0].lengths, 4); // 2 banen × 2 herhalingen
    expect(sub.lengths, 8);
    expect(set.lengths, 33);
  });

  group('volgende oefening in de positie', () {
    final phases = flattenTraining(exampleTraining);
    final timeline = buildDisplayTimeline(exampleTraining);

    TrainingDisplayPosition position(int displayIndex) => displayPositionAt(
      timeline,
      computeTrainingProgress(
        steps: phases,
        status: TrainingStatus.paused,
        anchorStepIndex: timeline.steps[displayIndex].firstStepIndex,
        elapsedSinceAnchorMillis: 0,
      ),
    );

    test('eerste herhaling: volgende oefening slaat herhaling 2 over', () {
      final p = position(2);
      expect(p.current?.exerciseId, 'ex1');
      expect(p.next?.exerciseId, 'ex1');
      expect(p.nextExercise?.exerciseId, 'ex2');
      expect(p.nextExercise?.path.repetition.index, 0);
      expect(p.isLastRepetition, isFalse);
    });

    test('laatste herhaling van de subset: weer oefening 1', () {
      final p = position(5);
      expect(p.isLastRepetition, isTrue);
      expect(p.nextExercise?.exerciseId, 'ex1');
      expect(p.nextExercise?.path.subset?.index, 1);
    });

    test('warmup (1 herhaling) is meteen de laatste', () {
      final p = position(0);
      expect(p.isLastRepetition, isTrue);
      expect(p.nextExercise?.exerciseId, 'gs');
      expect(p.progressBar.first.state, ProgressItemState.current);
    });

    test('laatste oefening: geen volgende', () {
      final p = position(17);
      expect(p.nextExercise, isNull);
      expect(p.isLastRepetition, isFalse);
      expect(position(18).isLastRepetition, isTrue);
      expect(position(18).nextExercise, isNull);
    });
  });
}
