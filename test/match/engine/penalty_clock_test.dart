import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';

import 'match_script.dart';

void main() {
  test('17.3.1.1.1 T8: de strafklok start bij de herstart, niet bij het '
      'geven', () {
    final match = MatchScript()..start();
    match.playUntilRemaining(mmss(10, 0));
    match.stop();
    final penalty = match.penalty(black, 5, 2);
    match.wait(const Duration(seconds: 40));
    expect(match.penaltyOf(penalty).status, PenaltyStatus.pending);
    expect(match.penaltyOf(penalty).remaining, mmss(2, 0));
    match.start(RestartType.advantagePuck);
    match.wait(const Duration(seconds: 30));
    expect(match.penaltyOf(penalty).status, PenaltyStatus.running);
    expect(match.penaltyOf(penalty).remaining, mmss(1, 30));
  });

  test('17.8.6 T9: strafworp op 0:03: klokken staan stil, de strafworp wordt '
      'gespeeld, daarna eindigt de periode', () {
    final match = MatchScript()..start();
    match.playUntilRemaining(mmss(1, 0));
    match.stop();
    final penalty = match.penalty(white, 3, 2);
    match.start();
    match.playUntilRemaining(mmss(0, 3));
    final penaltyLeft = match.penaltyOf(penalty).remaining;
    expect(penaltyLeft, mmss(1, 3));

    match.add(const MatchEventData.penaltyShotAwarded(againstTeam: black));
    expect(match.state.pendingPenaltyShot, white);
    match.wait(const Duration(seconds: 10));
    expect(match.remaining, mmss(0, 3));
    expect(match.clock.running, isFalse);
    // 17.8.7: ook de strafklokken staan stil.
    expect(match.penaltyOf(penalty).remaining, penaltyLeft);
    expect(match.penaltyOf(penalty).status, PenaltyStatus.paused);
    expect(
      match.check(const MatchEventData.periodEnded(phase: MatchPhase.p1)),
      const PeriodEndNotAllowed(PeriodEndProblem.penaltyShotPending),
    );

    // Het startsignaal van de strafworp zelf zet de klokken niet in gang.
    match.start();
    match.wait(const Duration(seconds: 4));
    expect(match.remaining, mmss(0, 3));
    match
      ..goal(white, cap: 9, kind: GoalKind.penaltyShot)
      ..add(
        const MatchEventData.penaltyShotResolved(
          outcome: PenaltyShotOutcome.goal,
          attackers: [9, 4],
          defender: 2,
        ),
      );
    expect(match.state.pendingPenaltyShot, isNull);
    expect(match.remaining, mmss(0, 3));

    match.start(RestartType.afterPenaltyShot);
    match.wait(const Duration(seconds: 3));
    expect(match.clock.periodExpired, isTrue);
    match.endPeriod();
    expect(match.state.phase, MatchPhase.halfTime);
    expect(match.state.score.white, 1);
    expect(match.state.penaltyShots.single.outcome, PenaltyShotOutcome.goal);
  });

  test('17.3.1.2.3 T10: straf loopt af tijdens een stop: expiredWaiting', () {
    final match = MatchScript()..start();
    match.playUntilRemaining(mmss(10, 0));
    match.stop();
    final penalty = match.penalty(white, 8, 1);
    match.start();
    match.wait(const Duration(seconds: 50));
    match.stop();
    // In P1 loopt de klok door, dus de straf loopt af tijdens de stop.
    match.wait(const Duration(seconds: 15));
    expect(match.penaltyOf(penalty).status, PenaltyStatus.expiredWaiting);
    expect(match.penaltyOf(penalty).remaining, Duration.zero);
    expect(match.penaltyOf(penalty).inPenaltyBox, isTrue);

    // De speler blijft wachten tot de hoofdscheidsrechter hem vrijgeeft.
    match.start();
    expect(match.penaltyOf(penalty).status, PenaltyStatus.expiredWaiting);
    match.add(const MatchEventData.penaltyPlayerReturned(team: white, cap: 8));
    expect(match.penaltyOf(penalty).status, PenaltyStatus.served);
    expect(
      match.check(
        const MatchEventData.penaltyPlayerReturned(team: white, cap: 8),
      ),
      const PenaltyReturnNotAllowed(PenaltyReturnProblem.noExpiredPenalty),
    );
  });

  test('17.3.1.2 straf loopt af terwijl het spel loopt: meteen served', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    final penalty = match.penalty(white, 8, 1);
    match.start();
    match.wait(const Duration(seconds: 61));
    expect(match.penaltyOf(penalty).status, PenaltyStatus.served);
  });

  test(
    '17.3 OPEN-2: de straf pauzeert tijdens de rust en loopt daarna door',
    () {
      final match = MatchScript()..start();
      match.playUntilRemaining(mmss(1, 0));
      match.stop();
      final penalty = match.penalty(black, 6, 2);
      match.wait(const Duration(seconds: 30));
      match.start();
      match.wait(const Duration(seconds: 30));
      expect(match.clock.periodExpired, isTrue);
      expect(match.penaltyOf(penalty).remaining, mmss(1, 30));
      match.endPeriod();

      match.wait(const Duration(minutes: 3));
      expect(match.penaltyOf(penalty).remaining, mmss(1, 30));
      expect(match.penaltyOf(penalty).status, PenaltyStatus.paused);

      match.start();
      match.wait(const Duration(seconds: 30));
      expect(match.penaltyOf(penalty).remaining, mmss(1, 0));
      expect(match.penaltyOf(penalty).status, PenaltyStatus.running);
    },
  );

  test('17.3 OPEN-2: de straf pauzeert tijdens een team time-out', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    final penalty = match.penalty(black, 6, 2);
    match.start();
    match.wait(const Duration(seconds: 20));
    match
      ..stop()
      ..add(const MatchEventData.teamTimeOutRequested(team: white));
    match.wait(const Duration(minutes: 1));
    expect(match.penaltyOf(penalty).remaining, mmss(1, 40));
    expect(match.penaltyOf(penalty).status, PenaltyStatus.paused);
  });

  test('17.3 OPEN-2: met policy wallClock loopt de straf door in een '
      'time-out, maar niet tijdens een strafworp', () {
    final match = MatchScript(
      config: const MatchConfig(
        penaltyClockPolicy: PenaltyClockPolicy.wallClock,
      ),
    )..start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    final penalty = match.penalty(black, 6, 5);
    match.start();
    match.wait(const Duration(seconds: 20));
    match
      ..stop()
      ..add(const MatchEventData.teamTimeOutRequested(team: white));
    match.wait(const Duration(minutes: 1));
    expect(match.penaltyOf(penalty).remaining, mmss(3, 40));
    expect(match.penaltyOf(penalty).status, PenaltyStatus.running);

    match.start();
    match.add(const MatchEventData.penaltyShotAwarded(againstTeam: black));
    match.wait(const Duration(seconds: 30));
    expect(match.penaltyOf(penalty).remaining, mmss(3, 40));
    expect(match.penaltyOf(penalty).status, PenaltyStatus.paused);
  });

  test('4.5.4 meerdere strafklokken lopen tegelijk', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    final first = match.penalty(white, 1, 1);
    final second = match.penalty(white, 2, 2);
    final third = match.penalty(black, 3, 5);
    match.start();
    match.wait(const Duration(seconds: 30));
    expect(match.penaltyOf(first).remaining, mmss(0, 30));
    expect(match.penaltyOf(second).remaining, mmss(1, 30));
    expect(match.penaltyOf(third).remaining, mmss(4, 30));
  });

  test('17.8.2.3 een speler in de strafbank of een uitgesloten speler mag '
      'niet aan de strafworp deelnemen', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    match.penalty(white, 4, 2);
    match.add(
      const MatchEventData.playerDismissed(
        team: black,
        cap: 2,
        infringementCode: '16.3.17',
      ),
    );
    match.start();
    match.add(const MatchEventData.penaltyShotAwarded(againstTeam: black));

    expect(
      match.check(
        const MatchEventData.penaltyShotResolved(
          outcome: PenaltyShotOutcome.defended,
          attackers: [9, 4],
          defender: 1,
        ),
      ),
      const PenaltyShotNotAllowed(PenaltyShotProblem.playerInPenaltyBox),
    );
    expect(
      match.check(
        const MatchEventData.penaltyShotResolved(
          outcome: PenaltyShotOutcome.defended,
          attackers: [9, 5],
          defender: 2,
        ),
      ),
      const PenaltyShotNotAllowed(PenaltyShotProblem.playerDismissed),
    );
    expect(
      match.check(
        const MatchEventData.penaltyShotResolved(
          outcome: PenaltyShotOutcome.defended,
          attackers: [9, 5],
          defender: 1,
        ),
      ),
      isNull,
    );
    expect(
      match.check(const MatchEventData.penaltyShotAwarded(againstTeam: white)),
      const PenaltyShotNotAllowed(PenaltyShotProblem.alreadyPending),
    );
  });

  test('17.4 een uitgesloten speler krijgt geen goal of straf meer', () {
    final match = MatchScript()..start();
    final dismissal = match.add(
      const MatchEventData.playerDismissed(
        team: black,
        cap: 2,
        infringementCode: '16.3.17',
      ),
    );
    expect(match.penaltyOf(dismissal).status, PenaltyStatus.dismissal);
    expect(
      match.check(const MatchEventData.goalScored(team: black, scorerCap: 2)),
      const EventNotAllowed(GeneralProblem.playerDismissed),
    );
    expect(
      match.check(const MatchEventData.goalScored(team: black, scorerCap: 16)),
      const EventNotAllowed(GeneralProblem.capOutOfRange),
    );
    // Hetzelfde kapnummer bij het andere team is een andere speler.
    expect(
      match.check(const MatchEventData.goalScored(team: white, scorerCap: 2)),
      isNull,
    );
  });

  test('17.1 cautions en uitgesloten officials worden alleen gelogd', () {
    final match = MatchScript()..start();
    match
      ..add(
        const MatchEventData.cautionGiven(
          team: white,
          cap: 5,
          infringementCode: '16.3.5',
        ),
      )
      ..add(
        const MatchEventData.cautionGiven(
          team: black,
          infringementCode: '16.3.24',
          isTeamCaution: true,
        ),
      )
      ..add(const MatchEventData.officialDismissed(team: black, name: 'Coach'));
    expect(match.state.cautions, hasLength(2));
    expect(match.state.cautions.last.isTeamCaution, isTrue);
    expect(match.state.dismissedOfficials.single.name, 'Coach');
    expect(match.clock.running, isTrue);
  });
}
