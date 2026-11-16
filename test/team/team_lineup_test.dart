import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/scheduler/scheduler_models.dart';
import 'package:hs_coaching_core/scheduler/team_scheduler.dart';
import 'package:hs_coaching_core/team/team_lineup.dart';

const _f = PlayerPosition.forward;
const _w = PlayerPosition.wing;

ScheduledTeam _team(String name, String prefix) => ScheduledTeam(
  setup: TeamSetup(
    name: name,
    slots: const [_f, _w],
    substitutes: const {_w: 1},
  ),
  base: [
    LineupEntry(playerId: '${prefix}1', position: _f),
    LineupEntry(playerId: '${prefix}2', position: _w),
  ],
  subs: [LineupEntry(playerId: '${prefix}3', position: _w)],
  strengthByPosition: const {},
);

void main() {
  test('opstelling gaat heen en terug: basis eerst, dan de wissels', () {
    final lineup = teamLineupJson(
      white: _team('White', 'w'),
      black: _team('Black', 'b'),
      nameOf: (id) => 'Name $id',
    );
    final decoded =
        jsonDecode(jsonEncode({teamLineupField: lineup}))
            as Map<String, dynamic>;
    final teams = teamsFromLineup(decoded)!;
    expect([for (final p in teams[0].front) p.name], ['Name w1']);
    expect([for (final p in teams[0].wing) p.name], ['Name w2', 'Name w3']);
    expect(teams[0].center, isEmpty);
    expect([for (final p in teams[1].wing) p.name], ['Name b2', 'Name b3']);
  });

  test('zonder opstelling in het document: null', () {
    expect(teamsFromLineup(null), isNull);
    expect(teamsFromLineup({'timestamp': 1}), isNull);
    expect(
      teamsFromLineup({
        teamLineupField: {'white': {}},
      }),
      isNull,
    );
  });
}
