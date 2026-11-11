import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';

import 'match_script.dart';

void main() {
  group('doorlopende klok', () {
    test('15.3.3 T1: de klok loopt door tijdens een onderbreking in P1', () {
      final match = MatchScript()..start();
      match.playUntilRemaining(mmss(10, 0));
      match.stop();
      expect(match.clock.running, isTrue);
      match.wait(const Duration(seconds: 20));
      match.start();
      expect(match.remaining, mmss(9, 40));
    });

    test('14.2.3.1 OPEN-1: de laatste 2 minuten van P1 staan niet stil', () {
      final match = MatchScript()..start();
      match.playUntilRemaining(mmss(1, 30));
      match.stop();
      match.wait(const Duration(seconds: 10));
      expect(match.clock.stoppedClockMode, isFalse);
      expect(match.remaining, mmss(1, 20));
    });

    test('14.2.3.1 OPEN-1: het venster is instelbaar per fase', () {
      final match = MatchScript(
        config: const MatchConfig(
          stoppedClockPhases: {MatchPhase.p1, MatchPhase.p2},
        ),
      )..start();
      match.playUntilRemaining(mmss(1, 30));
      match.stop();
      match.wait(const Duration(seconds: 10));
      expect(match.clock.stoppedClockMode, isTrue);
      expect(match.remaining, mmss(1, 30));
    });

    test('15.3.3 de klok stopt op 0:00 en de tafel bevestigt het einde', () {
      final match = MatchScript()..start();
      match.playUntilRemaining(mmss(0, 5));
      expect(
        match.check(const MatchEventData.periodEnded(phase: MatchPhase.p1)),
        const PeriodEndNotAllowed(PeriodEndProblem.clockNotExpired),
      );
      match.wait(const Duration(seconds: 20));
      expect(match.remaining, Duration.zero);
      expect(match.clock.periodExpired, isTrue);
      expect(match.clock.running, isFalse);
      match.stop();
      expect(
        match.check(const MatchEventData.playStarted()),
        const PlayNotAllowed(PlayProblem.periodExpired),
      );
      match.endPeriod();
      expect(match.state.phase, MatchPhase.halfTime);
    });

    test('15.1.8 een stop via de afstandsbediening telt zoals op het scherm', () {
      final match = MatchScript()..start();
      match.playUntilRemaining(mmss(10, 0));
      final stop = match.add(
        const MatchEventData.playStopped(),
        source: EventSource.remote,
      );
      expect(match.state.playRunning, isFalse);
      expect(match.state.stopReasons[stop.id], StopReason.unspecified);
      // De tafel vult de reden achteraf aan; de klok hangt er niet van af.
      match.add(
        MatchEventData.stopReasonSpecified(
          targetId: stop.id,
          reason: StopReason.outOfBounds,
        ),
      );
      expect(match.state.stopReasons[stop.id], StopReason.outOfBounds);
      expect(
        match.check(const MatchEventData.playStopped()),
        const PlayNotAllowed(PlayProblem.notRunning),
      );
    });
  });

  group('stilgezette klok in de laatste 2 minuten', () {
    test('14.2.3.2 T2: automatische stop op 2:00', () {
      final match = MatchScript()..startSecondPeriod();
      match.playUntilRemaining(mmss(2, 10));
      match.stop();
      match.wait(const Duration(seconds: 30));
      expect(match.remaining, mmss(2, 0));
      expect(match.clock.running, isFalse);
      expect(match.clock.stoppedClockMode, isTrue);
      match.wait(const Duration(minutes: 1));
      expect(match.remaining, mmss(2, 0));
      // Herstart bij het volgende startsignaal.
      match.start();
      match.wait(const Duration(seconds: 10));
      expect(match.remaining, mmss(1, 50));
    });

    test('14.2.3.1 T3: stop op 1:30 zet de klok stil tot PlayStarted', () {
      final match = MatchScript()..startSecondPeriod();
      match.playUntilRemaining(mmss(1, 30));
      match.stop();
      match.wait(const Duration(seconds: 25));
      expect(match.remaining, mmss(1, 30));
      expect(match.clock.running, isFalse);
      match.start();
      expect(match.clock.running, isTrue);
      match.wait(const Duration(seconds: 5));
      expect(match.remaining, mmss(1, 25));
    });

    test('14.2.3.1 T4: na een goal op 1:30 loopt de klok door', () {
      final match = MatchScript()..startSecondPeriod();
      match.playUntilRemaining(mmss(1, 30));
      match.goal(white);
      expect(match.state.playRunning, isFalse);
      match.wait(const Duration(seconds: 10));
      expect(match.clock.running, isTrue);
      expect(match.remaining, mmss(1, 20));
    });

    test('14.2.3.1 T20: stop, 10 s later een goal: de klok liep die 10 s door', () {
      final match = MatchScript()..startSecondPeriod();
      match.playUntilRemaining(mmss(1, 30));
      match.add(const MatchEventData.playStopped(), source: EventSource.remote);
      match.wait(const Duration(seconds: 10));
      // Vóór het goal-event staat de klok nog stil...
      expect(match.remaining, mmss(1, 30));
      match.goal(black);
      // ...en erna springt ze vooruit.
      expect(match.remaining, mmss(1, 20));
      match.wait(const Duration(seconds: 5));
      match.start();
      expect(match.remaining, mmss(1, 15));
    });

    test('14.2.3.1 T21: stop zonder goal: de klok stond stil', () {
      final match = MatchScript()..startSecondPeriod();
      match.playUntilRemaining(mmss(1, 30));
      match.add(const MatchEventData.playStopped(), source: EventSource.remote);
      match.wait(const Duration(seconds: 10));
      match.start();
      expect(match.remaining, mmss(1, 30));
    });

    test('14.2.3.2 een goal na de automatische stop haalt de tijd in', () {
      final match = MatchScript()..startSecondPeriod();
      match.playUntilRemaining(mmss(2, 10));
      match.stop(StopReason.unspecified);
      match.wait(const Duration(seconds: 30));
      expect(match.remaining, mmss(2, 0));
      match.goal(white);
      expect(match.remaining, mmss(1, 40));
    });

    test('14.2.3.1 in sudden death staat de klok stil bij elke stop', () {
      final match = MatchScript(
        config: const MatchConfig(requiresWinner: true, overtimePeriods: 0),
      );
      match
        ..playFullPeriod()
        ..playFullPeriod();
      expect(match.state.phase, MatchPhase.sdBreak);
      match.start();
      match.wait(const Duration(seconds: 50));
      expect(match.clock.stoppedClockMode, isTrue);
      expect(match.remaining, isNull);
      match.stop();
      match.wait(const Duration(seconds: 30));
      expect(match.clock.periodElapsed, const Duration(seconds: 50));
    });
  });

  group('officials\' time-out', () {
    test('14.2.3 T16: bij een goal na overleg herstart de klok bij de '
        'aankondiging', () {
      final match = MatchScript()..start();
      match.playUntilRemaining(mmss(8, 0));
      match.add(const MatchEventData.officialsTimeOutStarted(reason: 'overleg'));
      match.wait(const Duration(seconds: 40));
      expect(match.remaining, mmss(8, 0));
      expect(match.clock.timeOut, isNotNull);
      // GoalScored en PlayStarted op hetzelfde tijdstip.
      match
        ..goal(white)
        ..start();
      expect(match.clock.timeOut, isNull);
      match.wait(const Duration(seconds: 15));
      expect(match.remaining, mmss(7, 45));
    });

    test('14.2.3 T16: de klok herstart ook als het startsignaal later volgt', () {
      final match = MatchScript()..start();
      match.playUntilRemaining(mmss(8, 0));
      match.add(const MatchEventData.officialsTimeOutStarted());
      match.wait(const Duration(seconds: 40));
      match.goal(white);
      match.wait(const Duration(seconds: 15));
      expect(match.remaining, mmss(7, 45));
    });

    test('14.2.3 zonder goal herstart de klok bij het startsignaal', () {
      final match = MatchScript()..start();
      match.playUntilRemaining(mmss(8, 0));
      match.add(const MatchEventData.officialsTimeOutStarted(reason: 'blessure'));
      expect(match.state.playRunning, isFalse);
      match.wait(const Duration(minutes: 4));
      match.start(RestartType.equalPuck);
      match.wait(const Duration(seconds: 10));
      expect(match.remaining, mmss(7, 50));
    });
  });

  group('T19: afwijkende config', () {
    const config = MatchConfig(
      periodLength: Duration(minutes: 10),
      halfTimeBreak: Duration(minutes: 2),
      overtimePeriods: 0,
      suddenDeathEnabled: false,
      stoppedClockWindow: Duration(minutes: 1),
      presetName: '2x10',
    );

    test('15.3.3 T19/T1: doorlopende klok met periodes van 10 minuten', () {
      final match = MatchScript(config: config)..start();
      expect(match.remaining, mmss(10, 0));
      match.playUntilRemaining(mmss(6, 0));
      match.stop();
      match.wait(const Duration(seconds: 20));
      match.start();
      expect(match.remaining, mmss(5, 40));
    });

    test('14.2.3.2 T19/T2: automatische stop op 1:00 in plaats van 2:00', () {
      final match = MatchScript(config: config)..startSecondPeriod();
      match.playUntilRemaining(mmss(1, 50));
      match.stop();
      match.wait(const Duration(seconds: 20));
      // Op 1:30 loopt de klok nog: het venster is hier 1:00.
      expect(match.remaining, mmss(1, 30));
      match.wait(const Duration(minutes: 1));
      expect(match.remaining, mmss(1, 0));
    });

    test('14.2.3.1 T19/T3+T4: stilstand en goal binnen het venster van 1:00', () {
      final match = MatchScript(config: config)..startSecondPeriod();
      match.playUntilRemaining(mmss(0, 40));
      match.stop();
      match.wait(const Duration(seconds: 15));
      expect(match.remaining, mmss(0, 40));
      match.start();
      match.goal(white);
      match.wait(const Duration(seconds: 10));
      expect(match.remaining, mmss(0, 30));
    });

    test('14.2.1.1 T19/T11: de rust duurt 2 minuten en gelijkspel volstaat', () {
      final match = MatchScript(config: config)..playFullPeriod();
      match.wait(const Duration(seconds: 30));
      expect(match.clock.breakRemaining, mmss(1, 30));
      match.playFullPeriod();
      expect(match.state.phase, MatchPhase.awaitingSignOff);
    });
  });

  group('aftellingen', () {
    test('15.1.5 het 30 s-signaal start een aftelling tot het startsignaal', () {
      final match = MatchScript();
      expect(
        match.check(const MatchEventData.periodWarningGiven(phase: MatchPhase.p2)),
        const EventNotAllowed(GeneralProblem.wrongPhase),
      );
      match.add(const MatchEventData.periodWarningGiven(phase: MatchPhase.p1));
      match.wait(const Duration(seconds: 12));
      expect(match.clock.periodStartCountdown, const Duration(seconds: 18));
      match.start();
      expect(match.clock.periodStartCountdown, isNull);
    });

    test('15.1.6 na een goal telt de herstart af vanaf 30 s', () {
      final match = MatchScript()..start();
      match.wait(const Duration(minutes: 1));
      match.goal(black, cap: 7);
      match.wait(const Duration(seconds: 12));
      expect(match.clock.goalRestartRemaining, const Duration(seconds: 18));
      match.start();
      expect(match.clock.goalRestartRemaining, isNull);
    });

    test('14.2.2 de rust telt af en de kanten wisselen', () {
      final match = MatchScript();
      expect(match.state.whiteOnLeft, isTrue);
      match.playFullPeriod();
      match.wait(const Duration(minutes: 1));
      expect(match.clock.breakRemaining, mmss(2, 0));
      expect(match.clock.periodRemaining, isNull);
      expect(match.state.whiteOnLeft, isFalse);
    });
  });
}
