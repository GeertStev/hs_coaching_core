import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';

import 'match_script.dart';

const _timeOutWhite = MatchEventData.teamTimeOutRequested(team: white);
const _timeOutBlack = MatchEventData.teamTimeOutRequested(team: black);

void main() {
  test('14.2.6 T5: team time-out terwijl het spel loopt wordt geweigerd', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 2));
    expect(
      match.check(_timeOutWhite),
      const TimeOutNotAllowed(TimeOutProblem.playRunning),
    );
    // Wordt het event toch gelogd, dan slaat de reducer het over.
    final event = match.add(_timeOutWhite);
    expect(match.state.activeTimeOut, isNull);
    expect(match.state.timeOutsUsed(white, 1), 0);
    expect(match.state.rejectedEvents[event.id], isA<TimeOutNotAllowed>());
  });

  test('14.2.6 T6: tweede time-out in dezelfde helft geweigerd, in P2 weer 1', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 2));
    match
      ..stop()
      ..add(_timeOutWhite);
    expect(match.state.timeOutsUsed(white, 1), 1);
    match.wait(const Duration(minutes: 1));
    match.start(RestartType.afterTimeOut);
    match.wait(const Duration(minutes: 1));
    match.stop();
    expect(
      match.check(_timeOutWhite),
      const TimeOutNotAllowed(TimeOutProblem.alreadyUsedThisHalf),
    );
    // Het andere team heeft zijn time-out nog.
    expect(match.check(_timeOutBlack), isNull);

    match.start();
    match.wait(match.remaining!);
    match
      ..endPeriod()
      ..start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    expect(match.check(_timeOutWhite), isNull);
  });

  test('14.2.6 T7: time-out in overtime 1 wordt geweigerd', () {
    final match = MatchScript(config: const MatchConfig(requiresWinner: true));
    match
      ..playFullPeriod()
      ..playFullPeriod();
    expect(match.state.phase, MatchPhase.otBreak);
    expect(
      match.check(_timeOutWhite),
      const TimeOutNotAllowed(TimeOutProblem.notInRegularPeriod),
    );
    match.start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    expect(match.state.phase, MatchPhase.ot1);
    expect(
      match.check(_timeOutWhite),
      const TimeOutNotAllowed(TimeOutProblem.notInRegularPeriod),
    );
  });

  test('14.2.6 geen time-out zolang een strafworp openstaat', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 2));
    match.add(const MatchEventData.penaltyShotAwarded(againstTeam: black));
    expect(
      match.check(_timeOutWhite),
      const TimeOutNotAllowed(TimeOutProblem.penaltyShotPending),
    );
  });

  test('14.2.6.1 de klok staat stil en herstart niet vanzelf na 1:00', () {
    final match = MatchScript()..start();
    match.playUntilRemaining(mmss(12, 0));
    match
      ..stop()
      ..add(_timeOutBlack);
    match.wait(const Duration(seconds: 50));
    final timeOut = match.clock.timeOut!;
    expect(timeOut.kind, TimeOutKind.team);
    expect(timeOut.team, black);
    expect(timeOut.remaining, const Duration(seconds: 10));
    expect(timeOut.warningReached, isTrue);
    expect(match.remaining, mmss(12, 0));

    // Ruim voorbij de minuut: de klok wacht op het startsignaal.
    match.wait(const Duration(seconds: 40));
    expect(match.clock.timeOut!.remaining, Duration.zero);
    expect(match.clock.running, isFalse);
    expect(match.remaining, mmss(12, 0));
    match.start(RestartType.afterTimeOut);
    match.wait(const Duration(seconds: 10));
    expect(match.remaining, mmss(11, 50));
  });

  test('14.2.6 de waarschuwing komt op 0:45', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match
      ..stop()
      ..add(_timeOutWhite);
    match.wait(const Duration(seconds: 44));
    expect(match.clock.timeOut!.warningReached, isFalse);
    match.wait(const Duration(seconds: 1));
    expect(match.clock.timeOut!.warningReached, isTrue);
  });

  test('14.2.6.5 een time-out mag aansluiten op die van de tegenstander', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    final first = match.add(_timeOutWhite);
    match.wait(const Duration(seconds: 40));
    expect(match.check(_timeOutBlack), isNull);
    match.add(_timeOutBlack);
    final chained = match.state.activeTimeOut!;
    expect(chained.team, black);
    // De tweede begint pas als de eerste om is.
    expect(
      chained.startedAtMillis,
      first.serverTimeMillis + const Duration(minutes: 1).inMilliseconds,
    );
    match.wait(const Duration(seconds: 30));
    expect(match.clock.timeOut!.remaining, const Duration(seconds: 50));
  });

  test('14.2.6.5 een time-out mag aansluiten op een officials\' time-out', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match.add(const MatchEventData.officialsTimeOutStarted());
    match.wait(const Duration(seconds: 30));
    expect(match.check(_timeOutWhite), isNull);
  });

  test('14.2.6 het aantal time-outs per helft komt uit de config', () {
    final match = MatchScript(
      config: const MatchConfig(timeOutsPerTeamPerHalf: 2),
    )..start();
    match.wait(const Duration(minutes: 1));
    match
      ..stop()
      ..add(_timeOutWhite)
      ..start()
      ..stop();
    expect(match.check(_timeOutWhite), isNull);
    match
      ..add(_timeOutWhite)
      ..start()
      ..stop();
    expect(
      match.check(_timeOutWhite),
      const TimeOutNotAllowed(TimeOutProblem.alreadyUsedThisHalf),
    );
  });
}
