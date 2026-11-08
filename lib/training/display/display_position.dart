import 'package:hs_coaching_core/training/display/display_progress.dart';
import 'package:hs_coaching_core/training/display/display_step.dart';
import 'package:hs_coaching_core/training/display/display_timeline.dart';
import 'package:hs_coaching_core/training/display/display_transition.dart';
import 'package:hs_coaching_core/training/training_session_progress.dart';
import 'package:hs_coaching_core/training/training_status.dart';
import 'package:hs_coaching_core/training/training_step.dart';
import 'package:hs_coaching_core/training/training_step_phase.dart';

/// Timer van één groep in de huidige stap (één bij een gewone oefening, één
/// per groep bij een group split).
class DisplayGroupTimer {
  const DisplayGroupTimer({
    required this.phase,
    required this.remainingSeconds,
  });

  final TrainingStepPhase phase;

  /// Hele seconden, naar boven afgerond; `null` = ongetimed.
  final int? remainingSeconds;
}

/// Alles wat het zwembadscherm op een moment toont, afgeleid uit de
/// bestaande [TrainingSessionProgress] — geen eigen klok of state.
class TrainingDisplayPosition {
  const TrainingDisplayPosition({
    required this.status,
    required this.displayIndex,
    required this.current,
    required this.next,
    required this.transition,
    required this.timers,
    required this.lengthsDone,
    required this.lengthsTotal,
    this.nextExercise,
    this.isLastRepetition = false,
    this.focusOnNext = false,
    this.progressBar = const [],
  });

  final TrainingStatus status;

  /// Index van [current]; `-1` vóór de start, `steps.length` als klaar.
  final int displayIndex;
  final DisplayStep? current;

  /// De volgende stap; vóór de start de eerste stap.
  final DisplayStep? next;

  /// Overgang van [current] naar [next]; `null` vóór de start.
  final DisplayTransition? transition;
  final List<DisplayGroupTimer> timers;

  /// Banen vóór het begin van de huidige stap (geen voortgang binnen een stap).
  final int lengthsDone;
  final int lengthsTotal;

  /// De eerste stap van de volgende oefening (de herhalingen van de huidige
  /// oefening overgeslagen); vóór de start de eerste stap, `null` na de
  /// laatste oefening.
  final DisplayStep? nextExercise;

  /// De huidige stap is de laatste herhaling van zijn oefening.
  final bool isLastRepetition;

  /// Waar de focus (oranje kader) staat: `true` = op [nextExercise], anders
  /// op de huidige oefening (zie [focusOnCurrent]). Vóór de start op de
  /// eerste oefening; tijdens de laatste herhaling verspringt hij naar de
  /// volgende oefening zodra die rust begint, of — zonder rust —
  /// [kFocusSwitchBeforeEndMillis] voor het einde. Na de laatste oefening
  /// blijft hij op de huidige.
  final bool focusOnNext;

  /// Voortgangsbalk (set › subset › oefening, niet uitgerold).
  final List<ProgressItem> progressBar;

  /// De huidige oefening heeft de focus (er is een huidige oefening en de
  /// focus staat niet op de volgende).
  bool get focusOnCurrent => current != null && !focusOnNext;

  bool get isBeforeStart => displayIndex < 0;
  bool get isFinished => current == null && !isBeforeStart;
}

/// Zonder rust verspringt de focus zoveel ms voor het einde van de laatste
/// herhaling naar de volgende oefening.
const int kFocusSwitchBeforeEndMillis = 5000;

