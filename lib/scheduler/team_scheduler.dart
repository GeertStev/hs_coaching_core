import 'dart:math' as math;

import 'rating_config.dart';
import 'rating_engine.dart';
import 'scheduler_config.dart';
import 'scheduler_models.dart';

/// Eén ploeg die de scheduler moet vullen: een opstelling plus het aantal
/// wissels per positie.
class TeamSetup {
  const TeamSetup({
    required this.name,
    required this.slots,
    this.substitutes = const {},
  });

  final String name;

  /// De posities in het water, bv. F F C W W G.
  final List<PlayerPosition> slots;

  /// Aantal wissels per positie (in het blad: een vinkje per plaats).
  final Map<PlayerPosition, int> substitutes;

  int baseCount(PlayerPosition position) =>
      slots.where((slot) => slot == position).length;

  int subCount(PlayerPosition position) => substitutes[position] ?? 0;

  /// Aantal spelers dat op [position] in deze ploeg past.
  int capacity(PlayerPosition position) =>
      baseCount(position) + subCount(position);

  /// Deel van de speeltijd dat een speler op [position] in het water ligt:
  /// basis / (basis + wissels). 0 als de ploeg de positie niet heeft.
  double participation(PlayerPosition position) {
    final total = capacity(position);
    return total == 0 ? 0 : baseCount(position) / total;
  }
}

/// Een aanwezige speler, met de keuzes van de trainer.
class Attendee {
  const Attendee({required this.playerId, this.fixedPosition, this.fixedTeam});

  final String playerId;

  /// De speler moet op deze positie spelen.
  final PlayerPosition? fixedPosition;

  /// De speler moet in deze ploeg ([TeamSetup.name]) spelen.
  final String? fixedTeam;
}

/// Eén stap van de indeling: de gekozen speler en waar die terechtkomt.
class SchedulerPick {
  const SchedulerPick({
    required this.step,
    required this.playerId,
    required this.ratedPosition,
    required this.position,
    required this.team,
    required this.rating,
    required this.score,
    required this.substitute,
    required this.placed,
  });

  /// Volgnummer van de stap, vanaf 1.
  final int step;
  final String playerId;

  /// Positie waarvan de rating is gebruikt.
  final PlayerPosition ratedPosition;

  /// Positie waarop de speler staat (de vaste positie als die er is).
  final PlayerPosition position;

  /// Ploeg, of `null` als er geen ploeg met een vrije plaats was.
  final String? team;
  final double rating;

  /// Score waarmee deze speler de stap won.
  final double score;
  final bool substitute;

  /// `false`: geen plaats meer, de speler staat in [ScheduleResult.unassigned].
  final bool placed;
}

/// Een gevulde ploeg.
class ScheduledTeam {
  const ScheduledTeam({
    required this.setup,
    required this.base,
    required this.subs,
    required this.strengthByPosition,
  });

  final TeamSetup setup;
  final List<LineupEntry> base;
  final List<LineupEntry> subs;

  /// Bijdrage per positie aan de ploegsterkte (nog niet gedeeld door
  /// `teamRatingDivisor`).
  final Map<PlayerPosition, double> strengthByPosition;

  String get name => setup.name;

  /// Ploegsterkte op dezelfde schaal als `teamRating` in `rating_engine.dart`.
  double rating(RatingConfig config) =>
      strengthByPosition.values.fold(0.0, (a, b) => a + b) /
      config.teamRatingDivisor;

  /// De ploeg als kant van een oefenwedstrijd, klaar voor het wedstrijdlog.
  GameSide toGameSide({required int score, String composition = ''}) =>
      GameSide(composition: composition, score: score, base: base, subs: subs);
}

/// Resultaat van [scheduleTeams].
class ScheduleResult {
  const ScheduleResult({
    required this.teams,
    required this.picks,
    required this.unassigned,
  });

  final List<ScheduledTeam> teams;

  /// Alle stappen in volgorde, ook de spelers zonder plaats.
  final List<SchedulerPick> picks;

  /// Aanwezige spelers voor wie geen plaats was.
  final List<String> unassigned;
}

