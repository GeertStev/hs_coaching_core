import 'dart:math' as math;

import 'package:hs_coaching_core/training/training_exercise.dart';
import 'package:hs_coaching_core/training/training_node.dart';

/// Toestand van één balkje (of groepskader) in de voortgangsbalk van het
/// zwembadscherm.
enum ProgressItemState { upcoming, current, done }

/// Eén element van de voortgangsbalk: een oefening (balkje) of een
/// set/subset (kader rond zijn kinderen). Herhalingen worden niet uitgerold:
/// elk element staat er één keer, met de teller `completed / count` eronder.
sealed class ProgressItem {
  const ProgressItem({
    required this.nodeId,
    required this.count,
    required this.counter,
    required this.state,
  });

  final String nodeId;

  /// Aantal herhalingen (≥ 1).
  final int count;

  /// Teller onder het element: 0 = nog niet begonnen, de lopende ronde
  /// (1-gebaseerd) tijdens het element, [count] als het af is. Reset naar 0
  /// wanneer de ouder een nieuwe ronde begint.
  final int counter;
  final ProgressItemState state;

  /// Breedtegewicht: banen van één doorloop (zie de subklassen).
  int get lengths;
}

/// Een oefening. [lengths] = banen van alle herhalingen samen (wat de
/// oefening bijdraagt aan één ronde van zijn ouder); bij een group split de
/// groep met de meeste banen.
class ProgressExercise extends ProgressItem {
  const ProgressExercise({
    required super.nodeId,
    required super.count,
    required super.counter,
    required super.state,
    required this.lengths,
  });

  @override
  final int lengths;
}

/// Een set of subset. [lengths] = som van de kinderen (één ronde); de eigen
/// herhalingen staan enkel in de teller, want de kinderen staan er ook maar
/// één keer.
class ProgressGroup extends ProgressItem {
  const ProgressGroup({
    required super.nodeId,
    required super.count,
    required super.counter,
    required super.state,
    required this.children,
  });

  final List<ProgressItem> children;

  @override
  int get lengths => children.fold(0, (sum, child) => sum + child.lengths);
}

/// Voortgangsbalk voor [nodes] wanneer weergavestap [displayIndex] loopt
/// (`-1` vóór de start, het aantal stappen of meer als de training klaar is).
/// Volgt dezelfde volgorde als `buildDisplayTimeline`: één weergavestap per
/// herhaling van een oefening. Lege groepen vallen weg. Pure Dart, getest in
/// `test/training/display/display_progress_test.dart`.
List<ProgressItem> buildProgressBar(
  List<TrainingNode> nodes,
  int displayIndex,
) => _items(nodes, start: 0, at: displayIndex);

List<ProgressItem> _items(
  List<TrainingNode> nodes, {
  required int start,
  required int at,
}) {
  final items = <ProgressItem>[];
  var cursor = start;
  for (final node in nodes) {
    final total = _stepCount(node);
    if (total == 0) continue;
    final count = _repeatCount(node);
    final perRound = total ~/ count;

    // Lopende ronde (0-gebaseerd) en teller; vóór het element ronde 0, na
    // het element de laatste ronde (kinderen staan dan allemaal op af).
    final ProgressItemState state;
    final int round;
    final int counter;
    if (at < cursor) {
      state = ProgressItemState.upcoming;
      round = 0;
      counter = 0;
    } else if (at >= cursor + total) {
      state = ProgressItemState.done;
      round = count - 1;
      counter = count;
    } else {
      state = ProgressItemState.current;
      round = (at - cursor) ~/ perRound;
      counter = round + 1;
    }

    switch (node) {
      case TrainingNodeExercise(:final exercise):
        items.add(
          ProgressExercise(
            nodeId: exercise.id,
            count: count,
            counter: counter,
            state: state,
            lengths: _exerciseLengths(exercise) * count,
          ),
        );
      case TrainingNodeGroup(:final group):
        items.add(
          ProgressGroup(
            nodeId: group.id,
            count: count,
            counter: counter,
            state: state,
            children: _items(
              group.children,
              start: cursor + round * perRound,
              at: at,
            ),
          ),
        );
    }
    cursor += total;
  }
  return items;
}

int _repeatCount(TrainingNode node) => math.max(1, switch (node) {
  TrainingNodeExercise(:final exercise) => exercise.repeatCount,
  TrainingNodeGroup(:final group) => group.repeatCount,
});

/// Aantal weergavestappen van [node] met al zijn herhalingen.
int _stepCount(TrainingNode node) => switch (node) {
  TrainingNodeExercise() => _repeatCount(node),
  TrainingNodeGroup(:final group) =>
    _repeatCount(node) * group.children.fold(0, (s, c) => s + _stepCount(c)),
};

/// Banen van één herhaling; bij een group split de grootste groep (zelfde
/// regel als `DisplayStep.lengths`).
int _exerciseLengths(TrainingExercise exercise) {
  var max = 0;
  for (final group in exercise.groups) {
    final lengths = group.parameterRows.fold(
      0,
      (sum, row) => sum + (row.reps ?? 0),
    );
    if (lengths > max) max = lengths;
  }
  return max;
}
