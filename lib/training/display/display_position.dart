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

  bool get isBeforeStart => displayIndex < 0;
  bool get isFinished => current == null && !isBeforeStart;
}

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
    );
  }

  final index = timeline.displayIndexByStep[progress.stepIndex];
  final current = steps[index];
  final next = index + 1 < steps.length ? steps[index + 1] : null;

  return TrainingDisplayPosition(
    status: progress.status,
    displayIndex: index,
    current: current,
    next: next,
    transition: transitionBetween(current, next),
    timers: _timers(step, progress),
    lengthsDone: timeline.lengthsBefore(index),
    lengthsTotal: total,
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
