import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/scheduler/rating_config.dart';
import 'package:hs_coaching_core/scheduler/rating_engine.dart';
import 'package:hs_coaching_core/scheduler/scheduler_config.dart';
import 'package:hs_coaching_core/scheduler/scheduler_models.dart';
import 'package:hs_coaching_core/scheduler/sheet_import.dart';
import 'package:hs_coaching_core/scheduler/team_scheduler.dart';

const _f = PlayerPosition.forward;
const _c = PlayerPosition.center;
const _w = PlayerPosition.wing;
const _g = PlayerPosition.goalie;

/// Opstelling 2-3-1 uit het blad.
const _slots231 = [_f, _f, _c, _w, _w, _g];

SquadPlayer _player(String id, Map<PlayerPosition, int> ratings) => SquadPlayer(
  id: id,
  firstName: id,
  positions: ratings.keys.toList(),
  startRatings: ratings,
);

/// Rating = startrating, zonder wedstrijden.
double? Function(String, PlayerPosition) _ratingsOf(List<SquadPlayer> players) {
  final byId = {for (final p in players) p.id: p};
  return (id, position) => byId[id]?.startRatings[position]?.toDouble();
}

void main() {
  group('scheduleTeams', () {
    test(
      'twee ploegen van zes: iedereen één keer, op een toegelaten positie',
      () {
        final players = [
          for (var i = 0; i < 12; i++)
            _player('p$i', {
              _f: 1500 + 40 * i,
              _c: 1400 + 35 * i,
              _w: 1450 + 30 * i,
              _g: 1300 + 45 * i,
            }),
        ];
        final result = scheduleTeams(
          teams: const [
            TeamSetup(name: 'White', slots: _slots231),
            TeamSetup(name: 'Black', slots: _slots231),
          ],
          attendees: [for (final p in players) Attendee(playerId: p.id)],
          players: players,
          ratingOf: _ratingsOf(players),
        );

        expect(result.unassigned, isEmpty);
        expect(result.picks, hasLength(12));
        for (final team in result.teams) {
          expect(team.subs, isEmpty);
          expect(
            [for (final e in team.base) e.position]..sort(_byIndex),
            [..._slots231]..sort(_byIndex),
          );
        }
        final ids = [
          for (final team in result.teams)
            for (final e in team.base) e.playerId,
        ];
        expect(ids.toSet(), hasLength(12));
        final chance = winChance(
          result.teams[0],
          result.teams[1],
          const RatingConfig(),
        );
        expect(chance, closeTo(0.5, 0.1));
      },
    );

    test(
      'de eerste keuze gaat naar de eerste ploeg, de tweede naar de andere',
      () {
        final players = [
          _player('a', {_f: 2000}),
          _player('b', {_f: 1900}),
          _player('c', {_f: 1500}),
          _player('d', {_f: 1400}),
        ];
        final result = scheduleTeams(
          teams: const [
            TeamSetup(name: 'White', slots: [_f, _f]),
            TeamSetup(name: 'Black', slots: [_f, _f]),
          ],
          attendees: [for (final p in players) Attendee(playerId: p.id)],
          players: players,
          ratingOf: _ratingsOf(players),
        );
        // Sterkste eerst, telkens naar de zwakste ploeg: a+d tegen b+c.
        expect(
          [for (final p in result.picks) p.playerId],
          ['a', 'b', 'c', 'd'],
        );
        expect(
          [for (final p in result.picks) p.team],
          ['White', 'Black', 'Black', 'White'],
        );
      },
    );

    test('ploegsterkte is dezelfde als teamRating van de rating-engine', () {
      final players = [
        for (var i = 0; i < 14; i++)
          _player('p$i', {
            _f: 1500 + 30 * i,
            _c: 1450 + 20 * i,
            _w: 1400,
            _g: 1350 + 10 * i,
          }),
      ];
      final ratingOf = _ratingsOf(players);
      final result = scheduleTeams(
        teams: const [
          TeamSetup(name: 'White', slots: _slots231, substitutes: {_f: 1}),
          TeamSetup(name: 'Black', slots: _slots231, substitutes: {_w: 1}),
        ],
        attendees: [for (final p in players) Attendee(playerId: p.id)],
        players: players,
        ratingOf: ratingOf,
      );
      expect(result.unassigned, isEmpty);
      expect(result.teams[0].subs.single.position, _f);
      expect(result.teams[1].subs.single.position, _w);
      for (final team in result.teams) {
        final expected = teamRating(
          side: team.toGameSide(score: 0),
          durationMinutes: 30,
          ratingOf: (e) => ratingOf(e.playerId, e.position)!,
          config: const RatingConfig(),
        );
        expect(team.rating(const RatingConfig()), closeTo(expected, 1e-9));
      }
    });

    test('vaste positie en vaste ploeg worden gevolgd', () {
      final players = [
        for (var i = 0; i < 12; i++)
          _player('p$i', {
            _f: 1500 + 40 * i,
            _c: 1500,
            _w: 1500,
            _g: 1500 - 20 * i,
          }),
      ];
      final result = scheduleTeams(
        teams: const [
          TeamSetup(name: 'White', slots: _slots231),
          TeamSetup(name: 'Black', slots: _slots231),
        ],
        attendees: [
          const Attendee(
            playerId: 'p11',
            fixedPosition: _g,
            fixedTeam: 'Black',
          ),
          const Attendee(playerId: 'p10', fixedTeam: 'Black'),
          const Attendee(playerId: 'p0', fixedPosition: _f),
          for (var i = 1; i < 10; i++) Attendee(playerId: 'p$i'),
        ],
        players: players,
        ratingOf: _ratingsOf(players),
      );
      expect(result.unassigned, isEmpty);
      final black = result.teams[1];
      expect(
        black.base,
        contains(const LineupEntry(playerId: 'p11', position: _g)),
      );
      expect(black.base.map((e) => e.playerId), contains('p10'));
      final p0 = result.picks.singleWhere((p) => p.playerId == 'p0');
      expect(p0.position, _f);
    });

    test('een speler komt nooit op een positie die niet aangevinkt is', () {
      final players = [
        _player('g1', {_g: 1200}),
        _player('g2', {_g: 1900}),
        for (var i = 0; i < 10; i++)
          _player('p$i', {
            _f: 1500 + 20 * i,
            _c: 1500 + 10 * i,
            _w: 1500 - 10 * i,
          }),
      ];
      final result = scheduleTeams(
        teams: const [
          TeamSetup(name: 'White', slots: _slots231),
          TeamSetup(name: 'Black', slots: _slots231),
        ],
        attendees: [for (final p in players) Attendee(playerId: p.id)],
        players: players,
        ratingOf: _ratingsOf(players),
      );
      expect(result.unassigned, isEmpty);
      final byId = {for (final p in players) p.id: p};
      for (final pick in result.picks) {
        expect(byId[pick.playerId]!.positions, contains(pick.position));
      }
    });

    test('meer spelers dan plaatsen: de rest staat in unassigned', () {
      final players = [
        for (var i = 0; i < 5; i++) _player('p$i', {_f: 1500 + 50 * i}),
      ];
      final result = scheduleTeams(
        teams: const [
          TeamSetup(name: 'White', slots: [_f, _f]),
          TeamSetup(name: 'Black', slots: [_f, _f]),
        ],
        attendees: [for (final p in players) Attendee(playerId: p.id)],
        players: players,
        ratingOf: _ratingsOf(players),
      );
      expect(result.unassigned, hasLength(1));
      expect(result.teams.expand((t) => [...t.base, ...t.subs]), hasLength(4));
    });

    test('acht ploegen (meer dan het blad kan) worden allemaal gevuld', () {
      final players = [
        for (var i = 0; i < 48; i++)
          _player('p$i', {
            _f: 1200 + 17 * i,
            _c: 1250 + 13 * i,
            _w: 1300 + 11 * i,
            _g: 1100 + 19 * i,
          }),
      ];
      final result = scheduleTeams(
        teams: [
          for (var t = 0; t < 8; t++)
            TeamSetup(name: 'Team $t', slots: _slots231),
        ],
        attendees: [for (final p in players) Attendee(playerId: p.id)],
        players: players,
        ratingOf: _ratingsOf(players),
      );
      expect(result.unassigned, isEmpty);
      final ratings = [
        for (final t in result.teams) t.rating(const RatingConfig()),
      ]..sort();
      for (final team in result.teams) {
        expect(team.base, hasLength(6));
      }
      // Alle ploegen liggen dicht bij elkaar.
      expect(ratings.last - ratings.first, lessThan(120));
    });

    test(
      'Prioritize Experience kiest de speler met de meeste speeltijd eerst',
      () {
        final players = [
          _player('new', {_f: 1500, _c: 1500}),
          _player('old', {_f: 1500, _c: 1500}),
          _player('x', {_f: 1400, _c: 1400}),
          _player('y', {_f: 1450, _c: 1450}),
        ];
        const stats = {
          (playerId: 'old', position: _f): PositionStats(
            games: 100,
            minutes: 3000,
          ),
        };
        ScheduleResult run({
          bool experience = false,
          bool inexperience = false,
        }) => scheduleTeams(
          teams: const [
            TeamSetup(name: 'White', slots: [_f, _c]),
            TeamSetup(name: 'Black', slots: [_f, _c]),
          ],
          attendees: [for (final p in players) Attendee(playerId: p.id)],
          players: players,
          ratingOf: _ratingsOf(players),
          stats: stats,
          prioritizeExperience: experience,
          prioritizeInexperience: inexperience,
        );
        final experienced = run(experience: true).picks.first;
        expect(experienced.playerId, 'old');
        expect(experienced.position, _f);
        // Omgekeerd schuift de ervaren positie naar achteren.
        final other = run(inexperience: true).picks.first;
        expect(other.playerId == 'old' && other.position == _f, isFalse);
      },
    );

    test('winstkans, voordeel per positie en verwachte score', () {
      final players = [
        _player('a', {_f: 2000}),
        _player('b', {_f: 1500}),
      ];
      const stats = {
        (playerId: 'a', position: _f): PositionStats(
          games: 10,
          minutes: 300,
          goalsFor: 40,
          goalsAgainst: 20,
        ),
        (playerId: 'b', position: _f): PositionStats(
          games: 10,
          minutes: 300,
          goalsFor: 20,
          goalsAgainst: 40,
        ),
      };
      const config = RatingConfig();
      final result = scheduleTeams(
        teams: const [
          TeamSetup(name: 'White', slots: [_f]),
          TeamSetup(name: 'Black', slots: [_f]),
        ],
        attendees: const [
          Attendee(playerId: 'a'),
          Attendee(playerId: 'b'),
        ],
        players: players,
        ratingOf: _ratingsOf(players),
      );
      final white = result.teams[0];
      final black = result.teams[1];
      expect(white.base.single.playerId, 'a');
      final chance = winChance(white, black, config);
      expect(chance, greaterThan(0.5));
      expect(chance + winChance(black, white, config), closeTo(1, 1e-9));
      expect(
        positionAdvantage(white, black, _f, config),
        closeTo(chance * 2 - 1, 1e-9),
      );
      expect(positionAdvantage(white, black, _g, config), 0);
      // 0,2 doelpunten per minuut over 30 minuten = 6, verdeeld volgens kans.
      final goalsWhite = expectedGoals(
        schedule: result,
        team: white,
        other: black,
        stats: stats,
      )!;
      final goalsBlack = expectedGoals(
        schedule: result,
        team: black,
        other: white,
        stats: stats,
      )!;
      expect(goalsWhite + goalsBlack, closeTo(6, 0.01));
      expect(goalsWhite, closeTo(6 * chance, 0.01));
    });

    test('SchedulerConfig gaat heen en terug door JSON', () {
      const config = SchedulerConfig(gameMinutes: 20, scarcePositionBonus: 1);
      final decoded = SchedulerConfig.fromJson(
        jsonDecode(jsonEncode(config.toJson())) as Map<String, dynamic>,
      );
      expect(decoded, config);
    });
  });

  group('met de ratings uit het blad', () {
    late SheetImport import;
    late RatingResult ratings;

    setUpAll(() {
      import = parseSheetExport(
        jsonDecode(
              File(
                'test/scheduler/fixtures/teamscheduler_sheet.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>,
      );
      ratings = computeRatings(
        players: import.players,
        games: import.games,
        adjustments: import.adjustments,
        config: import.config,
        asOf: '2026-11-16',
      );
    });

    test('de spelers van elke wedstrijd uit het log geven twee volle, '
        'evenwichtige ploegen', () {
      final playerById = {for (final p in import.players) p.id: p};
      final compositions = {for (final c in import.compositions) c.name: c};
      var scheduled = 0;
      final chances = <double>[];
      for (final game in import.games) {
        final white = compositions[game.white.composition];
        final black = compositions[game.black.composition];
        if (white == null || black == null) continue;
        Map<PlayerPosition, int> subsOf(GameSide side) => {
          for (final position in PlayerPosition.values)
            position: side.subs.where((e) => e.position == position).length,
        };
        final teams = [
          TeamSetup(
            name: 'White',
            slots: white.slots,
            substitutes: subsOf(game.white),
          ),
          TeamSetup(
            name: 'Black',
            slots: black.slots,
            substitutes: subsOf(game.black),
          ),
        ];
        final ids = {
          for (final e in [...game.white.entries, ...game.black.entries])
            e.playerId,
        }.toList();
        final capacity = teams.fold(
          0,
          (sum, t) =>
              sum + PlayerPosition.values.fold(0, (s, p) => s + t.capacity(p)),
        );
        if (ids.length != capacity) continue;
        final result = scheduleTeams(
          teams: teams,
          attendees: [for (final id in ids) Attendee(playerId: id)],
          players: [for (final id in ids) playerById[id]!],
          ratingOf: ratings.ratingOf,
          stats: ratings.stats,
          ratingConfig: import.config,
        );
        scheduled++;
        final placed = result.teams
            .expand((t) => [...t.base, ...t.subs])
            .length;
        expect(placed + result.unassigned.length, ids.length);
        chances.add(winChance(result.teams[0], result.teams[1], import.config));
      }
      expect(scheduled, greaterThan(50));
      final average = chances.reduce((a, b) => a + b) / chances.length;
      expect(average, closeTo(0.5, 0.05));
    });
  });
}

int _byIndex(PlayerPosition a, PlayerPosition b) => a.index - b.index;
