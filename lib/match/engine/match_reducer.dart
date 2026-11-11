import 'dart:math' as math;

import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_roster.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';
import 'package:hs_coaching_core/team/team_model.dart';

/// Leidt de toestand van één wedstrijd af uit haar event log
/// (02-match-engine.md §1). Deterministisch: dezelfde events geven dezelfde
/// toestand, op elk toestel.
///
/// - De events worden op `seq` gesorteerd.
/// - Een event dat met `EventVoided` ongeldig gemaakt is, wordt overgeslagen.
/// - Een event dat de regels schendt (bv. een tweede time-out in dezelfde
///   helft) wordt overgeslagen en komt in `MatchState.rejectedEvents`.
///
/// Alle events moeten van dezelfde wedstrijd zijn; gebruik [reduceMatches]
/// voor een gemengde lijst.
MatchState reduceMatch(Iterable<MatchEvent> events) {
  final sorted = events.toList()..sort((a, b) => a.seq.compareTo(b.seq));
  final machine = _Machine();

  // Eerst bepalen welke events ongeldig gemaakt zijn: een EventVoided werkt
  // terug op een eerder event, dus dat moet bekend zijn vóór het afspelen.
  final bySeq = <String, MatchEvent>{};
  for (final event in sorted) {
    final data = event.data;
    if (data is EventVoided) {
      final problem = _voidProblem(
        target: bySeq[data.targetId],
        voided: machine.voidedEventIds,
      );
      if (problem == null) {
        machine.voidedEventIds.add(data.targetId);
      } else {
        machine.rejectedEvents[event.id] = VoidNotAllowed(problem);
      }
    }
    bySeq[event.id] = event;
  }

  for (final event in sorted) {
    machine.register(event);
    if (event.data is EventVoided) continue;
    if (machine.voidedEventIds.contains(event.id)) continue;
    machine.apply(event);
  }
  return machine;
}

/// Reduceert een gemengde lijst events per `matchId`. Wedstrijden beïnvloeden
/// elkaar nooit: er is geen globale "actieve wedstrijd" (02 §6b).
Map<String, MatchState> reduceMatches(Iterable<MatchEvent> events) {
  final perMatch = <String, List<MatchEvent>>{};
  for (final event in events) {
    perMatch.putIfAbsent(event.matchId, () => []).add(event);
  }
  return perMatch.map((id, list) => MapEntry(id, reduceMatch(list)));
}

/// De toestand van [state] op [nowServerMs], zonder nieuwe events: alle
/// klokken lopen door volgens de klokregels. Basis voor `clockViewAt`.
///
/// Een tijdstip vóór `state.asOfMillis` geeft de toestand ongewijzigd terug.
MatchState advanceMatchState(MatchState state, int nowServerMs) {
  return _Machine.copyOf(state as _Machine)..advanceTo(nowServerMs);
}

/// Controleert of [candidate] toegelaten is in [state], op het tijdstip van
/// het event. Geeft de reden van weigering terug, of `null` als het mag.
///
/// De UI roept dit aan vóór ze een event schrijft (en om knoppen grijs te
/// zetten). De reducer gebruikt dezelfde regels bij het afspelen.
MatchRejection? validateEvent(MatchState state, MatchEvent candidate) {
  final machine = _Machine.copyOf(state as _Machine);
  final data = candidate.data;
  if (data is EventVoided) {
    if (!machine.created) {
      return const EventNotAllowed(GeneralProblem.matchNotCreated);
    }
    final problem = machine.voidProblemFor(data.targetId);
    return problem == null ? null : VoidNotAllowed(problem);
  }
  return machine.rejectionFor(candidate);
}

VoidProblem? _voidProblem({
  required MatchEvent? target,
  required Set<String> voided,
}) {
  if (target == null) return VoidProblem.unknownTarget;
  if (target.data is MatchCreated) return VoidProblem.matchCreated;
  if (target.data is EventVoided) return VoidProblem.voidEvent;
  if (voided.contains(target.id)) return VoidProblem.alreadyVoided;
  return null;
}

enum _EventKind { created, voidEvent, other }

class _Penalty {
  _Penalty({
    required this.eventId,
    required this.team,
    required this.cap,
    required this.minutes,
    required this.infringementCode,
    required this.deliberate,
  });

