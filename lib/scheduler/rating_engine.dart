import 'dart:math' as math;

import 'rating_config.dart';
import 'scheduler_models.dart';

// Rating-engine van de Team scheduler: pure Dart, geen Flutter of Firebase,
// geen systeemklok (de datum is een parameter).
//
// Rekent uit startratings + wedstrijdlog + aanpassingen de rating van elke
// speler-positie, exact zoals het blad "Teamscheduler 4.1 rating update".
// Het blad heeft één kolom per wedstrijd; de engine loopt dezelfde kolommen
// af. Waar het blad iets onverwachts doet staat `SHEET-x`: dat gedrag is
// bewust overgenomen zodat de ratings gelijk blijven aan die van het blad.
//
// - SHEET-1: de rating waarmee een wedstrijd gerekend wordt is de stand na
//   de vorige kolom. Aanpassingen tussen de vorige wedstrijd en deze tellen
//   dus pas ná deze wedstrijd mee. Het blad begint met één lege kolom
//   ([RatingConfig.timelineStart]) waarin de oudste aanpassingen vallen.
// - SHEET-2: een instant-aanpassing valt in de eerste kolom met een datum op
//   of na haar begin.
// - SHEET-3: het laatste stuk van een lineaire aanpassing telt vanaf de
//   vorige kolom, ook als de aanpassing pas daarna begon.
// - SHEET-4: de reeksbonus komt één kolom na de wedstrijd die hem oplevert
//   en geldt voor alle posities van de speler.
// - SHEET-5: de relevantie telt met alle wedstrijden in het log
//   ([RelevanceCounting.allGames]).

/// Sleutel van een rating: één speler op één positie.
typedef RatingKey = ({String playerId, PlayerPosition position});

/// Wat de engine voor één wedstrijd berekende.
class GameRatingDetail {
  const GameRatingDetail({
    required this.game,
    required this.ratingsBefore,
    required this.teamRatingWhite,
    required this.teamRatingBlack,
    required this.changeWhite,
    required this.changeBlack,
    required this.relevance,
  });

  final PracticeGame game;

  /// Rating van elke opgestelde speler-positie vóór de wedstrijd (0 zonder
  /// startrating).
  final Map<RatingKey, double> ratingsBefore;
  final double teamRatingWhite;
  final double teamRatingBlack;

  /// Basiswijziging per speler van de ploeg, vóór de factor van de rang.
  final double changeWhite;
  final double changeBlack;
  final double relevance;

  /// Verwachte uitslag voor wit (0..1) volgens de ploegsterktes.
  double expectedWhite(RatingConfig config) =>
      expectedResult(teamRatingWhite, teamRatingBlack, config);
}

/// Speeltijd en doelpunten van één speler-positie over het hele log.
class PositionStats {
  const PositionStats({
    this.games = 0,
    this.minutes = 0,
    this.goalsFor = 0,
    this.goalsAgainst = 0,
  });

  final int games;
  final int minutes;
  final int goalsFor;
  final int goalsAgainst;

  PositionStats _add(int duration, int scored, int conceded) => PositionStats(
    games: games + 1,
    minutes: minutes + duration,
    goalsFor: goalsFor + scored,
    goalsAgainst: goalsAgainst + conceded,
  );
}

/// Uitkomst van [computeRatings].
class RatingResult {
  const RatingResult({
    required this.ratings,
    required this.games,
    required this.stats,
  });

  /// Rating per speler-positie op de gevraagde datum.
  final Map<RatingKey, double> ratings;

  /// Detail per wedstrijd, in de volgorde waarin ze gerekend zijn.
  final List<GameRatingDetail> games;
  final Map<RatingKey, PositionStats> stats;

  double? ratingOf(String playerId, PlayerPosition position) =>
      ratings[(playerId: playerId, position: position)];
}

/// Kans (0..1) dat een ploeg met sterkte [own] wint van [other].
double expectedResult(double own, double other, RatingConfig config) =>
    1 / (1 + math.pow(10, (other - own) / config.eloScale));

/// Gemiddelde sterkte over [minutes] minuten spelen: het gemiddelde van
/// `fatiguePerMinute ^ t` voor t van 0 tot [minutes].
double fatigueFactor(double minutes, RatingConfig config) {
  if (minutes <= 0) return 1;
  final ln = math.log(config.fatiguePerMinute);
  if (ln == 0) return 1;
  return (math.exp(ln * minutes) - 1) / (minutes * ln);
}

