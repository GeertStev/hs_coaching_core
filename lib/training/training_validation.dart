import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_node.dart';

/// De diepte van [node]s eigen subboom, [node] zelf meegerekend als
/// niveau 1. Een oefening heeft altijd hoogte 1 (blad); een groep is
/// 1 + de hoogste hoogte van haar kinderen (0 als ze geen kinderen heeft).
///
/// Enige validatieregel van de hele Training-boom: een invoegpunt op
/// `parentLevel` mag [node] bevatten iff `parentLevel + subtreeHeight(node)
/// <= 3`. Zie `training-model-v2-unified-group.md` §4 — deze ene formule
/// dekt alle regels (Subset kan geen groep bevatten, een volle Set kan niet
/// in een andere Set, etc.) zonder per-geval uitzonderingen.
int subtreeHeight(TrainingNode node) => switch (node) {
  TrainingNodeExercise() => 1,
  TrainingNodeGroup(:final group) => 1 + _maxChildHeight(group.children),
};

int _maxChildHeight(List<TrainingNode> children) {
  var max = 0;
  for (final child in children) {
    final height = subtreeHeight(child);
    if (height > max) max = height;
  }
  return max;
}

/// Of elk root-kind van [training] binnen de max-diepte-3 blijft. Omdat
/// [subtreeHeight] al de diepste plek van een hele subboom teruggeeft,
/// volstaat één check per root-kind (`parentLevel` is 0 aan de root) —
/// geen aparte pad-gebaseerde boomwandeling nodig.
bool isValidTrainingTree(Training training) =>
    training.children.every((child) => subtreeHeight(child) <= 3);