  final String eventId;
  final TeamColor team;
  final int cap;
  final int? minutes;
  final String infringementCode;
  final bool deliberate;

  int servedMillis = 0;

  /// Het spel is herstart sinds de straf gegeven werd.
  bool started = false;
  bool completed = false;

  /// Afgelopen terwijl het spel stillag; wacht op `PenaltyPlayerReturned`.
  bool awaitingReturn = false;

  bool get isDismissal => minutes == null;
  int get lengthMillis => Duration(minutes: minutes ?? 0).inMilliseconds;
  bool get isTicking => !isDismissal && started && !completed;

  _Penalty copy() =>
      _Penalty(
          eventId: eventId,
          team: team,
          cap: cap,
          minutes: minutes,
          infringementCode: infringementCode,
          deliberate: deliberate,
        )
        ..servedMillis = servedMillis
        ..started = started
        ..completed = completed
        ..awaitingReturn = awaitingReturn;
}

/// De toestandsmachine achter [MatchState]. Privé: buiten dit bestand is er
/// alleen de alleen-lezen interface.
class _Machine implements MatchState {
  _Machine();

  _Machine.copyOf(_Machine other)
    : created = other.created,
      matchId = other.matchId,
      config = other.config,
      teamWhite = other.teamWhite,
      teamBlack = other.teamBlack,
      startingEnds = other.startingEnds,
      tournamentId = other.tournamentId,
      fieldId = other.fieldId,
      chiefReferee = other.chiefReferee,
      waterReferees = other.waterReferees,
      timekeepers = other.timekeepers,
      phase = other.phase,
      asOfMillis = other.asOfMillis,
      lastSeq = other.lastSeq,
      playRunning = other.playRunning,
      _elapsedMillis = other._elapsedMillis,
      _goalInInterruption = other._goalInInterruption,
      _ruleStoppedMillis = other._ruleStoppedMillis,
      _penaltyShotHold = other._penaltyShotHold,
      score = other.score,
      pendingPenaltyShot = other.pendingPenaltyShot,
      activeTimeOut = other.activeTimeOut,
      breakStartedAtMillis = other.breakStartedAtMillis,
      lastGoalAtMillis = other.lastGoalAtMillis,
      periodWarningAtMillis = other.periodWarningAtMillis,
      outcomeKind = other.outcomeKind,
      forfeitedBy = other.forfeitedBy,
      delegateDecided = other.delegateDecided,
      _delegateWinner = other._delegateWinner,
      delegateText = other.delegateText,
      resultOverride = other.resultOverride {
    _rosters.addAll(other._rosters);
    _staff.addAll(other._staff);
    goals.addAll(other.goals);
    _penalties.addAll(other._penalties.map((penalty) => penalty.copy()));
    cautions.addAll(other.cautions);
    dismissedOfficials.addAll(other.dismissedOfficials);
    _timeOutsUsed.addAll(other._timeOutsUsed);
    penaltyShots.addAll(other.penaltyShots);
    protests.addAll(other.protests);
    stopReasons.addAll(other.stopReasons);
    voidedEventIds.addAll(other.voidedEventIds);
    rejectedEvents.addAll(other.rejectedEvents);
    _eventKinds.addAll(other._eventKinds);
  }

  // ------------------------------------------------------------------ velden

  @override
  bool created = false;
  @override
  String? matchId;
  @override
  MatchConfig? config;
  @override
  String teamWhite = '';
  @override
  String teamBlack = '';
  @override
  StartingEnds startingEnds = StartingEnds.whiteLeft;
  @override
  String? tournamentId;
  @override
  String? fieldId;
  @override
  String? chiefReferee;
  @override
  List<String> waterReferees = const [];
  @override
  List<String> timekeepers = const [];

  final Map<TeamColor, List<MatchPlayer>> _rosters = {};
  final Map<TeamColor, List<String>> _staff = {};

  @override
  MatchPhase phase = MatchPhase.notStarted;
  @override
  int asOfMillis = 0;
  @override
  int lastSeq = 0;
  @override
  bool playRunning = false;

  /// Verstreken wedstrijdtijd in de huidige speelfase.
  int _elapsedMillis = 0;

