import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/infringement_table.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';

import 'match_script.dart';

InfringementTable _loadTable() => InfringementTable.fromJson(
  jsonDecode(File(InfringementTable.assetPath).readAsStringSync())
      as Map<String, dynamic>,
);

List<List<Sanction>> _options(PenaltySuggestion? suggestion) =>
    suggestion!.step!.options;

void main() {
  final table = _loadTable();

  test('17.7.1 het JSON-bestand bevat de 25 rijen van de tabel', () {
    expect(table.rulesVersion, 'CMAS-13.0');
    expect(table.infringements, hasLength(25));
    final ids = table.infringements.map((i) => i.id).toSet();
    expect(ids, hasLength(25), reason: 'ids moeten uniek zijn');
    // 16.3.8 staat drie keer in de tabel.
    expect(ids.where((id) => id.startsWith('16.3.8-')), hasLength(3));
    for (final infringement in table.infringements) {
      expect(infringement.handSignalRules, isNotEmpty, reason: infringement.id);
      for (final step in [
        infringement.firstAccidental,
        infringement.firstDeliberate,
        infringement.secondAccidental,
        infringement.secondDeliberate,
        infringement.thirdOrMore,
      ]) {
        if (step == null) continue;
        expect(step.options, isNotEmpty, reason: infringement.id);
        expect(
          step.options.every((option) => option.isNotEmpty),
          isTrue,
          reason: infringement.id,
        );
        // Een "*" heeft alleen zin als er iets te kiezen valt.
        if (step.refereeChoice) {
          expect(step.options.length, greaterThan(1), reason: infringement.id);
        }
      }
    }
  });

  test('17.7.1 de tabel overleeft jsonEncode en jsonDecode', () {
    final json = jsonDecode(jsonEncode(table.toJson())) as Map<String, dynamic>;
    expect(InfringementTable.fromJson(json), table);
  });

  test('17.7.1 steekproef tegen de tabel in de PDF', () {
    final barging = table.byId('16.3.8-barging')!;
    expect(barging.firstAccidental!.options, [
      [Sanction.individualCaution],
    ]);
    expect(barging.firstDeliberate.options, [
      [Sanction.oneMinute],
    ]);
    expect(barging.secondAccidental!.options, [
      [Sanction.caution],
      [Sanction.twoMinutes],
    ]);
    expect(barging.secondAccidental!.refereeChoice, isTrue);

    final delay = table.byId('16.3.3')!;
    expect(delay.firstAccidental, isNull);
    expect(delay.firstDeliberate.options, [
      [Sanction.oneMinute, Sanction.teamCaution],
    ]);

    final dangerous = table.byId('16.3.21')!;
    expect(dangerous.firstAccidental!.options, [
      [Sanction.teamCaution, Sanction.twoMinutes],
    ]);
    expect(dangerous.thirdOrMore.options, [
      [Sanction.dismissal],
    ]);

    final stopping = table.byId('16.3.10')!;
    expect(stopping.firstDeliberate.options, [
      [Sanction.twoMinutes, Sanction.penaltyShot],
      [Sanction.twoMinutes, Sanction.penaltyGoal],
    ]);
    expect(table.byId('16.3.1')!.rules, ['16.3.1', '16.3.2']);
  });

  test('17.7.1 OPEN-3: de suggestie volgt de stappen per speler', () {
    const code = '16.3.8-barging';
    final match = MatchScript()..start();

    expect(
      table.suggestPenalty(match.state, white, 5, code, false)!.occurrence,
      1,
    );
    expect(_options(table.suggestPenalty(match.state, white, 5, code, false)), [
      [Sanction.individualCaution],
    ]);
    expect(_options(table.suggestPenalty(match.state, white, 5, code, true)), [
      [Sanction.oneMinute],
    ]);

    match.add(
      const MatchEventData.cautionGiven(
        team: white,
        cap: 5,
        infringementCode: code,
      ),
    );
    final second = table.suggestPenalty(match.state, white, 5, code, true)!;
    expect(second.occurrence, 2);
    expect(second.step!.options, [
      [Sanction.twoMinutes],
    ]);

    match.add(
      const MatchEventData.timePenaltyGiven(
        team: white,
        cap: 5,
        minutes: 2,
        infringementCode: code,
      ),
    );
    expect(
      table.suggestPenalty(match.state, white, 5, code, false)!.occurrence,
      3,
    );

    // Een andere speler, een ander team of een andere overtreding begint
    // opnieuw bij 1.
    expect(
      table.suggestPenalty(match.state, white, 6, code, false)!.occurrence,
      1,
    );
    expect(
      table.suggestPenalty(match.state, black, 5, code, false)!.occurrence,
      1,
    );
    expect(
      table.suggestPenalty(match.state, white, 5, '16.3.23', false)!.occurrence,
      1,
    );
  });

  test('17.7.1 OPEN-3: tellen per team is een instelbare policy', () {
    const code = '16.3.24';
    final match = MatchScript()..start();
    match.add(
      const MatchEventData.cautionGiven(
        team: white,
        cap: 5,
        infringementCode: code,
      ),
    );
    final perTeam = table.suggestPenalty(
      match.state,
      white,
      6,
      code,
      false,
      scope: InfringementCountScope.perTeamPerMatch,
    )!;
    expect(perTeam.occurrence, 2);
  });

  test('17.7.1 een gevoide straf telt niet mee', () {
    const code = '16.3.5';
    final match = MatchScript()..start();
    final caution = match.add(
      const MatchEventData.cautionGiven(
        team: black,
        cap: 2,
        infringementCode: code,
      ),
    );
    match.voidEvent(caution);
    expect(
      table.suggestPenalty(match.state, black, 2, code, false)!.occurrence,
      1,
    );
  });

  test(
    '17.7.1 een overtreding die niet accidenteel kan zijn geeft geen stap',
    () {
      final match = MatchScript();
      final suggestion = table.suggestPenalty(
        match.state,
        white,
        5,
        '16.3.17',
        false,
      )!;
      expect(suggestion.step, isNull);
      expect(
        table.suggestPenalty(match.state, white, 5, 'onbekend', false),
        isNull,
      );
    },
  );
}
