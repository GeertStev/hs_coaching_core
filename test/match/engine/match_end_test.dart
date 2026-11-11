import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';

import 'match_script.dart';

const _signOff = MatchEventData.matchEndedBySignOff(
  chiefSignature: 'CR',
  waterSignatures: ['WR1', 'WR2'],
);

void main() {
  test('14.2.1.1 T11: gelijkspel na P2 zonder vereiste winnaar: '
      'awaitingSignOff', () {
    final match = MatchScript()
      ..playFullPeriod()
      ..playFullPeriod();
    expect(match.state.phase, MatchPhase.awaitingSignOff);
    expect(match.state.winner, isNull);
    expect(match.state.needsDelegateDecision, isFalse);
    expect(match.check(_signOff), isNull);
  });

  test('14.2.4 T12: gelijkspel na P2 en OT2 met vereiste winnaar: sudden '
      'death, eerste goal beëindigt de wedstrijd', () {
    final match = MatchScript(config: const MatchConfig(requiresWinner: true));
    match
      ..playFullPeriod()
      ..playFullPeriod();
    expect(match.state.phase, MatchPhase.otBreak);
    match.wait(const Duration(minutes: 1));
    expect(match.clock.breakRemaining, mmss(2, 0));

    match.start();
    expect(match.state.phase, MatchPhase.ot1);
    expect(match.remaining, mmss(5, 0));
    // Overtime 1 start aan dezelfde kant als de wedstrijd.
    expect(match.state.whiteOnLeft, isTrue);
    match.wait(match.remaining!);
    match.endPeriod();
    expect(match.state.phase, MatchPhase.otInterval);
    expect(match.clock.breakRemaining, mmss(1, 0));

    match.playFullPeriod();
    expect(match.state.phase, MatchPhase.sdBreak);
    // 14.2.5: vóór sudden death wordt niet van kant gewisseld.
    expect(match.state.whiteOnLeft, isFalse);

    match.start();
    expect(match.state.phase, MatchPhase.suddenDeath);
    match.wait(const Duration(minutes: 3));
    match.goal(black, cap: 4);
    expect(match.state.phase, MatchPhase.awaitingSignOff);
    expect(match.state.winner, black);
    expect(match.state.playRunning, isFalse);
  });

  test('14.2.4 overtime wordt volledig gespeeld, ook na een goal in OT1', () {
    final match = MatchScript(config: const MatchConfig(requiresWinner: true));
    match
      ..playFullPeriod()
      ..playFullPeriod()
      ..start();
    match.wait(const Duration(minutes: 1));
    match
      ..goal(white)
      ..start();
    match.wait(match.remaining!);
    match.endPeriod();
    expect(match.state.phase, MatchPhase.otInterval);
    match.playFullPeriod();
    expect(match.state.phase, MatchPhase.awaitingSignOff);
    expect(match.state.winner, white);
  });

  test('14.2.4 met een winnaar na P2 volgt geen overtime', () {
    final match = MatchScript(config: const MatchConfig(requiresWinner: true));
    match
      ..playFullPeriod()
      ..start();
    match.wait(const Duration(minutes: 1));
    match
      ..goal(black)
      ..start();
    match.wait(match.remaining!);
    match.endPeriod();
    expect(match.state.phase, MatchPhase.awaitingSignOff);
  });

  test('14.2.4 OPEN-10 T22: zonder overtime volgt direct sudden death', () {
    final match = MatchScript(
      config: const MatchConfig(requiresWinner: true, overtimePeriods: 0),
    );
    match
      ..playFullPeriod()
      ..playFullPeriod();
    expect(match.state.phase, MatchPhase.sdBreak);
    match.start();
    expect(match.state.phase, MatchPhase.suddenDeath);
  });

  test('14.2.4 OPEN-10 T22: overtime en sudden death uit: afsluiten wacht op '
      'de Technical Delegate', () {
    final match = MatchScript(
      config: const MatchConfig(
        requiresWinner: true,
        overtimePeriods: 0,
        suddenDeathEnabled: false,
      ),
    );
    match
      ..playFullPeriod()
      ..playFullPeriod();
    expect(match.state.phase, MatchPhase.awaitingSignOff);
    expect(match.state.needsDelegateDecision, isTrue);
    expect(
      match.check(_signOff),
      const SignOffNotAllowed(SignOffProblem.winnerRequired),
    );

    match.add(
      const MatchEventData.resultDecidedByDelegate(
        winner: white,
        text: 'Winnaar na loting',
      ),
    );
    expect(match.state.needsDelegateDecision, isFalse);
    expect(match.check(_signOff), isNull);
    match.add(_signOff);
    expect(match.state.phase, MatchPhase.finalized);
    expect(match.state.winner, white);
    expect(match.state.delegateText, 'Winnaar na loting');
  });

  test('4.4.2.5 na de handtekeningen is de wedstrijd final', () {
    final match = MatchScript()
      ..playFullPeriod()
      ..start();
    match.wait(const Duration(minutes: 1));
    match
      ..goal(white, cap: 3)
      ..start();
    match.wait(match.remaining!);
    match.endPeriod();
    expect(
      match.check(const MatchEventData.playStarted()),
      const EventNotAllowed(GeneralProblem.wrongPhase),
    );
    match.add(_signOff);
    expect(match.state.phase, MatchPhase.finalized);
    expect(match.state.outcomeKind, MatchOutcomeKind.played);
    expect(match.state.winner, white);
    expect(match.state.goals.single.phase, MatchPhase.p2);
    expect(match.state.goals.single.elapsedInPhase, mmss(1, 0));
    expect(
      match.check(const MatchEventData.goalScored(team: black)),
      const EventNotAllowed(GeneralProblem.matchFinal),
    );
  });

  test('5.3.1 forfait: het andere team wint', () {
    final match = MatchScript()
      ..add(
        const MatchEventData.matchForfeited(
          team: black,
          decisionText: 'Niet klaar binnen 2 minuten',
        ),
      );
    expect(match.state.phase, MatchPhase.finalized);
    expect(match.state.outcomeKind, MatchOutcomeKind.forfeited);
    expect(match.state.winner, white);
  });

  test('5.x staking: de Technical Delegate kan een stand opleggen', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 4));
    match.add(
      const MatchEventData.matchAbandoned(
        decisionText: 'Zwembad ontruimd',
        resultOverride: MatchScore(white: 0, black: 5),
      ),
    );
    expect(match.state.phase, MatchPhase.finalized);
    expect(match.state.outcomeKind, MatchOutcomeKind.abandoned);
    expect(match.state.winner, black);
    expect(match.clock.running, isFalse);
  });

  test('5.x protesten en officials komen in de toestand', () {
    final match = MatchScript()
      ..add(
        const MatchEventData.officialsAssigned(
          chief: 'CR',
          water: ['WR1', 'WR2'],
          timekeepers: ['Vierde'],
        ),
      )
      ..start()
      ..add(
        const MatchEventData.protestLogged(
          team: white,
          by: 'Kapitein',
          text: 'Goal na het signaal',
        ),
      );
    expect(match.state.chiefReferee, 'CR');
    expect(match.state.waterReferees, ['WR1', 'WR2']);
    expect(match.state.protests.single.text, 'Goal na het signaal');
  });

  test('02 §1 events vóór MatchCreated of een tweede MatchCreated worden '
      'geweigerd', () {
    final match = MatchScript();
    expect(
      match.check(
        const MatchEventData.matchCreated(
          config: MatchConfig(),
          teamWhite: 'A',
          teamBlack: 'B',
        ),
      ),
      const EventNotAllowed(GeneralProblem.matchAlreadyCreated),
    );
    expect(match.state.config, const MatchConfig());
    expect(match.state.teamWhite, 'Wit');
  });
}