  /// In de lopende onderbreking viel een goal (veld- of strafgoal): de klok
  /// loopt dan door, ook binnen het stilgezette-klokvenster (14.2.3.1).
  bool _goalInInterruption = false;

  /// Hoelang de klok in de lopende onderbreking stilstond door de
  /// stilgezette-klokregel. Valt er alsnog een goal, dan wordt die tijd
  /// ingehaald: de klok rekent alsof ze nooit gestopt was (02 §5.2).
  int _ruleStoppedMillis = 0;

  /// Alle klokken staan stil wegens een strafworp, tot het startsignaal erna
  /// (17.8.7).
  bool _penaltyShotHold = false;

  @override
  MatchScore score = const MatchScore();
  @override
  final List<GoalRecord> goals = [];
  final List<_Penalty> _penalties = [];
  @override
  final List<CautionRecord> cautions = [];
  @override
  final List<({TeamColor team, String name})> dismissedOfficials = [];

  /// Sleutel: (team, helft).
  final Map<(TeamColor, int), int> _timeOutsUsed = {};

  @override
  TeamColor? pendingPenaltyShot;
  @override
  final List<PenaltyShotRecord> penaltyShots = [];
  @override
  ActiveTimeOut? activeTimeOut;
  @override
  int? breakStartedAtMillis;
  @override
  int? lastGoalAtMillis;
  @override
  int? periodWarningAtMillis;
  @override
  final List<ProtestRecord> protests = [];
  @override
  final Map<String, StopReason> stopReasons = {};

  @override
  MatchOutcomeKind? outcomeKind;
  @override
  TeamColor? forfeitedBy;
  @override
  bool delegateDecided = false;
  TeamColor? _delegateWinner;
  @override
  String? delegateText;
  @override
  MatchScore? resultOverride;

  @override
  final Set<String> voidedEventIds = {};
  @override
  final Map<String, MatchRejection> rejectedEvents = {};

  /// Elk event-id uit het log met zijn soort, voor de validatie van
  /// `EventVoided`.
  final Map<String, _EventKind> _eventKinds = {};

  // --------------------------------------------------------------- afgeleid

  MatchConfig get _config => config!;

  int? get _playLengthMillis => _config.playLength(phase)?.inMilliseconds;

  /// Een time-out of strafworp houdt de wedstrijdklok tegen.
  bool get _hold => activeTimeOut != null || _penaltyShotHold;

  @override
  List<MatchPlayer> roster(TeamColor team) =>
      List.unmodifiable(_rosters[team] ?? const <MatchPlayer>[]);

  @override
  List<String> staff(TeamColor team) =>
      List.unmodifiable(_staff[team] ?? const <String>[]);

  @override
  Duration get elapsedInPhase => Duration(milliseconds: _elapsedMillis);

  @override
  Duration? get remainingInPhase {
    final length = created ? _playLengthMillis : null;
    if (length == null) return null;
    return Duration(milliseconds: math.max(0, length - _elapsedMillis));
  }

  @override
  bool get periodExpired {
    final length = created ? _playLengthMillis : null;
    return length != null && _elapsedMillis >= length;
  }

  @override
  bool get stoppedClockMode {
    if (!created || !phase.isPlay) return false;
    if (phase == MatchPhase.suddenDeath) return true;
    if (!_config.stoppedClockPhases.contains(phase)) return false;
    final remaining = _playLengthMillis! - _elapsedMillis;
    return remaining <= _config.stoppedClockWindow.inMilliseconds;
  }

  @override
  bool get running {
    if (!created || !phase.isPlay || _hold || periodExpired) return false;
    if (playRunning || _goalInInterruption) return true;
    // Onderbreking zonder goal: de klok loopt door, behalve in
    // stilgezette-klokmodus.
    return !stoppedClockMode;
  }

  bool get _penaltyClocksRunning {
    if (!created || phase.isOver) return false;
    return switch (_config.penaltyClockPolicy) {
      PenaltyClockPolicy.matchClockOnly => running,
      PenaltyClockPolicy.wallClock => !_penaltyShotHold,
    };
  }

