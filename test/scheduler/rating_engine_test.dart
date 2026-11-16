import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/scheduler/rating_config.dart';
import 'package:hs_coaching_core/scheduler/rating_engine.dart';
import 'package:hs_coaching_core/scheduler/scheduler_models.dart';

const _f = PlayerPosition.forward;
const _w = PlayerPosition.wing;

SquadPlayer _player(String id, Map<PlayerPosition, int> ratings) => SquadPlayer(
  id: id,
  firstName: id,
  positions: ratings.keys.toList(),
  startRatings: ratings,
);

LineupEntry _entry(String id, [PlayerPosition position = _f]) =>
    LineupEntry(playerId: id, position: position);

/// Wedstrijd van één tegen één op de voorpositie.
PracticeGame _duel(
  String date, {
  String white = 'a',
  String black = 'b',
  int scoreWhite = 1,
  int scoreBlack = 0,
  int minutes = 30,
  String id = '',
}) => PracticeGame(
  id: id.isEmpty ? date : id,
  date: date,
  durationMinutes: minutes,
  white: GameSide(score: scoreWhite, base: [_entry(white)]),
  black: GameSide(score: scoreBlack, base: [_entry(black)]),
);

/// Zonder relevantie-demping: elke wedstrijd telt volledig.
const _plain = RatingConfig(relevanceOffset: 1, relevanceCap: 0);