/// Sterkte van één ploeg. Per positie tellen de ratings van basisspelers en
/// wissels samen, gewogen met de deelname (basis / (basis + wissels)) en de
/// vermoeidheid over de eigen speeltijd.
double teamRating({
  required GameSide side,
  required int durationMinutes,
  required double Function(LineupEntry entry) ratingOf,
  required RatingConfig config,
}) {
  var total = 0.0;
  for (final position in PlayerPosition.values) {
    final base = side.base.where((e) => e.position == position).toList();
    if (base.isEmpty) continue;
    final subs = side.subs.where((e) => e.position == position).toList();
    final participation = base.length / (base.length + subs.length);
    var sum = 0.0;
    for (final entry in [...base, ...subs]) {
      sum += ratingOf(entry);
    }
    total +=
        sum *
        participation *
        fatigueFactor(durationMinutes * participation, config);
  }
  return total / config.teamRatingDivisor;
}

/// Rekent alle ratings uit op kalenderdag [asOf] (`yyyy-MM-dd`).
///
/// Wedstrijden na [asOf] tellen niet mee. Lineaire aanpassingen lopen door
/// tot [asOf]. Het blad toont de stand van "morgen": geef daarvoor de dag na
/// vandaag mee.
RatingResult computeRatings({
  required List<SquadPlayer> players,
  required List<PracticeGame> games,
  required List<RatingAdjustment> adjustments,
  required String asOf,
  RatingConfig config = const RatingConfig(),
}) {
  final asOfDay = dayNumber(asOf);

  // Huidige stand per speler-positie, en de posities per speler.
  final ratings = <RatingKey, double>{};
  final keysOfPlayer = <String, List<RatingKey>>{};
  for (final player in players) {
    for (final entry in player.startRatings.entries) {
      final key = (playerId: player.id, position: entry.key);
      ratings[key] = entry.value.toDouble();
      keysOfPlayer.putIfAbsent(player.id, () => []).add(key);
    }
  }

  final ordered =
      [
        for (final game in games)
          if (dayNumber(game.date) <= asOfDay) game,
      ]..sort((a, b) {
        final byDate = dayNumber(a.date).compareTo(dayNumber(b.date));
        return byDate != 0 ? byDate : a.id.compareTo(b.id);
      });

  // SHEET-5: aantal wedstrijden per speler-positie over het hele log.
  final appearances = <RatingKey, int>{};
  final stats = <RatingKey, PositionStats>{};
  for (final game in ordered) {
    for (final (side, other) in [
      (game.white, game.black),
      (game.black, game.white),
    ]) {
      for (final entry in side.entries) {
        final key = (playerId: entry.playerId, position: entry.position);
        appearances[key] = (appearances[key] ?? 0) + 1;
        stats[key] = (stats[key] ?? const PositionStats())._add(
          game.durationMinutes,
          side.score,
          other.score,
        );
      }
    }
  }
  final appearancesSoFar = <RatingKey, int>{};

  final schedule = [for (final a in adjustments) _ScheduledAdjustment(a)];
  final streaks = <String, List<int>>{};
  var pendingBonus = <String, double>{};
  int? previousDay;

  /// Eén kolom van het blad: wijzigingen van de wedstrijd + aanpassingen.
  void step(int day, Map<RatingKey, double> changes) {
    final dayTotal = <String, double>{};
    for (final entry in changes.entries) {
      dayTotal[entry.key.playerId] =
          (dayTotal[entry.key.playerId] ?? 0) + entry.value;
    }
    final adjusted = <String, double>{};
    for (final adjustment in schedule) {
      final value = adjustment.valueFor(previousDay, day);
      if (value != 0) {
        final id = adjustment.source.playerId;
        adjusted[id] = (adjusted[id] ?? 0) + value;
      }
    }

    final next = <RatingKey, double>{};
    for (final entry in keysOfPlayer.entries) {
      final playerId = entry.key;
      var best = double.negativeInfinity;
      for (final key in entry.value) {
        best = math.max(best, ratings[key]!);
      }
      final total = dayTotal[playerId] ?? 0;
      for (final key in entry.value) {
        final current = ratings[key]!;
        final own = changes[key] ?? 0;
        // Een zwakke nevenpositie zakt niet mee met een negatieve dag.
        final protected =
            current < config.crossPositionFloorRating && current < best;
        final carried = protected ? math.max(total, 0.0) : total;
        final share = own > 0
            ? config.crossPositionWinShare
            : config.crossPositionLossShare;
        next[key] =
            current +
            (carried * share + own) * config.multiplierFor(current) +
            (pendingBonus[playerId] ?? 0) +
            (adjusted[playerId] ?? 0);
      }
    }
    ratings.addAll(next);

    // SHEET-4: reeksbonus voor de volgende kolom.
    pendingBonus = {};
    final played = <String, int>{};
    final balance = <String, int>{};
    for (final entry in changes.entries) {
      if (entry.value == 0) continue;
      final id = entry.key.playerId;
      played[id] = (played[id] ?? 0) + 1;
      balance[id] = (balance[id] ?? 0) + (entry.value > 0 ? 1 : -1);
    }
    for (final id in played.keys) {
      final history = streaks.putIfAbsent(id, () => [])..add(balance[id]!);
      if (history.length < config.streakWindow) continue;
      final window = history.sublist(history.length - config.streakWindow);
      final wins = window.where((b) => b > 0).length;
      final losses = window.where((b) => b < 0).length;
      if (wins + losses == 0) continue;
      final share = wins / (wins + losses);
      if (share >= config.streakHighShare) {
        pendingBonus[id] = config.streakBonus;
      } else if (share <= config.streakLowShare) {
        pendingBonus[id] = -config.streakBonus;
      }
    }
    previousDay = day;
  }

  // SHEET-1: de lege eerste kolom van het blad.
  final timelineStart = config.timelineStart;
  if (timelineStart != null && dayNumber(timelineStart) <= asOfDay) {
    step(dayNumber(timelineStart), const {});
  }

  final details = <GameRatingDetail>[];
  for (final game in ordered) {
    final before = <RatingKey, double>{};
    double ratingOf(LineupEntry entry) {
      final key = (playerId: entry.playerId, position: entry.position);
      return before[key] = ratings[key] ?? 0;
    }

    final white = teamRating(
      side: game.white,
      durationMinutes: game.durationMinutes,
      ratingOf: ratingOf,
      config: config,
    );
    final black = teamRating(
      side: game.black,
      durationMinutes: game.durationMinutes,
      ratingOf: ratingOf,
      config: config,
    );
    final all = [...game.white.entries, ...game.black.entries];
    for (final entry in all) {
      final key = (playerId: entry.playerId, position: entry.position);
      before.putIfAbsent(key, () => ratings[key] ?? 0);
      appearancesSoFar[key] = (appearancesSoFar[key] ?? 0) + 1;
    }

    final counts = switch (config.relevanceCounting) {
      RelevanceCounting.allGames => appearances,
      RelevanceCounting.gamesSoFar => appearancesSoFar,
    };
    var fewest = config.relevanceCap;
    for (final entry in all) {
      final key = (playerId: entry.playerId, position: entry.position);
      fewest = math.min(fewest, counts[key] ?? 0);
    }
    final relevance = 1 / (config.relevanceOffset - fewest);

    final goals = game.white.score + game.black.score;
    double change(GameSide side, double own, double other) {
      if (side.entries.isEmpty) return 0;
      final effective = (side.score + 1) / (goals + 2);
      final performance =
          -math.log(1 / effective - 1) / math.ln10 * config.eloScale;
      return (other - own + performance) /
          side.entries.length *
          game.durationMinutes /
          config.referenceDurationMinutes *
          relevance;
    }

    final changeWhite = change(game.white, white, black);
    final changeBlack = change(game.black, black, white);
    details.add(
      GameRatingDetail(
        game: game,
        ratingsBefore: before,
        teamRatingWhite: white,
        teamRatingBlack: black,
        changeWhite: changeWhite,
        changeBlack: changeBlack,
        relevance: relevance,
      ),
    );

    final changes = <RatingKey, double>{};
    for (final (side, value) in [
      (game.white, changeWhite),
      (game.black, changeBlack),
    ]) {
      for (final entry in side.entries) {
        final key = (playerId: entry.playerId, position: entry.position);
        changes[key] = (changes[key] ?? 0) + value;
      }
    }
    step(dayNumber(game.date), changes);
  }

  // Slotkolom: aanpassingen (en een openstaande reeksbonus) tot [asOf]. Valt
  // de laatste wedstrijd op [asOf] zelf, dan is haar kolom al de slotkolom.
  final lastDay = previousDay;
  if (lastDay == null || lastDay < asOfDay) {
    step(asOfDay, const {});
  }

  return RatingResult(
    ratings: Map.unmodifiable(ratings),
    games: List.unmodifiable(details),
    stats: Map.unmodifiable(stats),
  );
}

/// Een aanpassing met haar dagnummers en of de instant-wijziging al viel.
class _ScheduledAdjustment {
  _ScheduledAdjustment(this.source)
    : start = dayNumber(source.start),
      end = dayNumber(source.end);

  final RatingAdjustment source;
  final int start;
  final int end;
  bool _applied = false;

  /// Wijziging in de kolom met dagnummer [day]; [previous] is de kolom ervoor.
  double valueFor(int? previous, int day) {
    if (source.type == RatingAdjustmentType.instant) {
      // SHEET-2
      if (_applied || day < start) return 0;
      _applied = true;
      return source.change;
    }
    final days = end - start;
    if (days <= 0) return 0;
    final perDay = source.change / days;
    var value = 0.0;
    if (start < day && end >= day) {
      final from = previous == null ? start : math.max(start, previous);
      value += perDay * math.max(0, day - from);
    }
    // SHEET-3. Zonder vorige kolom telt de hele aanpassing.
    if (start < day && end < day && (previous == null || end >= previous)) {
      value += perDay * (end - (previous ?? start));
    }
    return value;
  }
}