  @override
  bool get whiteOnLeft {
    final startsLeft = startingEnds == StartingEnds.whiteLeft;
    // Fase waarvan de kant geldt: de huidige speelfase, of de eerstvolgende.
    final playPhase = phase.isPlay ? phase : phase.nextPlayPhase;
    return switch (playPhase) {
      // Overtime 1 start aan dezelfde kant als de wedstrijd (14.2.4).
      MatchPhase.p1 || MatchPhase.ot1 || null => startsLeft,
      MatchPhase.p2 || MatchPhase.ot2 => !startsLeft,
      // Vóór sudden death wordt niet van kant gewisseld (14.2.5): na
      // overtime 2 of, zonder overtime, na periode 2.
      _ => !startsLeft,
    };
  }

  @override
  List<PenaltyRecord> get penalties {
    final ticking = _penaltyClocksRunning;
    return List.unmodifiable([
      for (final penalty in _penalties)
        PenaltyRecord(
          eventId: penalty.eventId,
          team: penalty.team,
          cap: penalty.cap,
          minutes: penalty.minutes,
          infringementCode: penalty.infringementCode,
          deliberate: penalty.deliberate,
          status: _statusOf(penalty, ticking: ticking),
          remaining: Duration(
            milliseconds: penalty.lengthMillis - penalty.servedMillis,
          ),
        ),
    ]);
  }

  PenaltyStatus _statusOf(_Penalty penalty, {required bool ticking}) {
    if (penalty.isDismissal) return PenaltyStatus.dismissal;
    if (!penalty.started) return PenaltyStatus.pending;
    if (penalty.completed) {
      return penalty.awaitingReturn
          ? PenaltyStatus.expiredWaiting
          : PenaltyStatus.served;
    }
    return ticking ? PenaltyStatus.running : PenaltyStatus.paused;
  }

  @override
  int timeOutsUsed(TeamColor team, int half) =>
      _timeOutsUsed[(team, half)] ?? 0;

  @override
  bool get needsDelegateDecision =>
      created &&
      phase == MatchPhase.awaitingSignOff &&
      _config.requiresWinner &&
      score.isTied &&
      !delegateDecided;

  @override
  TeamColor? get winner {
    if (!created || !phase.isOver) return null;
    final forfeiter = forfeitedBy;
    if (forfeiter != null) return opponentOf(forfeiter);
    if (delegateDecided) return _delegateWinner;
    return (resultOverride ?? score).leader;
  }

  bool _isDismissed(TeamColor team, int cap) => _penalties.any(
    (penalty) =>
        penalty.isDismissal && penalty.team == team && penalty.cap == cap,
  );

  bool _inPenaltyBox(TeamColor team, int cap) => _penalties.any(
    (penalty) =>
        !penalty.isDismissal &&
        penalty.team == team &&
        penalty.cap == cap &&
        (!penalty.completed || penalty.awaitingReturn),
  );

  static bool _capInRange(int cap) =>
      cap >= minCapNumber && cap <= maxCapNumber;

  // -------------------------------------------------------------------- tijd

  /// Laat alle klokken doorlopen tot [nowMillis] volgens de klokregels
  /// (02 §5). Zonder events ertussen verandert er niets aan wie speelt of
  /// welke time-out loopt; alleen de klokken schuiven op.
  void advanceTo(int nowMillis) {
    if (nowMillis <= asOfMillis) return;
    var delta = nowMillis - asOfMillis;
    asOfMillis = nowMillis;
    if (!created || phase.isOver) return;

    if (_config.penaltyClockPolicy == PenaltyClockPolicy.wallClock &&
        !_penaltyShotHold) {
      _advancePenalties(delta);
    }
    if (!phase.isPlay || _hold) return;

    if (playRunning || _goalInInterruption) {
      _tick(delta);
      return;
    }

    // Onderbreking zonder goal.
    if (phase == MatchPhase.suddenDeath) {
      _ruleStoppedMillis += delta;
      return;
    }
    if (!_config.stoppedClockPhases.contains(phase)) {
      _tick(delta);
      return;
    }
    // 14.2.3.2: de klok loopt door tot ze het venster bereikt en staat daar
    // dan stil. Een afgeleide stop: er wordt geen event voor geschreven.
    final untilWindow =
        _playLengthMillis! -
        _config.stoppedClockWindow.inMilliseconds -
        _elapsedMillis;
    if (untilWindow > 0) {
      final run = math.min(delta, untilWindow);
      _tick(run);
      delta -= run;
    }
    _ruleStoppedMillis += delta;
  }

