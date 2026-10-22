import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_status.dart';
import 'package:hs_coaching_core/training/training_step.dart';

/// Afgeleide, berekende voortgang van een `Training`-sessie op een gegeven
/// moment — zelfde rol als `TabataProgress`, maar vertrekkend van een
/// expliciet anker (`Training.currentStepIndex`) i.p.v. het begin van de
/// sessie (zie `training.dart`'s doc comment). Bevat geen Firestore-state;
/// wordt lokaal berekend, zowel in de coach-app als in de display-app.
class TrainingSessionProgress {
  const TrainingSessionProgress({
    required this.status,
    required this.currentStep,
    required this.stepIndex,
    required this.totalSteps,
    required this.remaining,
  });

  final TrainingStatus status;

  /// `null` zolang de sessie nog niet gestart is, of zodra alle stappen
  /// voorbij zijn (`status == TrainingStatus.finished`).
  final TrainingStep? currentStep;

  /// 0-gebaseerde index van [currentStep] in de platgeslagen tijdlijn; `-1`
  /// vóór de start, [totalSteps] zodra de sessie afgelopen is.
  final int stepIndex;
  final int totalSteps;

  /// Resterende tijd binnen [currentStep] — `null` als de stap ongetimed is
  /// of er geen huidige stap is.
  final Duration? remaining;

  bool get isFinished => status == TrainingStatus.finished;
  bool get isBeforeStart => stepIndex < 0;

  /// Resterende hele seconden, naar boven afgerond (een aftelklok toont
  /// "00:01" tot de stap echt om is). Coach-app en display gebruiken
  /// allebei deze waarde zodat ze dezelfde seconde tonen.
  int? get remainingSeconds {
    final remaining = this.remaining;
    if (remaining == null) return null;
    return (remaining.inMilliseconds / 1000).ceil();
  }

  /// `true` zolang de tijd iets verandert: de sessie loopt en staat op een
  /// getimede stap. Op een ongetimede stap of in pauze hoeft er niet getikt
  /// te worden.
  bool get isTicking =>
      status == TrainingStatus.running && currentStep?.isTimed == true;
}

/// Verstreken tijd sinds `Training.currentStepIndex` (het anker), in
/// server-clock ms — [nowServerMillis] moet al gecorrigeerd zijn voor
/// klokdrift (zie `serverNowMillis`).
int trainingElapsedMillis(Training training, int nowServerMillis) {
  var elapsed = training.accumulatedElapsedMillis;
  if (training.status == TrainingStatus.running) {
    final sinceStart = nowServerMillis - training.authoritativeStartTimeMillis;
    if (sinceStart > 0) elapsed += sinceStart;
  }
  return elapsed;
}

/// Berekent [TrainingSessionProgress] voor [steps] (= `flattenTraining` van
/// [training]) op [nowServerMillis].
TrainingSessionProgress trainingProgressAt(
  Training training,
  List<TrainingStep> steps, {
  required int nowServerMillis,
}) {
  return computeTrainingProgress(
    steps: steps,
    status: training.status,
    anchorStepIndex: training.currentStepIndex,
    elapsedSinceAnchorMillis: trainingElapsedMillis(training, nowServerMillis),
  );
}

/// Loopt vanaf [anchorStepIndex] met [elapsedSinceAnchorMillis] door de
/// getimede stappen: is een getimede stap om, dan gaat de resterende tijd
/// naar de volgende stap. Stopt bij een ongetimede stap (wacht op de
/// coach) of voorbij de laatste stap (`finished`). Zuiver en
/// Flutter-vrij, zie `training_session_progress_test.dart`.
TrainingSessionProgress computeTrainingProgress({
  required List<TrainingStep> steps,
  required TrainingStatus status,
  required int anchorStepIndex,
  required int elapsedSinceAnchorMillis,
}) {
  TrainingSessionProgress finished() => TrainingSessionProgress(
    status: TrainingStatus.finished,
    currentStep: null,
    stepIndex: steps.length,
    totalSteps: steps.length,
    remaining: null,
  );

  if (status == TrainingStatus.finished ||
      steps.isEmpty ||
      anchorStepIndex >= steps.length) {
    return finished();
  }

  if (anchorStepIndex < 0) {
    return TrainingSessionProgress(
      status: status,
      currentStep: null,
      stepIndex: -1,
      totalSteps: steps.length,
      remaining: null,
    );
  }

  var index = anchorStepIndex;
  var elapsed = elapsedSinceAnchorMillis;
  while (true) {
    if (index >= steps.length) return finished();
    final duration = steps[index].durationMillis;
    if (duration == null || elapsed < duration) break;
    elapsed -= duration;
    index++;
  }

  final step = steps[index];
  final duration = step.durationMillis;
  return TrainingSessionProgress(
    status: status,
    currentStep: step,
    stepIndex: index,
    totalSteps: steps.length,
    remaining: duration == null
        ? null
        : Duration(milliseconds: duration - elapsed),
  );
}
