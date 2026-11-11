import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_roster.dart';
import 'package:hs_coaching_core/team/team_model.dart';

/// Echte `jsonEncode`/`jsonDecode`: zo valt een vergeten `explicitToJson` op
/// vóór het pas bij een Firestore-write misloopt.
Map<String, dynamic> _roundTrip(Map<String, dynamic> json) =>
    jsonDecode(jsonEncode(json)) as Map<String, dynamic>;

const _white = TeamColor.white;
const _black = TeamColor.black;

const List<MatchEventData> _allEvents = [
  MatchEventData.matchCreated(
    config: MatchConfig(
      periodLength: Duration(minutes: 12),
      requiresWinner: true,
      penaltyClockPolicy: PenaltyClockPolicy.wallClock,
      stoppedClockPhases: {MatchPhase.p2},
      presetName: 'Poule 2x12',
    ),
    teamWhite: 'Holy Squid',
    teamBlack: 'Gasten',
    startingEnds: StartingEnds.whiteRight,
    tournamentId: 'bk-2027',
    fieldId: 'veld-2',
  ),
  MatchEventData.rosterDeclared(
    team: _white,
    players: [
      MatchPlayer(cap: 1, name: 'An', role: MatchPlayerRole.captain),
      MatchPlayer(cap: 2, name: 'Bo', playerId: 'uid-bo'),
    ],
    staff: ['Coach'],
  ),
  MatchEventData.officialsAssigned(
    chief: 'CR',
    water: ['WR1', 'WR2'],
    timekeepers: ['Vierde'],
  ),
  MatchEventData.periodWarningGiven(phase: MatchPhase.p1),
  MatchEventData.playStarted(
    restartType: RestartType.advantagePuck,
    team: _black,
  ),
  MatchEventData.playStopped(reason: StopReason.injury),
  MatchEventData.stopReasonSpecified(targetId: 'e5', reason: StopReason.confer),
  MatchEventData.officialsTimeOutStarted(reason: 'overleg'),
  MatchEventData.teamTimeOutRequested(team: _white),
  MatchEventData.periodEnded(phase: MatchPhase.p1),
  MatchEventData.goalScored(
    team: _black,
    scorerCap: 7,
    kind: GoalKind.penaltyGoal,
  ),
  MatchEventData.cautionGiven(
    team: _white,
    cap: 3,
    infringementCode: '16.3.5',
    deliberate: true,
  ),
  MatchEventData.timePenaltyGiven(
    team: _white,
    cap: 3,
    minutes: 2,
    infringementCode: '16.3.6',
  ),
  MatchEventData.playerDismissed(
    team: _black,
    cap: 9,
    infringementCode: '16.3.17',
  ),
  MatchEventData.officialDismissed(team: _black, name: 'Coach'),
  MatchEventData.penaltyShotAwarded(againstTeam: _black),
  MatchEventData.penaltyShotResolved(
    outcome: PenaltyShotOutcome.defended,
    attackers: [4, 5],
    defender: 1,
  ),
  MatchEventData.penaltyPlayerReturned(team: _white, cap: 3),
  MatchEventData.protestLogged(team: _white, by: 'Kapitein', text: 'Protest'),
  MatchEventData.eventVoided(targetId: 'e11', reason: 'verkeerd team'),
  MatchEventData.matchEndedBySignOff(
    chiefSignature: 'CR',
    waterSignatures: ['WR1'],
  ),
  MatchEventData.resultDecidedByDelegate(winner: _white, text: 'Beslissing'),
  MatchEventData.matchForfeited(team: _black, decisionText: 'Niet opgedaagd'),
  MatchEventData.matchAbandoned(
    decisionText: 'Gestaakt',
    resultOverride: MatchScore(white: 5, black: 0),
  ),
];

void main() {
  test('elk eventtype overleeft jsonEncode en jsonDecode', () {
    for (final (index, data) in _allEvents.indexed) {
      final event = MatchEvent(
        id: 'e${index + 1}',
        matchId: 'm1',
        seq: index + 1,
        serverTimeMillis: 1700000000000 + index,
        deviceId: 'tafel-1',
        authorRole: MatchAuthorRole.chiefReferee,
        authorId: 'uid-cr',
        source: EventSource.remote,
        data: data,
      );
      final decoded = MatchEvent.fromJson(_roundTrip(event.toJson()));
      expect(decoded, event, reason: data.runtimeType.toString());
    }
  });

  test('de lijst dekt alle eventtypes', () {
    final types = {
      for (final data in _allEvents) data.toJson()['type'] as String,
    };
    expect(types, hasLength(_allEvents.length));
    expect(types, hasLength(24));
  });

  test('het eventtype staat in het veld type', () {
    final json = _roundTrip(
      const MatchEventData.goalScored(team: _white, scorerCap: 4).toJson(),
    );
    expect(json['type'], 'goalScored');
    expect(json['team'], 'white');
    expect(json['kind'], 'field');
  });

  test('MatchConfig bewaart duren als milliseconden', () {
    const config = MatchConfig(periodLength: Duration(minutes: 12));
    final json = _roundTrip(config.toJson());
    expect(json['periodLength'], 720000);
    expect(json['stoppedClockWindow'], 120000);
    expect(MatchConfig.fromJson(json), config);
  });

  test('de defaults van MatchConfig zijn CMAS v13', () {
    const config = MatchConfig();
    expect(config.periodLength, const Duration(minutes: 15));
    expect(config.halfTimeBreak, const Duration(minutes: 3));
    expect(config.overtimePeriod, const Duration(minutes: 5));
    expect(config.stoppedClockWindow, const Duration(minutes: 2));
    expect(config.timeOutsPerTeamPerHalf, 1);
    expect(config.rulesVersion, 'CMAS-13.0');
    expect(config.stoppedClockPhases, {
      MatchPhase.p2,
      MatchPhase.ot2,
      MatchPhase.suddenDeath,
    });
  });
}