  /// Laat de wedstrijdklok [millis] lopen, hooguit tot het einde van de fase.
  void _tick(int millis) {
    var run = millis;
    final length = _playLengthMillis;
    if (length != null) run = math.min(run, length - _elapsedMillis);
    if (run <= 0) return;
    _elapsedMillis += run;
    if (_config.penaltyClockPolicy == PenaltyClockPolicy.matchClockOnly) {
      _advancePenalties(run);
    }
  }

  void _advancePenalties(int millis) {
    for (final penalty in _penalties) {
      if (!penalty.isTicking) continue;
      penalty.servedMillis += millis;
      if (penalty.servedMillis >= penalty.lengthMillis) {
        penalty.servedMillis = penalty.lengthMillis;
        penalty.completed = true;
        // 17.3.1.2.3: loopt de straf af terwijl het spel stilligt, dan wacht
        // de speler op vrijgave.
        penalty.awaitingReturn = !playRunning;
      }
    }
  }

  void _resetInterruption() {
    _goalInInterruption = false;
    _ruleStoppedMillis = 0;
  }

  // ------------------------------------------------------------------ events

  void register(MatchEvent event) {
    _eventKinds[event.id] = switch (event.data) {
      MatchCreated() => _EventKind.created,
      EventVoided() => _EventKind.voidEvent,
      _ => _EventKind.other,
    };
    lastSeq = math.max(lastSeq, event.seq);
  }

  VoidProblem? voidProblemFor(String targetId) {
    return switch (_eventKinds[targetId]) {
      null => VoidProblem.unknownTarget,
      _EventKind.created => VoidProblem.matchCreated,
      _EventKind.voidEvent => VoidProblem.voidEvent,
      _EventKind.other =>
        voidedEventIds.contains(targetId) ? VoidProblem.alreadyVoided : null,
    };
  }

  void apply(MatchEvent event) {
    final rejection = rejectionFor(event);
    if (rejection != null) {
      rejectedEvents[event.id] = rejection;
      return;
    }
    _apply(event);
  }