/// Vertaalt [progress] (fase-niveau) naar de weergave-positie in [timeline].
TrainingDisplayPosition displayPositionAt(
  TrainingDisplayTimeline timeline,
  TrainingSessionProgress progress,
) {
  final steps = timeline.steps;
  final total = timeline.totalLengths;

  if (progress.isBeforeStart && !progress.isFinished) {
    return TrainingDisplayPosition(
      status: progress.status,
      displayIndex: -1,
      current: null,
      next: steps.isEmpty ? null : steps.first,
      transition: null,
      timers: const [],
      lengthsDone: 0,
      lengthsTotal: total,
      nextExercise: steps.isEmpty ? null : steps.first,
      focusOnNext: steps.isNotEmpty,
      progressBar: buildProgressBar(timeline.nodes, -1),
    );
  }

  final step = progress.currentStep;
  if (progress.isFinished ||
      step == null ||
      progress.stepIndex >= timeline.displayIndexByStep.length) {
    return TrainingDisplayPosition(
      status: progress.status,
      displayIndex: steps.length,
      current: null,
      next: null,
      transition: DisplayTransition.done,
      timers: const [],
      lengthsDone: total,
      lengthsTotal: total,
      progressBar: buildProgressBar(timeline.nodes, steps.length),
    );
  }

  final index = timeline.displayIndexByStep[progress.stepIndex];
  final current = steps[index];
  final next = index + 1 < steps.length ? steps[index + 1] : null;
  final repetition = current.path.repetition;
  final nextExerciseIndex = index + repetition.count - repetition.index;
  final isLastRepetition = repetition.index == repetition.count - 1;
  final hasNextExercise = nextExerciseIndex < steps.length;

  return TrainingDisplayPosition(
    status: progress.status,
    displayIndex: index,
    current: current,
    next: next,
    transition: transitionBetween(current, next),
    timers: _timers(step, progress),
    lengthsDone: timeline.lengthsBefore(index),
    lengthsTotal: total,
    nextExercise: hasNextExercise ? steps[nextExerciseIndex] : null,
    isLastRepetition: isLastRepetition,
    focusOnNext:
        isLastRepetition &&
        hasNextExercise &&
        _nearEnd(current, step, progress),
    progressBar: buildProgressBar(timeline.nodes, index),
  );
}

List<DisplayGroupTimer> _timers(
  TrainingStep step,
  TrainingSessionProgress progress,
) {
  if (!step.isGroupSplit) {
    return [
      DisplayGroupTimer(
        phase: step.phase,
        remainingSeconds: progress.remainingSeconds,
      ),
    ];
  }
  final duration = step.durationMillis;
  final remaining = progress.remaining?.inMilliseconds;
  final elapsed = duration == null || remaining == null
      ? 0
      : duration - remaining;
  return [
    for (final state in parallelGroupStatesAt(step, elapsed))
      DisplayGroupTimer(
        phase: state.phase,
        remainingSeconds: state.remainingMillis == null
            ? null
            : (state.remainingMillis! / 1000).ceil(),
      ),
  ];
}

/// Of [step] (fase-niveau, binnen weergavestap [current]) zo ver is dat de focus naar de volgende oefening
/// mag: in de rust, of — als de oefening geen rust heeft — de laatste
/// [kFocusSwitchBeforeEndMillis]. Een ongetimede stap wacht op de coach en
/// houdt de focus.
bool _nearEnd(
  DisplayStep current,
  TrainingStep step,
  TrainingSessionProgress progress,
) {
  final remaining = progress.remaining?.inMilliseconds;
  final duration = step.durationMillis;
  if (remaining == null || duration == null) return false;

  if (!step.isGroupSplit) {
    if (step.phase == TrainingStepPhase.rest) return true;
    // Werk-stap: heeft de oefening rust, dan wacht de focus op die rust.
    final hasRest = current.groups.any((group) => group.restSeconds > 0);
    return !hasRest && remaining <= kFocusSwitchBeforeEndMillis;
  }

  // Group split: rust zodra de laatst werkende groep klaar is.
  var workEnd = 0;
  for (final group in step.parallelGroups) {
    final work = group.workMillis;
    if (work != null && work > workEnd) workEnd = work;
  }
  final elapsed = duration - remaining;
  if (workEnd < duration) return elapsed >= workEnd;
  return remaining <= kFocusSwitchBeforeEndMillis;
}
