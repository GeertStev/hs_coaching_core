import 'package:hs_coaching_core/training/training_session_progress.dart';

/// Doel-index voor "volgende" vanaf de huidige [progress] — het nieuwe anker
/// (`Training.currentStepIndex`). Vóór de start is dat de eerste stap;
/// `progress.totalSteps` betekent "voorbij de laatste stap": de aanroeper
/// schrijft dan `status = finished`.
int nextStepIndex(TrainingSessionProgress progress) {
  if (progress.isBeforeStart) return 0;
  final next = progress.stepIndex + 1;
  return next > progress.totalSteps ? progress.totalSteps : next;
}

/// Doel-index voor "vorige"; blijft op de eerste stap staan en gaat nooit
/// terug naar "nog niet gestart". Vanuit een afgelopen sessie is dat de
/// laatste stap. `null` als er niets terug te gaan is (niet gestart, of een
/// lege training).
int? previousStepIndex(TrainingSessionProgress progress) {
  if (progress.isBeforeStart || progress.totalSteps == 0) return null;
  final previous = progress.stepIndex - 1;
  return previous < 0 ? 0 : previous;
}
