import 'package:hs_coaching_core/training/training_path.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_step.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

/// Zoekt de index van de stap die bij [path]/[groupIndex]/[phase] hoort —
/// vertaalt `Training.currentPath`/`currentGroupIndex`/`currentPhase` naar
/// een positie in [steps] (zie `training_flatten.dart`). `-1` als [path]
/// leeg is (nog niet gestart) of niet (meer) voorkomt in [steps] (bv. de
/// boom is intussen bewerkt in de editor-tab, zie de openstaande punten in
/// het implementatieplan).
TrainingStepPointer pointerFor(
  List<TrainingStep> steps, {
  required TrainingPath path,
  required int groupIndex,
  required TrainingStepPhase phase,
}) {
  if (path.isEmpty) return const TrainingStepPointer(-1);
  final index = steps.indexWhere(
    (step) =>
        _pathEquals(step.path, path) &&
        step.groupIndex == groupIndex &&
        step.phase == phase,
  );
  return TrainingStepPointer(index);
}

/// Eén stap vooruit. Loopt de pointer voorbij de laatste stap uit (index ==
/// `steps.length`) zodra [current] al op de laatste stap stond —
/// `computeTrainingProgress` herkent dat als het einde van de sessie en
/// zet zelf `status = finished`; de aanroeper (de repository-writer) is
/// verantwoordelijk om dat ook daadwerkelijk naar Firestore te schrijven.
TrainingStepPointer nextStepPointer(
  List<TrainingStep> steps,
  TrainingStepPointer current,
) {
  final nextIndex = current.index + 1;
  return TrainingStepPointer(
    nextIndex > steps.length ? steps.length : nextIndex,
  );
}

/// Eén stap terug; blijft op de eerste stap staan (index 0) — gaat nooit
/// terug naar "nog niet gestart" (-1), want previous is alleen zinvol
/// tijdens een lopende sessie.
TrainingStepPointer previousStepPointer(
  List<TrainingStep> steps,
  TrainingStepPointer current,
) {
  final prevIndex = current.index - 1;
  return TrainingStepPointer(prevIndex < 0 ? 0 : prevIndex);
}

bool _pathEquals(TrainingPath a, TrainingPath b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
