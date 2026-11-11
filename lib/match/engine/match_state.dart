import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_roster.dart';
import 'package:hs_coaching_core/team/team_model.dart';

/// Status van een straf (02-match-engine.md §4).
enum PenaltyStatus {
  /// Gegeven, maar het spel is nog niet herstart (17.3.1.1.1).
  pending,
  running,

  /// Gestart, maar de straftijd staat nu stil.
  paused,

  /// Afgelopen terwijl het spel stillag: de speler wacht op vrijgave door de
  /// hoofdscheidsrechter (17.3.1.2.3).
  expiredWaiting,
  served,

  /// Totale uitsluiting voor de rest van de wedstrijd.
  dismissal,
}

/// Eén tijdstraf of uitsluiting.
class PenaltyRecord {
  const PenaltyRecord({
    required this.eventId,
    required this.team,
    required this.cap,
    required this.minutes,
    required this.infringementCode,
    required this.deliberate,
    required this.status,
    required this.remaining,
  });

  /// Id van het `TimePenaltyGiven`- of `PlayerDismissed`-event.
  final String eventId;
  final TeamColor team;
  final int cap;

  /// `null` voor een uitsluiting.
  final int? minutes;
  final String infringementCode;
  final bool deliberate;
  final PenaltyStatus status;

  /// Resterende straftijd; `Duration.zero` voor een uitsluiting.
  final Duration remaining;

  /// De speler zit nog in de strafbank en mag dus niet aan een strafworp
  /// deelnemen (17.8.2.3).
  bool get inPenaltyBox => switch (status) {
    PenaltyStatus.pending ||
    PenaltyStatus.running ||
    PenaltyStatus.paused ||
    PenaltyStatus.expiredWaiting => true,
    PenaltyStatus.served || PenaltyStatus.dismissal => false,
  };
}

class GoalRecord {
  const GoalRecord({
    required this.eventId,
    required this.team,
    required this.scorerCap,
    required this.kind,
    required this.phase,
    required this.elapsedInPhase,
    required this.serverTimeMillis,
  });

  final String eventId;
  final TeamColor team;
  final int? scorerCap;
  final GoalKind kind;
  final MatchPhase phase;

  /// Verstreken wedstrijdtijd in [phase] op het moment van de goal.
  final Duration elapsedInPhase;
  final int serverTimeMillis;
}

class CautionRecord {
  const CautionRecord({
    required this.eventId,
    required this.team,
    required this.cap,
    required this.infringementCode,
    required this.deliberate,
    required this.isTeamCaution,
  });

  final String eventId;
  final TeamColor team;
  final int? cap;
  final String infringementCode;
  final bool deliberate;
  final bool isTeamCaution;
}

enum TimeOutKind { officials, team }

class ActiveTimeOut {
  const ActiveTimeOut({
    required this.kind,
    required this.team,
    required this.startedAtMillis,
  });

  final TimeOutKind kind;

  /// Alleen ingevuld voor een team time-out.
  final TeamColor? team;

  /// Server-tijd waarop de time-out begint. Bij een aaneengeschakelde team
  /// time-out (14.2.6.5) is dat het einde van de vorige.
  final int startedAtMillis;
}

class PenaltyShotRecord {
  const PenaltyShotRecord({
    required this.eventId,
    required this.awardedTo,
    required this.outcome,
    required this.attackers,
    required this.defender,
  });

  final String eventId;
  final TeamColor awardedTo;
  final PenaltyShotOutcome outcome;
  final List<int> attackers;
  final int? defender;
}

class ProtestRecord {
  const ProtestRecord({
    required this.eventId,
    required this.team,
    required this.by,
    required this.text,
  });

  final String eventId;
  final TeamColor team;
  final String by;
  final String text;
}

/// Hoe de wedstrijd eindigde.
enum MatchOutcomeKind { played, forfeited, abandoned }

