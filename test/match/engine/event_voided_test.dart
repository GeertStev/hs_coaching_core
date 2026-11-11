import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';

import 'match_script.dart';

void main() {
  test('T13: een gevoide goal telt niet meer, maar blijft in het log', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match
      ..goal(white, cap: 3)
      ..start();
    match.wait(const Duration(minutes: 1));
    final mistake = match.goal(white, cap: 5);
    expect(match.state.score.white, 2);

    match.voidEvent(mistake);
    expect(match.state.score.white, 1);
    expect(match.state.goals.single.scorerCap, 3);
    expect(match.state.voidedEventIds, {mistake.id});
    // Het event zelf is niet verwijderd: de audit trail blijft volledig.
    expect(match.events, contains(mistake));
  });

  test('T13: een stop terugdraaien laat de klok achteraf verspringen', () {
    final match = MatchScript()..startSecondPeriod();
    match.playUntilRemaining(mmss(1, 30));
    final stop = match.stop();
    match.wait(const Duration(seconds: 20));
    expect(match.remaining, mmss(1, 30));
    match.voidEvent(stop);
    // Zonder de stop liep het spel gewoon door.
    expect(match.state.playRunning, isTrue);
    expect(match.remaining, mmss(1, 10));
  });

  test('T13: een gevoide time-out is niet opgebruikt', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match.stop();
    final timeOut = match.add(
      const MatchEventData.teamTimeOutRequested(team: white),
    );
    expect(match.state.timeOutsUsed(white, 1), 1);
    match.voidEvent(timeOut);
    expect(match.state.timeOutsUsed(white, 1), 0);
    expect(match.state.activeTimeOut, isNull);
  });

  test('T13: een gevoid periode-einde heropent de periode', () {
    final match = MatchScript()..start();
    match.wait(match.remaining!);
    final end = match.endPeriod();
    expect(match.state.phase, MatchPhase.halfTime);
    match.voidEvent(end);
    expect(match.state.phase, MatchPhase.p1);
    expect(match.clock.periodExpired, isTrue);
  });

  test('T13: wat niet ongeldig gemaakt kan worden', () {
    final match = MatchScript()..start();
    final goal = match.goal(white);
    final voided = match.voidEvent(goal);

    MatchRejection? check(String targetId) =>
        match.check(MatchEventData.eventVoided(targetId: targetId));

    expect(
      check('bestaat-niet'),
      const VoidNotAllowed(VoidProblem.unknownTarget),
    );
    expect(
      check(match.events.first.id),
      const VoidNotAllowed(VoidProblem.matchCreated),
    );
    expect(check(voided.id), const VoidNotAllowed(VoidProblem.voidEvent));
    expect(check(goal.id), const VoidNotAllowed(VoidProblem.alreadyVoided));

    // Een tweede void op dezelfde goal wordt bij het afspelen overgeslagen.
    final second = match.voidEvent(goal);
    expect(match.state.rejectedEvents[second.id], isA<VoidNotAllowed>());
    expect(match.state.score.white, 0);
  });
}
