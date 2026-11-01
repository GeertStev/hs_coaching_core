import 'package:hs_coaching_core/training/display/display_step.dart';

/// Overgang van de huidige naar de volgende weergavestap, bepaald door het
/// hoogste niveau van het pad dat verandert.
enum DisplayTransition {
  /// Van buiten een set naar een set.
  enterSet,

  /// Van de ene set naar een andere set (andere groep).
  newSet,

  /// Dezelfde set, volgende herhaling.
  repeatSet,

  /// Van buiten een subset naar een subset.
  enterSubset,

  /// Van de ene subset naar een andere subset.
  newSubset,

  /// Dezelfde subset, volgende herhaling.
  repeatSubset,

  /// Een andere oefening (ook bij het verlaten van een set of subset).
  newExercise,

  /// Dezelfde oefening, volgende herhaling.
  nextRepetition,

  /// Er is geen volgende stap meer.
  done,
}

/// Bepaalt de overgang van [current] naar [next] (`null` = einde).
DisplayTransition transitionBetween(DisplayStep current, DisplayStep? next) {
  if (next == null) return DisplayTransition.done;
  final a = current.path;
  final b = next.path;

  final set = _groupLevel(
    a.set,
    b.set,
    enter: DisplayTransition.enterSet,
    other: DisplayTransition.newSet,
    repeat: DisplayTransition.repeatSet,
  );
  if (set != null) return set;

  final subset = _groupLevel(
    a.subset,
    b.subset,
    enter: DisplayTransition.enterSubset,
    other: DisplayTransition.newSubset,
    repeat: DisplayTransition.repeatSubset,
  );
  if (subset != null) return subset;

  if (a.exercise != b.exercise) return DisplayTransition.newExercise;
  return DisplayTransition.nextRepetition;
}

DisplayTransition? _groupLevel(
  LevelPosition? a,
  LevelPosition? b, {
  required DisplayTransition enter,
  required DisplayTransition other,
  required DisplayTransition repeat,
}) {
  if (a == null && b == null) return null;
  if (a == null) return enter;
  // Een set/subset verlaten naar een losse oefening erboven.
  if (b == null) return DisplayTransition.newExercise;
  if (a.nodeId != b.nodeId) return other;
  if (a.index != b.index) return repeat;
  return null;
}

/// Of [transition] een niveau opnieuw doorloopt (toont ↻).
bool isRepeatTransition(DisplayTransition transition) =>
    transition == DisplayTransition.repeatSet ||
    transition == DisplayTransition.repeatSubset;