/// De toestand van één wedstrijd, afgeleid uit haar event log
/// (02-match-engine.md §4). Alleen `reduceMatch` maakt er een aan.
///
/// Alle tijden gelden op [asOfMillis] (het tijdstip van het laatste event).
/// Voor "nu" gebruik je `clockViewAt(state, nowServerMs)`: klokken worden
/// berekend, nooit opgeslagen of getickt.
abstract interface class MatchState {
  /// `false` zolang er geen `MatchCreated` is.
  bool get created;
  String? get matchId;

  /// De snapshot uit `MatchCreated`; `null` zolang [created] false is.
  MatchConfig? get config;
  String get teamWhite;
  String get teamBlack;
  StartingEnds get startingEnds;
  String? get tournamentId;
  String? get fieldId;

  List<MatchPlayer> roster(TeamColor team);
  List<String> staff(TeamColor team);
  String? get chiefReferee;
  List<String> get waterReferees;
  List<String> get timekeepers;

  MatchPhase get phase;

  /// Server-tijd waarop deze toestand geldt.
  int get asOfMillis;

  /// Hoogste `seq` die verwerkt is; 0 als er nog geen events zijn.
  int get lastSeq;

  /// Het spel is bezig (tussen `PlayStarted` en de volgende onderbreking).
  bool get playRunning;

  /// De wedstrijdklok loopt. Dat kan ook tijdens een onderbreking: de klok
  /// loopt standaard door (15.3.3).
  bool get running;
  Duration get elapsedInPhase;

  /// Resterende periodetijd; `null` buiten een speelfase en in sudden death.
  Duration? get remainingInPhase;

  /// De klok staat op 0; de tafel bevestigt met `PeriodEnded`.
  bool get periodExpired;

  /// Binnen het stilgezette-klokvenster (14.2.3.1) of in sudden death.
  bool get stoppedClockMode;

  /// Wit speelt in de huidige (of eerstvolgende) speelfase aan de linkerkant.
  bool get whiteOnLeft;

  MatchScore get score;
  List<GoalRecord> get goals;
  List<PenaltyRecord> get penalties;
  List<CautionRecord> get cautions;

  /// Uitgesloten teamofficials (17.4.3).
  List<({TeamColor team, String name})> get dismissedOfficials;

  /// Aantal gebruikte team time-outs van [team] in helft [half] (1 of 2).
  int timeOutsUsed(TeamColor team, int half);

  /// Team dat nog een toegekende strafworp moet spelen.
  TeamColor? get pendingPenaltyShot;
  List<PenaltyShotRecord> get penaltyShots;
  ActiveTimeOut? get activeTimeOut;

  /// Start van de lopende pauzefase.
  int? get breakStartedAtMillis;

  /// Tijdstip van de laatste goal zolang het spel daarna niet herstart is
  /// (basis voor de 30 s-aftelling, 15.1.6).
  int? get lastGoalAtMillis;

  /// Tijdstip van het laatste 30 s-signaal vóór een periode (15.1.5).
  int? get periodWarningAtMillis;

  List<ProtestRecord> get protests;

  /// Reden per geldig `PlayStopped`-event (aangevuld door
  /// `StopReasonSpecified`).
  Map<String, StopReason> get stopReasons;

  /// `null` zolang de wedstrijd niet `finalized` is.
  MatchOutcomeKind? get outcomeKind;
  TeamColor? get forfeitedBy;
  bool get delegateDecided;
  String? get delegateText;
  MatchScore? get resultOverride;

  /// Gelijkspel terwijl een winnaar vereist is en er geen overtime of sudden
  /// death meer volgt: afsluiten kan pas na `ResultDecidedByDelegate`
  /// (OPEN-10).
  bool get needsDelegateDecision;

  /// Winnaar zodra de wedstrijd voorbij is; `null` bij gelijkspel of zolang
  /// er nog gespeeld wordt.
  TeamColor? get winner;

  /// Ids van events die met `EventVoided` ongeldig gemaakt zijn.
  Set<String> get voidedEventIds;

  /// Events uit het log die de engine geweigerd en dus overgeslagen heeft.
  Map<String, MatchRejection> get rejectedEvents;
}