void main() {
  group('bouwstenen', () {
    test('vermoeidheid: gemiddelde van 0,99^t over de speeltijd', () {
      const config = RatingConfig();
      expect(fatigueFactor(0, config), 1);
      expect(fatigueFactor(30, config), closeTo(0.8633, 0.0005));
      expect(fatigueFactor(30, config.copyWith(fatiguePerMinute: 1)), 1);
    });

    test(
      'verwachte uitslag: gelijke ploegen 50%, 400 punten is 10 tegen 1',
      () {
        const config = RatingConfig();
        expect(expectedResult(1500, 1500, config), 0.5);
        expect(expectedResult(1900, 1500, config), closeTo(10 / 11, 1e-9));
      },
    );

    test('ploegsterkte: een wissel deelt de speeltijd op zijn positie', () {
      const config = RatingConfig(fatiguePerMinute: 1, teamRatingDivisor: 1);
      final side = GameSide(
        score: 0,
        base: [_entry('a'), _entry('b'), _entry('c', _w)],
        subs: [_entry('d')],
      );
      final rating = teamRating(
        side: side,
        durationMinutes: 30,
        ratingOf: (_) => 900,
        config: config,
      );
      // Voor: 3 x 900 x 2/3 = 1800, vleugel: 900.
      expect(rating, closeTo(2700, 1e-9));
    });

    test('ploegsterkte: een positie zonder basisspeler telt niet', () {
      final side = GameSide(score: 0, subs: [_entry('a')]);
      expect(
        teamRating(
          side: side,
          durationMinutes: 30,
          ratingOf: (_) => 900,
          config: const RatingConfig(),
        ),
        0,
      );
    });

    test('rang: hoogste drempel onder de rating, factor 1 zonder rang', () {
      const config = RatingConfig();
      expect(config.tierFor(2104)?.name, '10.Plesiosaur');
      expect(config.tierFor(3500)?.name, '01.Poseidon');
      expect(config.multiplierFor(1250), 1);
      expect(config.multiplierFor(850), 1.5);
      expect(config.tierFor(-5), isNull);
      expect(config.multiplierFor(-5), 1);
    });

    test('dagnummer: weigert een ongeldige datum', () {
      expect(dayNumber('1970-01-02'), 1);
      expect(() => dayNumber('2026-02-30'), throwsFormatException);
      expect(() => dayNumber('16/11/2026'), throwsFormatException);
    });
  });

  group('wedstrijd', () {
    final players = [
      _player('a', {_f: 1500}),
      _player('b', {_f: 1500}),
    ];

    test('zonder wedstrijden blijft de startrating staan', () {
      final result = computeRatings(
        players: players,
        games: const [],
        adjustments: const [],
        asOf: '2026-01-01',
      );
      expect(result.ratingOf('a', _f), 1500);
      expect(result.ratingOf('a', _w), isNull);
    });

    test('winnaar stijgt evenveel als de verliezer zakt', () {
      final result = computeRatings(
        players: players,
        games: [_duel('2026-01-10')],
        adjustments: const [],
        asOf: '2026-01-11',
        config: _plain,
      );
      final detail = result.games.single;
      // Effectief (1+1)/(1+0+2) = 2/3, prestatie = 400 x log10(2).
      expect(detail.changeWhite, closeTo(120.41, 0.01));
      expect(detail.changeBlack, closeTo(-120.41, 0.01));
      // Eigen wijziging + 25% meeneem-effect bij winst, 10% bij verlies.
      expect(result.ratingOf('a', _f), closeTo(1500 + 120.41 * 1.25, 0.01));
      expect(result.ratingOf('b', _f), closeTo(1500 - 120.41 * 1.1, 0.01));
    });

    test('gelijkspel tussen gelijke ploegen verandert niets', () {
      final result = computeRatings(
        players: players,
        games: [_duel('2026-01-10', scoreWhite: 3, scoreBlack: 3)],
        adjustments: const [],
        asOf: '2026-01-11',
        config: _plain,
      );
      expect(result.ratingOf('a', _f), closeTo(1500, 1e-9));
      expect(result.ratingOf('b', _f), closeTo(1500, 1e-9));
    });

    test('speeltijd: een wedstrijd van 15 minuten telt voor de helft', () {
      double changeFor(int minutes) => computeRatings(
        players: players,
        games: [_duel('2026-01-10', minutes: minutes)],
        adjustments: const [],
        asOf: '2026-01-11',
        // Zonder vermoeidheid, anders verschilt ook de ploegsterkte.
        config: _plain.copyWith(fatiguePerMinute: 1),
      ).games.single.changeWhite;

      expect(changeFor(15), closeTo(changeFor(30) / 2, 1e-9));
    });

    test('rang: een lage rating beweegt sneller dan een hoge', () {
      final result = computeRatings(
        players: [
          _player('a', {_f: 800}),
          _player('b', {_f: 800}),
        ],
        games: [_duel('2026-01-10')],
        adjustments: const [],
        asOf: '2026-01-11',
        config: _plain,
      );
      // Factor 1,5 onder 1200.
      expect(
        result.ratingOf('a', _f),
        closeTo(800 + 120.41 * 1.25 * 1.5, 0.01),
      );
    });

    test(
      'relevantie: eerste wedstrijd van een speler-positie telt voor 1/10',
      () {
        final result = computeRatings(
          players: players,
          games: [_duel('2026-01-10')],
          adjustments: const [],
          asOf: '2026-01-11',
        );
        expect(result.games.single.relevance, closeTo(0.1, 1e-9));
      },
    );

    test('relevantie: telt met alle wedstrijden, of alleen tot dan toe', () {
      final games = [for (var day = 10; day < 20; day++) _duel('2026-01-$day')];
      final all = computeRatings(
        players: players,
        games: games,
        adjustments: const [],
        asOf: '2026-02-01',
      );
      expect(all.games.first.relevance, 1);

      final soFar = computeRatings(
        players: players,
        games: games,
        adjustments: const [],
        asOf: '2026-02-01',
        config: const RatingConfig(
          relevanceCounting: RelevanceCounting.gamesSoFar,
        ),
      );
      expect(soFar.games.first.relevance, closeTo(0.1, 1e-9));
      expect(soFar.games.last.relevance, 1);
    });

    test('wedstrijden na de gevraagde datum tellen niet mee', () {
      final result = computeRatings(
        players: players,
        games: [_duel('2026-01-10'), _duel('2026-03-01')],
        adjustments: const [],
        asOf: '2026-02-01',
        config: _plain,
      );
      expect(result.games, hasLength(1));
      expect(result.stats[(playerId: 'a', position: _f)]?.games, 1);
    });

    test('statistieken: speeltijd en doelpunten voor en tegen', () {
      final result = computeRatings(
        players: players,
        games: [
          _duel('2026-01-10', scoreWhite: 5, scoreBlack: 2, minutes: 20),
          _duel('2026-01-11', white: 'b', black: 'a', scoreWhite: 1),
        ],
        adjustments: const [],
        asOf: '2026-02-01',
      );
      final stats = result.stats[(playerId: 'a', position: _f)]!;
      expect(stats.games, 2);
      expect(stats.minutes, 50);
      expect(stats.goalsFor, 5);
      expect(stats.goalsAgainst, 3);
    });

    test('speler zonder startrating telt als 0 en krijgt geen rating', () {
      final result = computeRatings(
        players: players,
        games: [_duel('2026-01-10', black: 'guest')],
        adjustments: const [],
        asOf: '2026-01-11',
        config: _plain,
      );
      final key = (playerId: 'guest', position: _f);
      expect(result.games.single.ratingsBefore[key], 0);
      expect(result.ratings.containsKey(key), isFalse);
    });
  });

  group('meeneem-effect', () {
    test('andere positie krijgt 10% van de dagwijziging', () {
      final result = computeRatings(
        players: [
          _player('a', {_f: 1500, _w: 1400}),
          _player('b', {_f: 1500}),
        ],
        games: [_duel('2026-01-10')],
        adjustments: const [],
        asOf: '2026-01-11',
        config: _plain,
      );
      expect(result.ratingOf('a', _w), closeTo(1400 + 12.04, 0.01));
    });

    test('zwakke nevenpositie zakt niet mee bij verlies', () {
      final result = computeRatings(
        players: [
          _player('a', {_f: 1500}),
          _player('b', {_f: 1500, _w: 900}),
          _player('c', {_f: 1500, _w: 1300}),
        ],
        games: [
          _duel('2026-01-10'),
          _duel('2026-01-11', black: 'c'),
        ],
        adjustments: const [],
        asOf: '2026-01-12',
        config: _plain,
      );
      expect(result.ratingOf('b', _w), 900);
      expect(result.ratingOf('c', _w), lessThan(1300));
    });
  });

  group('aanpassingen', () {
    final players = [
      _player('a', {_f: 1500, _w: 1200}),
      _player('b', {_f: 1500}),
    ];

    RatingAdjustment adjustment(
      RatingAdjustmentType type,
      String start,
      String end,
      double change,
    ) => RatingAdjustment(
      playerId: 'a',
      type: type,
      start: start,
      end: end,
      change: change,
    );

    test('instant: in één keer, op alle posities van de speler', () {
      final result = computeRatings(
        players: players,
        games: const [],
        adjustments: [
          adjustment(
            RatingAdjustmentType.instant,
            '2026-01-05',
            '2026-01-05',
            -400,
          ),
        ],
        asOf: '2026-01-10',
      );
      expect(result.ratingOf('a', _f), 1100);
      expect(result.ratingOf('a', _w), 800);
      expect(result.ratingOf('b', _f), 1500);
    });

    test('instant: nog niet vóór de begindatum', () {
      final result = computeRatings(
        players: players,
        games: const [],
        adjustments: [
          adjustment(
            RatingAdjustmentType.instant,
            '2026-01-05',
            '2026-01-05',
            -400,
          ),
        ],
        asOf: '2026-01-04',
      );
      expect(result.ratingOf('a', _f), 1500);
    });

    test('linear: gelijk verdeeld over de dagen', () {
      RatingResult at(String asOf) => computeRatings(
        players: players,
        games: const [],
        adjustments: [
          adjustment(
            RatingAdjustmentType.linear,
            '2026-01-01',
            '2026-01-11',
            100,
          ),
        ],
        asOf: asOf,
      );

      expect(at('2026-01-01').ratingOf('a', _f), 1500);
      expect(at('2026-01-06').ratingOf('a', _f), closeTo(1550, 1e-9));
      expect(at('2026-01-11').ratingOf('a', _f), closeTo(1600, 1e-9));
      expect(at('2026-03-01').ratingOf('a', _f), closeTo(1600, 1e-9));
    });

    test('linear: loopt door over de wedstrijden heen', () {
      final result = computeRatings(
        players: players,
        games: [
          _duel('2026-01-03', white: 'b', black: 'c', scoreWhite: 0),
          _duel('2026-01-08', white: 'b', black: 'c', scoreWhite: 0),
        ],
        adjustments: [
          adjustment(
            RatingAdjustmentType.linear,
            '2026-01-01',
            '2026-01-11',
            100,
          ),
        ],
        asOf: '2026-02-01',
      );
      expect(result.ratingOf('a', _f), closeTo(1600, 1e-9));
    });

    test('SHEET-1: aanpassing sinds de vorige wedstrijd telt pas erna', () {
      final result = computeRatings(
        players: players,
        games: [_duel('2026-01-10')],
        adjustments: [
          adjustment(
            RatingAdjustmentType.instant,
            '2026-01-05',
            '2026-01-05',
            -400,
          ),
        ],
        asOf: '2026-01-11',
        config: _plain,
      );
      final key = (playerId: 'a', position: _f);
      expect(result.games.single.ratingsBefore[key], 1500);

      final withStart = computeRatings(
        players: players,
        games: [_duel('2026-01-10')],
        adjustments: [
          adjustment(
            RatingAdjustmentType.instant,
            '2026-01-05',
            '2026-01-05',
            -400,
          ),
        ],
        asOf: '2026-01-11',
        config: _plain.copyWith(timelineStart: '2026-01-06'),
      );
      expect(withStart.games.single.ratingsBefore[key], 1100);
    });
  });

  group('reeksbonus', () {
    test('SHEET-4: +10 na 25 wedstrijden met minstens 65% winst', () {
      final players = [
        _player('a', {_f: 1500}),
        _player('b', {_f: 1500}),
      ];
      // Zonder wijziging door de rang of het meeneem-effect.
      final config = _plain.copyWith(
        crossPositionWinShare: 0,
        crossPositionLossShare: 0,
        rankTiers: const [],
      );
      List<PracticeGame> games(int count) => [
        for (var i = 0; i < count; i++)
          _duel(
            '2026-01-${(i + 1).toString().padLeft(2, '0')}',
            scoreWhite: 1,
            scoreBlack: 0,
          ),
      ];

      double sumOfChanges(RatingResult result) =>
          result.games.fold(0, (sum, game) => sum + game.changeWhite);

      final after24 = computeRatings(
        players: players,
        games: games(24),
        adjustments: const [],
        asOf: '2026-02-01',
        config: config,
      );
      expect(
        after24.ratingOf('a', _f),
        closeTo(1500 + sumOfChanges(after24), 1e-6),
      );

      final after25 = computeRatings(
        players: players,
        games: games(25),
        adjustments: const [],
        asOf: '2026-02-01',
        config: config,
      );
      expect(
        after25.ratingOf('a', _f),
        closeTo(1500 + sumOfChanges(after25) + 10, 1e-6),
      );
      expect(
        after25.ratingOf('b', _f),
        closeTo(1500 - sumOfChanges(after25) - 10, 1e-6),
      );
    });
  });
}
