import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/tabata/tabata_progress.dart';

part 'tabata.freezed.dart';
part 'tabata.g.dart';

enum TabataStatus { stopped, running, paused }

/// Tabata-interval timer: voorbereiding, gevolgd door [sets] sets van [rounds]
/// werkrondes van [workSeconds] met [restSeconds] rust ertussen (geen rust na
/// de laatste ronde van een set), met [restBetweenSets] rust tussen sets
/// (geen rust na de laatste set). [stepSeconds] maakt elke volgende werkronde
/// langer of korter dan de vorige (zie [workSecondsForRound]).
///
/// Bewust plat gehouden — geen genest Set/Groep/Oefening-model meer (dat zit
/// nu in de aparte "Training"-feature). Eén flat configuratie per document,
/// dus geen kaart-identiteit (`id`/`title`) meer nodig.
///
/// [prepareSeconds]..[restBetweenSets] (configuratie) en [status]/
/// [authoritativeStartTimeMillis]/[accumulatedElapsedMillis] (live-tikkende
/// runtime-status) staan samen in hetzelfde Firestore-document
/// (`settings/tabata`, via `DisplayTabataRepository`) — net als `Chrono`.
/// Klokdrift-correctie op de runtime-velden komt van RTDB's
/// `.info/serverTimeOffset` (`serverTimeOffsetProvider`/`serverNowMillis`),
/// niet van het opslaan van deze data zelf in RTDB.
@freezed
abstract class Tabata with _$Tabata {
  const Tabata._();

  const factory Tabata({
    // --- Configuratie (Firestore) ---
    @Default(10) int prepareSeconds,
    @Default(20) int workSeconds,
    @Default(10) int restSeconds,
    @Default(0) int stepSeconds,
    @Default(8) int rounds,
    @Default(1) int sets,
    @Default(0) int restBetweenSets,

    // --- Runtime status (RTDB, zelfde mechanisme als Chrono) ---
    @Default(TabataStatus.stopped) TabataStatus status,

    /// Start moment, expressed in RTDB server-clock milliseconds (see
    /// `serverNowMillis` in `core/providers/server_time_offset_provider.dart`).
    @Default(0) int authoritativeStartTimeMillis,

    /// Time accumulated before the current running session.
    @Default(0) int accumulatedElapsedMillis,
  }) = _Tabata;

  factory Tabata.fromJson(Map<String, dynamic> json) => _$TabataFromJson(json);

  /// True zolang de timer nog nooit gestart (of net gereset) is.
  bool get isIdle =>
      status == TabataStatus.stopped && accumulatedElapsedMillis == 0;

  /// Duur van werkronde [round] (1-gebaseerd), met de stap-aftrek/optelling
  /// toegepast en geklemd op minimaal 1 seconde. `0` als [workSeconds] `<= 0`
  /// (geen werk geconfigureerd).
  int workSecondsForRound(int round) {
    if (workSeconds <= 0) return 0;
    return math.max(workSeconds + (round - 1) * stepSeconds, 1);
  }

  /// Duur van één set: alle rondes + rust ertussen (zonder [restBetweenSets]).
  int get setBodyMillis {
    if (rounds <= 0) return 0;
    var total = 0;
    for (var round = 1; round <= rounds; round++) {
      total += workSecondsForRound(round) * 1000;
      if (round < rounds && restSeconds > 0) {
        total += restSeconds * 1000;
      }
    }
    return total;
  }

  /// Totale duur van de sessie: voorbereiding + alle sets + rust tussen sets
  /// (exclusief rust ná de laatste set).
  int get totalDurationMillis {
    if (sets <= 0) return prepareSeconds * 1000;
    var total = prepareSeconds * 1000 + sets * setBodyMillis;
    if (sets > 1 && restBetweenSets > 0) {
      total += (sets - 1) * restBetweenSets * 1000;
    }
    return total;
  }

  /// Berekent fase, ronde, set en resterende tijden op [elapsedMillis] sinds
  /// de start van de voorbereiding.
  TabataProgress progressAt(int elapsedMillis) {
    final totalMs = totalDurationMillis;
    final clampedElapsed = math.max(0, math.min(elapsedMillis, totalMs));
    final elapsed = Duration(milliseconds: clampedElapsed);
    final totalRemaining = Duration(milliseconds: totalMs - clampedElapsed);
    final hasWork = rounds > 0 && sets > 0 && workSeconds > 0;

    if (!hasWork || clampedElapsed >= totalMs) {
      return TabataProgress(
        phase: TabataPhase.finished,
        round: math.max(rounds, 0),
        totalRounds: math.max(rounds, 0),
        set: math.max(sets, 0),
        totalSets: math.max(sets, 0),
        phaseRemaining: Duration.zero,
        phaseTotal: Duration.zero,
        elapsed: elapsed,
        totalRemaining: Duration.zero,
      );
    }

    var t = clampedElapsed;

    final prepareMs = prepareSeconds * 1000;
    if (t < prepareMs) {
      return TabataProgress(
        phase: TabataPhase.prepare,
        round: 1,
        totalRounds: rounds,
        set: 1,
        totalSets: sets,
        phaseRemaining: Duration(milliseconds: prepareMs - t),
        phaseTotal: Duration(milliseconds: prepareMs),
        elapsed: elapsed,
        totalRemaining: totalRemaining,
      );
    }
    t -= prepareMs;

    final setBody = setBodyMillis;
    final restBetweenSetsMs = restBetweenSets * 1000;

    for (var s = 1; s <= sets; s++) {
      final isLastSet = s == sets;

      if (t < setBody) {
        var withinSet = t;
        for (var round = 1; round <= rounds; round++) {
          final workMs = workSecondsForRound(round) * 1000;
          if (withinSet < workMs) {
            return TabataProgress(
              phase: TabataPhase.work,
              round: round,
              totalRounds: rounds,
              set: s,
              totalSets: sets,
              phaseRemaining: Duration(milliseconds: workMs - withinSet),
              phaseTotal: Duration(milliseconds: workMs),
              elapsed: elapsed,
              totalRemaining: totalRemaining,
            );
          }
          withinSet -= workMs;

          final isLastRound = round == rounds;
          if (!isLastRound && restSeconds > 0) {
            final restMs = restSeconds * 1000;
            if (withinSet < restMs) {
              return TabataProgress(
                phase: TabataPhase.rest,
                round: round,
                totalRounds: rounds,
                set: s,
                totalSets: sets,
                phaseRemaining: Duration(milliseconds: restMs - withinSet),
                phaseTotal: Duration(milliseconds: restMs),
                elapsed: elapsed,
                totalRemaining: totalRemaining,
              );
            }
            withinSet -= restMs;
          }
        }
      }
      t -= setBody;

      // Rust tussen sets toont, net als de oude rust-tussen-kaarten, al de
      // context van de volgende set (contextFromNext-equivalent).
      if (!isLastSet && restBetweenSetsMs > 0) {
        if (t < restBetweenSetsMs) {
          return TabataProgress(
            phase: TabataPhase.restBetweenSets,
            round: 1,
            totalRounds: rounds,
            set: s + 1,
            totalSets: sets,
            phaseRemaining: Duration(milliseconds: restBetweenSetsMs - t),
            phaseTotal: Duration(milliseconds: restBetweenSetsMs),
            elapsed: elapsed,
            totalRemaining: totalRemaining,
          );
        }
        t -= restBetweenSetsMs;
      }
    }

    // Onbereikbaar zolang totalDurationMillis en bovenstaande wandeling
    // consistent zijn; valt terug op de klaar-toestand.
    return progressAt(totalMs);
  }
}
