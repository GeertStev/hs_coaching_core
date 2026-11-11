import 'dart:math' as math;

import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_reducer.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';
import 'package:hs_coaching_core/team/team_model.dart';

/// Aftelling van de lopende time-out.
class TimeOutClock {
  const TimeOutClock({
    required this.kind,
    required this.team,
    required this.elapsed,
    required this.remaining,
    required this.warningReached,
  });

  final TimeOutKind kind;
  final TeamColor? team;
  final Duration elapsed;

  /// Resterende tijd van een team time-out; `null` voor een officials'
  /// time-out (die heeft geen vaste duur). Op 0 herstart het spel niet
  /// vanzelf: dat doet het startsignaal van de hoofdscheidsrechter.
  final Duration? remaining;

  /// De hoorbare waarschuwing van een team time-out is bereikt (14.2.6).
  final bool warningReached;
}

/// Alles wat een scherm op één moment van de klokken moet tonen
/// (02-match-engine.md §1). Tafel, scorebord en spelersapp berekenen met
/// dezelfde events en dezelfde server-tijd exact dezelfde waarden.
class ClockView {
  const ClockView({
    required this.state,
    required this.nowServerMs,
    required this.breakRemaining,
    required this.timeOut,
    required this.goalRestartRemaining,
    required this.periodStartCountdown,
  });

  /// De toestand doorgerekend tot [nowServerMs].
  final MatchState state;
  final int nowServerMs;

  MatchPhase get phase => state.phase;

  /// Resterende periodetijd; `null` buiten een speelfase en in sudden death.
  Duration? get periodRemaining => state.remainingInPhase;

  /// Verstreken tijd in de speelfase (telt op in sudden death).
  Duration get periodElapsed => state.elapsedInPhase;
  bool get running => state.running;
  bool get playRunning => state.playRunning;
  bool get periodExpired => state.periodExpired;
  bool get stoppedClockMode => state.stoppedClockMode;

  /// Strafklokken met hun status en resterende tijd.
  List<PenaltyRecord> get penalties => state.penalties;

  /// Resterende tijd van de lopende pauzefase.
  final Duration? breakRemaining;
  final TimeOutClock? timeOut;

  /// Resterende tijd tot de uiterste herstart na een goal (15.1.6).
  final Duration? goalRestartRemaining;

  /// Aftelling na het 30 s-signaal vóór een periode (15.1.5).
  final Duration? periodStartCountdown;
}

/// Pure functie `(MatchState, nowServerMs) -> ClockView`.
///
/// [nowServerMs] is server-tijd: `serverNowMillis(offset)` uit
/// `core/providers/server_time_offset_provider.dart`. De engine vraagt zelf
/// nooit de tijd op.
ClockView clockViewAt(MatchState state, int nowServerMs) {
  final now = math.max(nowServerMs, state.asOfMillis);
  final advanced = advanceMatchState(state, now);
  final config = advanced.config;

  Duration left(Duration total, int sinceMillis) => Duration(
    milliseconds: math.max(0, total.inMilliseconds - (now - sinceMillis)),
  );

  Duration? breakRemaining;
  TimeOutClock? timeOut;
  Duration? goalRestartRemaining;
  Duration? periodStartCountdown;

  if (config != null) {
    final breakLength = config.breakLength(advanced.phase);
    final breakStart = advanced.breakStartedAtMillis;
    if (breakLength != null && breakStart != null) {
      breakRemaining = left(breakLength, breakStart);
    }

    final active = advanced.activeTimeOut;
    if (active != null) {
      final elapsed = Duration(
        milliseconds: math.max(0, now - active.startedAtMillis),
      );
      final isTeam = active.kind == TimeOutKind.team;
      timeOut = TimeOutClock(
        kind: active.kind,
        team: active.team,
        elapsed: elapsed,
        remaining: isTeam
            ? left(config.teamTimeOutLength, active.startedAtMillis)
            : null,
        warningReached: isTeam && elapsed >= config.timeOutWarningAt,
      );
    }

    final lastGoal = advanced.lastGoalAtMillis;
    if (lastGoal != null && advanced.phase.isPlay) {
      goalRestartRemaining = left(config.goalRestartMax, lastGoal);
    }

    final warning = advanced.periodWarningAtMillis;
    if (warning != null) {
      periodStartCountdown = left(config.periodStartWarning, warning);
    }
  }

  return ClockView(
    state: advanced,
    nowServerMs: now,
    breakRemaining: breakRemaining,
    timeOut: timeOut,
    goalRestartRemaining: goalRestartRemaining,
    periodStartCountdown: periodStartCountdown,
  );
}