  /// Schuift de klokken op tot het tijdstip van [event] en zegt of het event
  /// dan toegelaten is.
  MatchRejection? rejectionFor(MatchEvent event) {
    advanceTo(event.serverTimeMillis);
    final data = event.data;
    if (data is MatchCreated) {
      return created
          ? const EventNotAllowed(GeneralProblem.matchAlreadyCreated)
          : null;
    }
    if (!created) return const EventNotAllowed(GeneralProblem.matchNotCreated);
    if (phase == MatchPhase.finalized) {
      return const EventNotAllowed(GeneralProblem.matchFinal);
    }
    const wrongPhase = EventNotAllowed(GeneralProblem.wrongPhase);

    switch (data) {
      case MatchCreated() || EventVoided():
        return null;
      case RosterDeclared(:final players, :final staff):
        final problem = rosterProblem(players, staff);
        return problem == null ? null : RosterInvalid(problem);
      case OfficialsAssigned() || ProtestLogged() || OfficialDismissed():
        return null;
      case PeriodWarningGiven(phase: final next):
        return phase.nextPlayPhase == next ? null : wrongPhase;
      case PlayStarted():
        if (phase.isPlay) {
          if (playRunning) {
            return const PlayNotAllowed(PlayProblem.alreadyRunning);
          }
          // Een openstaande strafworp wordt ook na het verstrijken van de
          // tijd nog gespeeld (17.8.6).
          if (periodExpired && pendingPenaltyShot == null) {
            return const PlayNotAllowed(PlayProblem.periodExpired);
          }
          return null;
        }
        return phase.nextPlayPhase == null ? wrongPhase : null;
      case PlayStopped():
        if (!phase.isPlay) return wrongPhase;
        return playRunning
            ? null
            : const PlayNotAllowed(PlayProblem.notRunning);
      case StopReasonSpecified(:final targetId):
        return stopReasons.containsKey(targetId)
            ? null
            : const StopReasonNotAllowed(StopReasonProblem.unknownTarget);
      case OfficialsTimeOutStarted():
        return phase.isPlay ? null : wrongPhase;
      case TeamTimeOutRequested(:final team):
        final half = phase.half;
        if (half == null) {
          return const TimeOutNotAllowed(TimeOutProblem.notInRegularPeriod);
        }
        if (playRunning) {
          return const TimeOutNotAllowed(TimeOutProblem.playRunning);
        }
        if (pendingPenaltyShot != null) {
          return const TimeOutNotAllowed(TimeOutProblem.penaltyShotPending);
        }
        if (timeOutsUsed(team, half) >= _config.timeOutsPerTeamPerHalf) {
          return const TimeOutNotAllowed(TimeOutProblem.alreadyUsedThisHalf);
        }
        return null;
      case PeriodEnded(phase: final ended):
        if (!phase.isTimedPlay || ended != phase) {
          return const PeriodEndNotAllowed(PeriodEndProblem.wrongPhase);
        }
        if (pendingPenaltyShot != null) {
          return const PeriodEndNotAllowed(PeriodEndProblem.penaltyShotPending);
        }
        return periodExpired
            ? null
            : const PeriodEndNotAllowed(PeriodEndProblem.clockNotExpired);
      case GoalScored(:final team, :final scorerCap, :final kind):
        if (!phase.isPlay) return wrongPhase;
        if (scorerCap != null) {
          final problem = _playerProblem(team, scorerCap);
          if (problem != null) return problem;
        }
        if (kind == GoalKind.penaltyShot && pendingPenaltyShot != team) {
          return const PenaltyShotNotAllowed(PenaltyShotProblem.noShotPending);
        }
        return null;
      case CautionGiven(:final team, :final cap):
        return cap == null ? null : _playerProblem(team, cap);
      case TimePenaltyGiven(:final team, :final cap, :final minutes):
        if (phase == MatchPhase.awaitingSignOff || minutes <= 0) {
          return wrongPhase;
        }
        return _playerProblem(team, cap);
      case PlayerDismissed(:final team, :final cap):
        return _playerProblem(team, cap);
      case PenaltyShotAwarded():
        if (!phase.isPlay) return wrongPhase;
        return pendingPenaltyShot == null
            ? null
            : const PenaltyShotNotAllowed(PenaltyShotProblem.alreadyPending);
      case PenaltyShotResolved(:final attackers, :final defender):
        final awardedTo = pendingPenaltyShot;
        if (awardedTo == null) {
          return const PenaltyShotNotAllowed(PenaltyShotProblem.noShotPending);
        }
        final participants = [
          for (final cap in attackers) (awardedTo, cap),
          if (defender != null) (opponentOf(awardedTo), defender),
        ];
        for (final (team, cap) in participants) {
          if (!_capInRange(cap)) {
            return const EventNotAllowed(GeneralProblem.capOutOfRange);
          }
          // 17.8.2.3.
          if (_isDismissed(team, cap)) {
            return const PenaltyShotNotAllowed(
              PenaltyShotProblem.playerDismissed,
            );
          }
          if (_inPenaltyBox(team, cap)) {
            return const PenaltyShotNotAllowed(
              PenaltyShotProblem.playerInPenaltyBox,
            );
          }
        }
        return null;
      case PenaltyPlayerReturned(:final team, :final cap):
        return _penaltyAwaitingReturn(team, cap) == null
            ? const PenaltyReturnNotAllowed(
                PenaltyReturnProblem.noExpiredPenalty,
              )
            : null;
      case MatchEndedBySignOff():
        if (phase != MatchPhase.awaitingSignOff) return wrongPhase;
        return needsDelegateDecision
            ? const SignOffNotAllowed(SignOffProblem.winnerRequired)
            : null;
      case ResultDecidedByDelegate():
        return phase == MatchPhase.awaitingSignOff ? null : wrongPhase;
      case MatchForfeited() || MatchAbandoned():
        return null;
    }
  }

  MatchRejection? _playerProblem(TeamColor team, int cap) {
    if (!_capInRange(cap)) {
      return const EventNotAllowed(GeneralProblem.capOutOfRange);
    }
    if (_isDismissed(team, cap)) {
      return const EventNotAllowed(GeneralProblem.playerDismissed);
    }
    return null;
  }

