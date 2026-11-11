import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/clock_view.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_reducer.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';

import 'match_script.dart';

/// Vat een toestand samen in vergelijkbare waarden.
List<Object?> _summary(MatchState state, int now) {
  final clock = clockViewAt(state, now);
  return [
    state.matchId,
    state.phase,
    state.score,
    clock.periodRemaining,
    clock.running,
    state.playRunning,
    state.goals.map((goal) => goal.eventId).toList(),
    clock.penalties
        .map((penalty) => '${penalty.cap}:${penalty.status.name}:${penalty.remaining}')
        .toList(),
    state.timeOutsUsed(white, 1),
    state.lastSeq,
  ];
}

void main() {
  test('T17: 3 wedstrijden tegelijk met events door elkaar: geen '
      'kruisbesmetting', () {
    // Veld 1: gewone wedstrijd met een goal en een straf.
    final field1 = MatchScript(matchId: 'veld-1')..start();
    field1.wait(const Duration(minutes: 2));
    field1
      ..goal(white, cap: 3)
      ..penalty(black, 4, 2)
      ..start();
    field1.wait(const Duration(seconds: 50));

    // Veld 2: andere config, begint 90 s later, met een time-out.
    final field2 = MatchScript(
      matchId: 'veld-2',
      config: const MatchConfig(periodLength: Duration(minutes: 10)),
      startMillis: field1.events.first.serverTimeMillis + 90000,
    )..start();
    field2.wait(const Duration(minutes: 1));
    field2
      ..stop()
      ..add(const MatchEventData.teamTimeOutRequested(team: white));
    field2.wait(const Duration(seconds: 80));

    // Veld 3: al in periode 2, in het stilgezette-klokvenster.
    final field3 = MatchScript(matchId: 'veld-3')..startSecondPeriod();
    field3.playUntilRemaining(mmss(1, 30));
    field3.stop();
    field3.wait(const Duration(seconds: 15));

    final scripts = [field1, field2, field3];

    // Alle events door elkaar, gesorteerd op tijd zoals ze binnenkomen.
    final mixed = [for (final script in scripts) ...script.events]
      ..sort((a, b) => a.serverTimeMillis.compareTo(b.serverTimeMillis));
    final together = reduceMatches(mixed);

    expect(together.keys, unorderedEquals(['veld-1', 'veld-2', 'veld-3']));
    for (final script in scripts) {
      final alone = reduceMatch(script.events);
      expect(
        _summary(together[script.matchId]!, script.now),
        _summary(alone, script.now),
        reason: script.matchId,
      );
    }

    expect(together['veld-1']!.score.white, 1);
    expect(together['veld-2']!.score.white, 0);
    expect(together['veld-2']!.timeOutsUsed(white, 1), 1);
    expect(together['veld-1']!.timeOutsUsed(white, 1), 0);
    expect(clockViewAt(together['veld-3']!, field3.now).periodRemaining, mmss(1, 30));
    expect(clockViewAt(together['veld-2']!, field2.now).periodRemaining, mmss(9, 0));
  });

  test('02 §1 de reducer is deterministisch en sorteert op seq', () {
    final match = MatchScript()..start();
    match.wait(const Duration(minutes: 1));
    match
      ..goal(white)
      ..start();
    match.wait(const Duration(minutes: 1));

    final shuffled = match.events.reversed.toList();
    expect(
      _summary(reduceMatch(shuffled), match.now),
      _summary(reduceMatch(match.events), match.now),
    );
  });

  test('02 §1 clockViewAt verandert de toestand niet', () {
    final match = MatchScript()..start();
    final state = match.state;
    final later = clockViewAt(state, match.now + 60000);
    expect(later.periodRemaining, mmss(14, 0));
    expect(state.remainingInPhase, mmss(15, 0));
    // Een tijdstip vóór het laatste event geeft de toestand van dat event.
    expect(clockViewAt(state, match.now - 5000).periodRemaining, mmss(15, 0));
  });
}
