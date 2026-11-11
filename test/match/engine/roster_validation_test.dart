import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_roster.dart';

import 'match_script.dart';

List<MatchPlayer> _players(int count) => [
  for (var cap = 1; cap <= count; cap++) MatchPlayer(cap: cap, name: 'Speler $cap'),
];

MatchEventData _roster(List<MatchPlayer> players, {List<String> staff = const []}) =>
    MatchEventData.rosterDeclared(team: white, players: players, staff: staff);

void main() {
  test('3.1.1 T14: een roster met 11 spelers geeft een validatiefout', () {
    final match = MatchScript();
    expect(
      match.check(_roster(_players(11))),
      const RosterInvalid(RosterProblem.tooManyPlayers),
    );
    final event = match.add(_roster(_players(11)));
    expect(match.state.roster(white), isEmpty);
    expect(match.state.rejectedEvents[event.id], isA<RosterInvalid>());
  });

  test('3.1.1 een roster met 10 spelers of minder wordt aanvaard', () {
    final match = MatchScript();
    expect(match.check(_roster(_players(10))), isNull);
    match.add(
      _roster([
        const MatchPlayer(cap: 1, name: 'An', role: MatchPlayerRole.captain),
        const MatchPlayer(
          cap: 15,
          name: 'Bo',
          role: MatchPlayerRole.viceCaptain,
          playerId: 'uid-bo',
        ),
      ], staff: ['Coach']),
    );
    expect(match.state.roster(white), hasLength(2));
    expect(match.state.roster(white).last.playerId, 'uid-bo');
    expect(match.state.staff(white), ['Coach']);
    expect(match.state.roster(black), isEmpty);
  });

  test('3.2.2 kapnummers liggen tussen 1 en 15 en zijn uniek', () {
    final match = MatchScript();
    expect(
      match.check(_roster([const MatchPlayer(cap: 0, name: 'Nul')])),
      const RosterInvalid(RosterProblem.capOutOfRange),
    );
    expect(
      match.check(_roster([const MatchPlayer(cap: 16, name: 'Zestien')])),
      const RosterInvalid(RosterProblem.capOutOfRange),
    );
    expect(
      match.check(
        _roster([
          const MatchPlayer(cap: 7, name: 'Een'),
          const MatchPlayer(cap: 7, name: 'Twee'),
        ]),
      ),
      const RosterInvalid(RosterProblem.duplicateCap),
    );
  });

  test('3.2.4 hooguit één kapitein en één vice-kapitein', () {
    final match = MatchScript();
    expect(
      match.check(
        _roster([
          const MatchPlayer(cap: 1, name: 'A', role: MatchPlayerRole.captain),
          const MatchPlayer(cap: 2, name: 'B', role: MatchPlayerRole.captain),
        ]),
      ),
      const RosterInvalid(RosterProblem.multipleCaptains),
    );
    expect(
      match.check(
        _roster([
          const MatchPlayer(cap: 1, name: 'A', role: MatchPlayerRole.viceCaptain),
          const MatchPlayer(cap: 2, name: 'B', role: MatchPlayerRole.viceCaptain),
        ]),
      ),
      const RosterInvalid(RosterProblem.multipleViceCaptains),
    );
  });

  test('3.1.4 hooguit 4 begeleiders', () {
    final match = MatchScript();
    expect(
      match.check(_roster(_players(6), staff: ['a', 'b', 'c', 'd', 'e'])),
      const RosterInvalid(RosterProblem.tooManyStaff),
    );
    expect(match.check(_roster(_players(6), staff: ['a', 'b', 'c', 'd'])), isNull);
  });
}