  _Penalty? _penaltyAwaitingReturn(TeamColor team, int cap) {
    for (final penalty in _penalties) {
      if (penalty.team == team &&
          penalty.cap == cap &&
          penalty.awaitingReturn) {
        return penalty;
      }
    }
    return null;
  }

  void _apply(MatchEvent event) {
    final now = event.serverTimeMillis;
    switch (event.data) {
      case MatchCreated data:
        created = true;
        matchId = event.matchId;
        config = data.config;
        teamWhite = data.teamWhite;
        teamBlack = data.teamBlack;
        startingEnds = data.startingEnds;
        tournamentId = data.tournamentId;
        fieldId = data.fieldId;
      case RosterDeclared(:final team, :final players, :final staff):
        _rosters[team] = players;
        _staff[team] = staff;
      case OfficialsAssigned(:final chief, :final water, :final timekeepers):
        chiefReferee = chief;
        waterReferees = List.unmodifiable(water);
        this.timekeepers = List.unmodifiable(timekeepers);
      case PeriodWarningGiven():
        periodWarningAtMillis = now;
      case PlayStarted():
        _startPlay();
      case PlayStopped(:final reason):
        playRunning = false;
        _resetInterruption();
        stopReasons[event.id] = reason;
      case StopReasonSpecified(:final targetId, :final reason):
        stopReasons[targetId] = reason;
      case OfficialsTimeOutStarted():
        if (playRunning) {
          playRunning = false;
          _resetInterruption();
        }
        activeTimeOut = ActiveTimeOut(
          kind: TimeOutKind.officials,
          team: null,
          startedAtMillis: now,
        );
      case TeamTimeOutRequested(:final team):
        final key = (team, phase.half!);
        _timeOutsUsed[key] = (_timeOutsUsed[key] ?? 0) + 1;
        var startsAt = now;
        final current = activeTimeOut;
        if (current != null && current.kind == TimeOutKind.team) {
          // 14.2.6.5: aaneengeschakeld, dus pas na de lopende time-out.
          final currentEnd =
              current.startedAtMillis +
              _config.teamTimeOutLength.inMilliseconds;
          startsAt = math.max(now, currentEnd);
        }
        activeTimeOut = ActiveTimeOut(
          kind: TimeOutKind.team,
          team: team,
          startedAtMillis: startsAt,
        );
      case PeriodEnded():
        _endPlayPhase(now);
      case GoalScored data:
        _scoreGoal(event.id, data, now);
      case CautionGiven data:
        cautions.add(
          CautionRecord(
            eventId: event.id,
            team: data.team,
            cap: data.cap,
            infringementCode: data.infringementCode,
            deliberate: data.deliberate,
            isTeamCaution: data.isTeamCaution,
          ),
        );
      case TimePenaltyGiven data:
        _penalties.add(
          _Penalty(
            eventId: event.id,
            team: data.team,
            cap: data.cap,
            minutes: data.minutes,
            infringementCode: data.infringementCode,
            deliberate: data.deliberate,
          ),
        );
      case PlayerDismissed data:
        _penalties.add(
          _Penalty(
            eventId: event.id,
            team: data.team,
            cap: data.cap,
            minutes: null,
            infringementCode: data.infringementCode,
            deliberate: true,
          ),
        );
      case OfficialDismissed(:final team, :final name):
        dismissedOfficials.add((team: team, name: name));
      case PenaltyShotAwarded(:final againstTeam):
        if (playRunning) {
          playRunning = false;
          _resetInterruption();
        }
        pendingPenaltyShot = opponentOf(againstTeam);
        _penaltyShotHold = true;
      case PenaltyShotResolved data:
        penaltyShots.add(
          PenaltyShotRecord(
            eventId: event.id,
            awardedTo: pendingPenaltyShot!,
            outcome: data.outcome,
            attackers: List.unmodifiable(data.attackers),
            defender: data.defender,
          ),
        );
        pendingPenaltyShot = null;
        playRunning = false;
      case PenaltyPlayerReturned(:final team, :final cap):
        _penaltyAwaitingReturn(team, cap)!.awaitingReturn = false;
      case ProtestLogged data:
        protests.add(
          ProtestRecord(
            eventId: event.id,
            team: data.team,
            by: data.by,
            text: data.text,
          ),
        );
      case EventVoided():
        break;
      case MatchEndedBySignOff():
        _finalize(MatchOutcomeKind.played);
      case ResultDecidedByDelegate(:final winner, :final text):
        delegateDecided = true;
        _delegateWinner = winner;
        delegateText = text;
      case MatchForfeited(:final team):
        forfeitedBy = team;
        _finalize(MatchOutcomeKind.forfeited);
      case MatchAbandoned data:
        resultOverride = data.resultOverride;
        _finalize(MatchOutcomeKind.abandoned);
    }
  }