/// Verdeelt de aanwezige spelers over de ploegen, zoals het tabblad
/// "Scheduler" van het blad: per stap krijgt elke speler-positie een score,
/// de hoogste score wordt gekozen en gaat naar de zwakste ploeg met een vrije
/// plaats op die positie.
///
/// De score is `(rating - drempel) x deelname x vermoeidheid`, met de drempel
/// het gemiddelde min de standaardafwijking van de kandidaten op de positie.
/// Wie ver boven de rest van zijn positie uitsteekt, wordt dus eerst verdeeld.
///
/// [attendees] staat in de volgorde van de spelerslijst; bij gelijke score
/// wint de eerste. [ratingOf] geeft de huidige rating (`RatingResult.ratingOf`)
/// en [stats] de speeltijd per speler-positie (`RatingResult.stats`).
///
/// Werkt voor elk aantal ploegen. Bewuste afwijkingen van het blad (dat
/// hoogstens zes ploegen kent):
/// - Bij ploegen met exact dezelfde sterkte zoekt het blad alleen in de eerste
///   daarvan naar een vrije plaats, hier in allemaal.
/// - Een plaats blijft vrij voor een speler die vast op die positie in die
///   ploeg staat, en een speler met een vaste ploeg komt nooit op een positie
///   die in zijn ploeg al vol is. Het blad zet zo'n speler dan boven het
///   aantal plaatsen, waardoor hij niet in de opstelling verschijnt.
ScheduleResult scheduleTeams({
  required List<TeamSetup> teams,
  required List<Attendee> attendees,
  required List<SquadPlayer> players,
  required double? Function(String playerId, PlayerPosition position) ratingOf,
  Map<RatingKey, PositionStats> stats = const {},
  bool prioritizeExperience = false,
  bool prioritizeInexperience = false,
  SchedulerConfig config = const SchedulerConfig(),
  RatingConfig ratingConfig = const RatingConfig(),
}) {
  final teamByName = {for (final team in teams) team.name: team};
  final playerById = {for (final player in players) player.id: player};

  // Alleen posities die in minstens één opstelling voorkomen doen mee.
  final positions = [
    for (final position in PlayerPosition.values)
      if (teams.any((team) => team.baseCount(position) > 0)) position,
  ];

  // Eén rij per aanwezige speler en positie. Rating 0 = mag daar niet staan.
  final rows = <_Row>[];
  for (final attendee in attendees) {
    final player = playerById[attendee.playerId];
    for (final position in positions) {
      final allowed =
          (player == null || player.positions.contains(position)) &&
          (attendee.fixedPosition == null ||
              attendee.fixedPosition == position);
      rows.add(
        _Row(
          attendee: attendee,
          position: position,
          rating: allowed ? (ratingOf(attendee.playerId, position) ?? 0) : 0,
        ),
      );
    }
  }

  final fixedCount = <PlayerPosition, int>{
    for (final position in positions)
      position: attendees.where((a) => a.fixedPosition == position).length,
  };

  double minutesOf(String playerId, PlayerPosition position) =>
      (stats[(playerId: playerId, position: position)]?.minutes ?? 0) +
      config.playtimeOffset;

  double? experienceFactor(_Row row) {
    if (!prioritizeExperience && !prioritizeInexperience) return 1;
    final own = minutesOf(row.attendee.playerId, row.position);
    var total = 0.0;
    for (final position in PlayerPosition.values) {
      total += minutesOf(row.attendee.playerId, position);
    }
    if (total == 0) return null;
    final scale = config.experienceMinutes;
    var factor = 1.0;
    if (prioritizeExperience) {
      factor *= (scale + own) / scale * (total + own) / total;
    }
    if (prioritizeInexperience) {
      factor *= scale / (own + scale) * total / (total + own);
    }
    return factor;
  }

  double contribution(double rating, double participation) =>
      rating *
      participation *
      fatigueFactor(config.gameMinutes * participation, ratingConfig);

  final picks = <_Pick>[];
  final strength = {for (final team in teams) team.name: 0.0};
  final strengthByPosition = {
    for (final team in teams) team.name: <PlayerPosition, double>{},
  };
  // Scores van de vorige stap; `null` = geen score (telt nergens mee).
  var previousScores = <_Row, double?>{};

  for (var step = 1; step <= attendees.length; step++) {
    final first = step == 1;

    // Vrije plaatsen per ploeg en positie.
    int free(TeamSetup team, PlayerPosition position) =>
        team.capacity(position) -
        picks
            .where((p) => p.row.position == position && p.team == team.name)
            .length;
    int freeAll(PlayerPosition position) =>
        teams.fold(0, (sum, team) => sum + free(team, position));

    // Vrije plaatsen die niet nodig zijn voor een nog niet gekozen speler die
    // vast op deze positie in deze ploeg staat ([self] telt zichzelf niet mee).
    final pickedIds = {for (final pick in picks) pick.row.attendee.playerId};
    int open(TeamSetup team, PlayerPosition position, {Attendee? self}) =>
        free(team, position) -
        attendees
            .where(
              (a) =>
                  a != self &&
                  a.fixedPosition == position &&
                  a.fixedTeam == team.name &&
                  !pickedIds.contains(a.playerId),
            )
            .length;

    bool isCandidate(_Row row) {
      if (first) return true;
      final score = previousScores[row];
      return score != null && score > config.candidateCutoff;
    }

    // Drempel per positie: gemiddelde min standaardafwijking van de ratings
    // van wie nog kandidaat is.
    final threshold = <PlayerPosition, double>{};
    final requestors = <PlayerPosition, int>{};
    final lastPicked = picks.isEmpty ? null : picks.last.row.attendee.playerId;
    for (final position in positions) {
      final rated = rows
          .where(
            (row) =>
                row.position == position && row.rating != 0 && isCandidate(row),
          )
          .toList();
      requestors[position] = rated.where((row) => row.rating > 0).length;
      final all = [for (final row in rated) row.rating];
      if (first) {
        // SHEET-S1: in de eerste stap geeft één enkele kandidaat een fout in
        // de standaardafwijking en dus een geblokkeerde positie.
        final deviation = _sampleDeviation(all);
        threshold[position] = deviation == null
            ? config.blockedThreshold
            : _mean(all) - deviation;
        continue;
      }
      if (freeAll(position) <= 0) {
        threshold[position] = config.blockedThreshold;
        continue;
      }
      // SHEET-S2: het gemiddelde laat de zopas gekozen speler weg, de
      // standaardafwijking niet.
      final withoutLast = [
        for (final row in rated)
          if (row.attendee.playerId != lastPicked) row.rating,
      ];
      threshold[position] = withoutLast.isEmpty
          ? config.blockedThreshold
          : _mean(withoutLast) - (_sampleDeviation(all) ?? 0);
    }

    // Zwakste ploeg met een vrije plaats, per positie.
    final order = {for (final (index, team) in teams.indexed) team.name: index};
    final ranked = [...teams]
      ..sort((a, b) {
        final byStrength = strength[a.name]!.compareTo(strength[b.name]!);
        return byStrength != 0 ? byStrength : order[a.name]! - order[b.name]!;
      });
    final preferred = <PlayerPosition, TeamSetup?>{
      for (final position in positions)
        position: ranked.where((team) => open(team, position) > 0).firstOrNull,
    };

    final scores = <_Row, double?>{};
    _Row? best;
    double? bestScore;
    for (final row in rows) {
      final attendee = row.attendee;
      if (pickedIds.contains(attendee.playerId)) {
        scores[row] = null;
        continue;
      }
      final position = row.position;
      final fixedTeam = attendee.fixedTeam == null
          ? null
          : teamByName[attendee.fixedTeam];
      final team = attendee.fixedTeam == null ? preferred[position] : fixedTeam;
      final participation = team?.participation(position) ?? 0;
      final factor = experienceFactor(row);
      final full =
          fixedTeam != null && open(fixedTeam, position, self: attendee) <= 0;
      if (participation == 0 || factor == null || full) {
        scores[row] = null;
        continue;
      }
      var score = contribution(
        row.rating - threshold[position]!,
        participation,
      );
      if (row.rating == 0) {
        score -= config.noRatingPenalty;
      } else if (freeAll(position) >=
          requestors[position]! - config.scarcePositionMargin) {
        score += config.scarcePositionBonus;
      }
      if (attendee.fixedPosition == null) {
        // Plaatsen die nodig zijn voor spelers die vast op deze positie staan
        // en nog niet gekozen zijn.
        final fixedPicked = picks
            .where(
              (p) =>
                  p.row.attendee.fixedPosition == position &&
                  (fixedTeam == null ||
                      p.row.attendee.fixedTeam == fixedTeam.name),
            )
            .length;
        final open =
            (fixedTeam == null
                ? freeAll(position)
                : free(fixedTeam, position)) -
            fixedCount[position]! +
            fixedPicked;
        if (open <= 0) score -= config.reservedSlotPenalty;
      }
      score *= factor;
      scores[row] = score;
      if (bestScore == null || score > bestScore) {
        best = row;
        bestScore = score;
      }
    }
    if (best == null) break;

    final attendee = best.attendee;
    final position = attendee.fixedPosition ?? best.position;
    final team = attendee.fixedTeam == null
        ? preferred[position]
        : teamByName[attendee.fixedTeam];
    if (team != null) {
      final added = contribution(best.rating, team.participation(position));
      strength[team.name] = strength[team.name]! + added;
      final byPosition = strengthByPosition[team.name]!;
      byPosition[position] = (byPosition[position] ?? 0) + added;
    }
    picks.add(
      _Pick(row: best, position: position, team: team?.name, score: bestScore!),
    );
    previousScores = scores;
  }

  // De eerste spelers op een positie zijn basis, de volgende wissels.
  final base = {for (final team in teams) team.name: <LineupEntry>[]};
  final subs = {for (final team in teams) team.name: <LineupEntry>[]};
  final sequence = <(String, PlayerPosition), int>{};
  final result = <SchedulerPick>[];
  for (final (index, pick) in picks.indexed) {
    final team = pick.team == null ? null : teamByName[pick.team];
    var substitute = false;
    var placed = false;
    if (team != null) {
      final key = (team.name, pick.position);
      final number = sequence[key] = (sequence[key] ?? 0) + 1;
      final entry = LineupEntry(
        playerId: pick.row.attendee.playerId,
        position: pick.position,
      );
      if (number <= team.baseCount(pick.position)) {
        base[team.name]!.add(entry);
        placed = true;
      } else if (number <= team.capacity(pick.position)) {
        subs[team.name]!.add(entry);
        substitute = true;
        placed = true;
      }
    }
    result.add(
      SchedulerPick(
        step: index + 1,
        playerId: pick.row.attendee.playerId,
        ratedPosition: pick.row.position,
        position: pick.position,
        team: placed ? pick.team : null,
        rating: pick.row.rating,
        score: pick.score,
        substitute: substitute,
        placed: placed,
      ),
    );
  }
  final placedIds = {
    for (final pick in result)
      if (pick.placed) pick.playerId,
  };

  return ScheduleResult(
    teams: [
      for (final team in teams)
        ScheduledTeam(
          setup: team,
          base: base[team.name]!,
          subs: subs[team.name]!,
          strengthByPosition: strengthByPosition[team.name]!,
        ),
    ],
    picks: result,
    unassigned: [
      for (final attendee in attendees)
        if (!placedIds.contains(attendee.playerId)) attendee.playerId,
    ],
  );
}

