import 'package:hs_coaching_core/match/engine/match_roster.dart';

/// Waarom de engine een kandidaat-event weigert. De UI toont de reden (bv.
/// bij een lange druk op een grijze knop).
///
/// Elke subklasse hoort bij één soort actie en draagt een enum met de
/// precieze reden, bv. `TimeOutNotAllowed(TimeOutProblem.playRunning)`.
sealed class MatchRejection {
  const MatchRejection();

  /// Enum-waarde met de precieze reden.
  Enum get problem;

  @override
  bool operator ==(Object other) =>
      other is MatchRejection &&
      other.runtimeType == runtimeType &&
      other.problem == problem;

  @override
  int get hashCode => Object.hash(runtimeType, problem);

  @override
  String toString() => '$runtimeType.${problem.name}';
}

/// Redenen die voor elk event gelden.
enum GeneralProblem {
  /// Er is nog geen `MatchCreated`.
  matchNotCreated,

  /// Een tweede `MatchCreated`.
  matchAlreadyCreated,

  /// De wedstrijd is afgesloten (`finalized`).
  matchFinal,

  /// De actie kan niet in deze fase.
  wrongPhase,

  /// Kapnummer buiten 1–15.
  capOutOfRange,

  /// De speler is voor de rest van de wedstrijd uitgesloten.
  playerDismissed,
}

class EventNotAllowed extends MatchRejection {
  const EventNotAllowed(this.problem);
  @override
  final GeneralProblem problem;
}

enum PlayProblem {
  /// `PlayStarted` terwijl het spel al loopt.
  alreadyRunning,

  /// `PlayStopped` terwijl het spel al stilligt.
  notRunning,

  /// De klok staat op 0: bevestig eerst het einde van de periode.
  periodExpired,
}

class PlayNotAllowed extends MatchRejection {
  const PlayNotAllowed(this.problem);
  @override
  final PlayProblem problem;
}

/// 14.2.6.
enum TimeOutProblem {
  playRunning,
  alreadyUsedThisHalf,

  /// Rust, overtime, sudden death of buiten de wedstrijd.
  notInRegularPeriod,
  penaltyShotPending,
}

class TimeOutNotAllowed extends MatchRejection {
  const TimeOutNotAllowed(this.problem);
  @override
  final TimeOutProblem problem;
}

enum PeriodEndProblem {
  /// Het event noemt een andere fase dan de lopende.
  wrongPhase,
  clockNotExpired,

  /// Een toegekende strafworp moet eerst gespeeld worden (17.8.6).
  penaltyShotPending,
}

class PeriodEndNotAllowed extends MatchRejection {
  const PeriodEndNotAllowed(this.problem);
  @override
  final PeriodEndProblem problem;
}

class RosterInvalid extends MatchRejection {
  const RosterInvalid(this.problem);
  @override
  final RosterProblem problem;
}

enum PenaltyShotProblem {
  alreadyPending,
  noShotPending,

  /// Een gekozen speler zit in de strafbank (17.8.2.3).
  playerInPenaltyBox,
  playerDismissed,
}

class PenaltyShotNotAllowed extends MatchRejection {
  const PenaltyShotNotAllowed(this.problem);
  @override
  final PenaltyShotProblem problem;
}

enum PenaltyReturnProblem {
  /// Geen afgelopen straf van die speler die op vrijgave wacht.
  noExpiredPenalty,
}

class PenaltyReturnNotAllowed extends MatchRejection {
  const PenaltyReturnNotAllowed(this.problem);
  @override
  final PenaltyReturnProblem problem;
}

enum VoidProblem {
  unknownTarget,
  alreadyVoided,

  /// `MatchCreated` kan niet ongeldig gemaakt worden.
  matchCreated,

  /// Een `EventVoided` kan zelf niet ongeldig gemaakt worden.
  voidEvent,
}

class VoidNotAllowed extends MatchRejection {
  const VoidNotAllowed(this.problem);
  @override
  final VoidProblem problem;
}

enum SignOffProblem {
  /// Gelijkspel terwijl een winnaar vereist is en overtime en sudden death
  /// uit staan: eerst `ResultDecidedByDelegate` (OPEN-10).
  winnerRequired,
}

class SignOffNotAllowed extends MatchRejection {
  const SignOffNotAllowed(this.problem);
  @override
  final SignOffProblem problem;
}

enum StopReasonProblem {
  /// Het doel is geen (geldig) `PlayStopped`.
  unknownTarget,
}

class StopReasonNotAllowed extends MatchRejection {
  const StopReasonNotAllowed(this.problem);
  @override
  final StopReasonProblem problem;
}
