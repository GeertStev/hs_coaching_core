import 'package:hs_coaching_core/training/training_status.dart';
import 'package:hs_coaching_core/training/training_step.dart';

/// Waar de sessie zich bevindt binnen de platgeslagen `List<TrainingStep>`
/// (zie `training_flatten.dart`) — vertaalbaar naar/vanuit
/// `Training.currentPath`/`currentGroupIndex`/`currentPhase` via
/// `training_navigation.dart`'s `pointerFor`.
class TrainingStepPointer {
  const TrainingStepPointer(this.index);

  /// Index in de platgeslagen stappenlijst. `-1` betekent "nog niet
  /// gestart" (vóór de eerste stap).
  final int index;

  bool get isBeforeStart => index < 0;
}

/// Afgeleide, berekende voortgang van een `Training`-sessie op een gegeven
/// moment — zelfde rol als `TabataProgress`, maar op basis van een
/// expliciete stap-pointer i.p.v. pure verstreken tijd (zie `training.dart`'s
/// doc comment voor waarom dat bij Training niet volstaat). Bevat geen
/// Firestore-state; wordt lokaal berekend, zowel in de coach-app als in de
/// display-app.
class TrainingSessionProgress {
  const TrainingSessionProgress({
    required this.status,
    required this.pointer,
    required this.currentStep,
    required this.stepIndex,
    required this.totalSteps,
    required this.remaining,
    required this.autoAdvanceDue,
  });

  final TrainingStatus status;
  final TrainingStepPointer pointer;

  /// `null` zodra de sessie nog niet gestart is, of alle stappen voorbij
  /// zijn (`status == TrainingStatus.finished`).
  final TrainingStep? currentStep;

  /// 0-gebaseerd; `-1` als [currentStep] `null` is.
  final int stepIndex;
  final int totalSteps;

  /// Resterende tijd binnen [currentStep] — `null` als de stap ongetimed is
  /// of er geen huidige stap is.
  final Duration? remaining;

  /// `true` zodra een getimede stap is afgelopen terwijl de sessie nog op
  /// `running` staat — het sein voor de coach-app's `TrainingScreenController`
  /// om zelf `next` te schrijven (zie `training.dart`'s doc comment). De
  /// display-app leest dit puur informatief; ze schrijft nooit.
  final bool autoAdvanceDue;

  bool get isFinished => status == TrainingStatus.finished;
}

/// Berekent [TrainingSessionProgress] voor [steps] op basis van de huidige
/// [status]/[pointer] en [elapsedInStepMillis] (verstreken tijd sinds
/// `Training.authoritativeStartTimeMillis`, al gecorrigeerd voor klokdrift
/// door de aanroeper — zie `serverNowMillis`).
TrainingSessionProgress computeTrainingProgress({
  required List<TrainingStep> steps,
  required TrainingStatus status,
  required TrainingStepPointer pointer,
  required int elapsedInStepMillis,
}) {
  if (status == TrainingStatus.finished ||
      steps.isEmpty ||
      pointer.index >= steps.length) {
    return TrainingSessionProgress(
      status: TrainingStatus.finished,
      pointer: TrainingStepPointer(steps.length - 1),
      currentStep: null,
      stepIndex: -1,
      totalSteps: steps.length,
      remaining: null,
      autoAdvanceDue: false,
    );
  }

  if (pointer.isBeforeStart) {
    return TrainingSessionProgress(
      status: status,
      pointer: pointer,
      currentStep: null,
      stepIndex: -1,
      totalSteps: steps.length,
      remaining: null,
      autoAdvanceDue: false,
    );
  }

  final step = steps[pointer.index];
  final duration = step.durationMillis;
  if (duration == null) {
    return TrainingSessionProgress(
      status: status,
      pointer: pointer,
      currentStep: step,
      stepIndex: pointer.index,
      totalSteps: steps.length,
      remaining: null,
      autoAdvanceDue: false,
    );
  }

  final remainingMillis = duration - elapsedInStepMillis;
  return TrainingSessionProgress(
    status: status,
    pointer: pointer,
    currentStep: step,
    stepIndex: pointer.index,
    totalSteps: steps.length,
    remaining: Duration(
      milliseconds: remainingMillis > 0 ? remainingMillis : 0,
    ),
    autoAdvanceDue: status == TrainingStatus.running && remainingMillis <= 0,
  );
}