/// Kans (0..1) dat [team] wint van [other].
double winChance(
  ScheduledTeam team,
  ScheduledTeam other,
  RatingConfig config,
) => expectedResult(team.rating(config), other.rating(config), config);

/// Voordeel van [team] op [other] op één positie, van -1 tot 1 (0 = gelijk).
double positionAdvantage(
  ScheduledTeam team,
  ScheduledTeam other,
  PlayerPosition position,
  RatingConfig config,
) {
  final own =
      (team.strengthByPosition[position] ?? 0) / config.teamRatingDivisor;
  final theirs =
      (other.strengthByPosition[position] ?? 0) / config.teamRatingDivisor;
  return expectedResult(own, theirs, config) * 2 - 1;
}

/// Verwacht aantal doelpunten van [team] tegen [other]: het gemiddelde aantal
/// doelpunten per minuut in de wedstrijden van de ingedeelde spelers, maal de
/// speeltijd en de winstkans. `null` zonder ingedeelde spelers.
double? expectedGoals({
  required ScheduleResult schedule,
  required ScheduledTeam team,
  required ScheduledTeam other,
  required Map<RatingKey, PositionStats> stats,
  SchedulerConfig config = const SchedulerConfig(),
  RatingConfig ratingConfig = const RatingConfig(),
}) {
  final rates = <double>[];
  for (final pick in schedule.picks) {
    final stat =
        stats[(playerId: pick.playerId, position: pick.ratedPosition)] ??
        const PositionStats();
    final minutes = stat.minutes + config.playtimeOffset;
    if (minutes == 0) continue;
    rates.add((stat.goalsFor + stat.goalsAgainst) / minutes);
  }
  if (rates.isEmpty) return null;
  return _mean(rates) *
      config.gameMinutes *
      winChance(team, other, ratingConfig);
}

class _Row {
  _Row({required this.attendee, required this.position, required this.rating});

  final Attendee attendee;
  final PlayerPosition position;
  final double rating;
}

class _Pick {
  _Pick({
    required this.row,
    required this.position,
    required this.team,
    required this.score,
  });

  final _Row row;
  final PlayerPosition position;
  final String? team;
  final double score;
}

double _mean(List<double> values) =>
    values.fold(0.0, (a, b) => a + b) / values.length;

/// Standaardafwijking van een steekproef; `null` bij minder dan twee waarden.
double? _sampleDeviation(List<double> values) {
  if (values.length < 2) return null;
  final mean = _mean(values);
  var sum = 0.0;
  for (final value in values) {
    sum += (value - mean) * (value - mean);
  }
  return math.sqrt(sum / (values.length - 1));
}