  void _startPlay() {
    if (!phase.isPlay) {
      phase = phase.nextPlayPhase!;
      _elapsedMillis = 0;
      breakStartedAtMillis = null;
    }
    playRunning = true;
    periodWarningAtMillis = null;
    // Zolang de strafworp niet afgesloten is, is dit het startsignaal van de
    // strafworp zelf: de klokken blijven stil (17.8.7).
    if (pendingPenaltyShot != null) return;

    activeTimeOut = null;
    _penaltyShotHold = false;
    lastGoalAtMillis = null;
    _resetInterruption();
    // 17.3.1.1.1: de straftijd start pas bij de herstart.
    for (final penalty in _penalties) {
      if (!penalty.isDismissal) penalty.started = true;
    }
  }

  void _scoreGoal(String eventId, GoalScored data, int now) {
    score = data.team == TeamColor.white
        ? score.copyWith(white: score.white + 1)
        : score.copyWith(black: score.black + 1);
    goals.add(
      GoalRecord(
        eventId: eventId,
        team: data.team,
        scorerCap: data.scorerCap,
        kind: data.kind,
        phase: phase,
        elapsedInPhase: elapsedInPhase,
        serverTimeMillis: now,
      ),
    );

    // Een goal uit een strafworp verandert niets aan de klokken: die staan
    // stil tot het startsignaal na de strafworp (17.8.7).
    if (data.kind != GoalKind.penaltyShot) {
      if (playRunning) {
        playRunning = false;
      } else {
        // 02 §5.2: stond de klok in deze onderbreking stil door de
        // stilgezette-klokregel, dan loopt ze achteraf toch mee.
        _tick(_ruleStoppedMillis);
      }
      _ruleStoppedMillis = 0;
      _goalInInterruption = true;
      // 14.2.3: levert het overleg een goal op, dan herstart de klok bij de
      // aankondiging.
      if (activeTimeOut?.kind == TimeOutKind.officials) activeTimeOut = null;
      lastGoalAtMillis = now;
    }

    // De eerste goal in sudden death beëindigt de wedstrijd.
    if (phase == MatchPhase.suddenDeath) {
      phase = MatchPhase.awaitingSignOff;
      _stopEverything();
    }
  }

  void _endPlayPhase(int now) {
    final tiedAndWinnerNeeded = _config.requiresWinner && score.isTied;
    final afterOvertime = tiedAndWinnerNeeded && _config.suddenDeathEnabled
        ? MatchPhase.sdBreak
        : MatchPhase.awaitingSignOff;
    phase = switch (phase) {
      MatchPhase.p1 => MatchPhase.halfTime,
      MatchPhase.p2 =>
        tiedAndWinnerNeeded && _config.overtimePeriods > 0
            ? MatchPhase.otBreak
            : afterOvertime,
      // Overtime wordt volledig uitgespeeld, ook als iemand voorstaat.
      MatchPhase.ot1 =>
        _config.overtimePeriods > 1 ? MatchPhase.otInterval : afterOvertime,
      _ => afterOvertime,
    };
    _stopEverything();
    breakStartedAtMillis = phase.isBreak ? now : null;
  }

  void _stopEverything() {
    playRunning = false;
    activeTimeOut = null;
    _penaltyShotHold = false;
    lastGoalAtMillis = null;
    periodWarningAtMillis = null;
    _resetInterruption();
  }

  void _finalize(MatchOutcomeKind kind) {
    outcomeKind = kind;
    phase = MatchPhase.finalized;
    _stopEverything();
    breakStartedAtMillis = null;
  }
}
