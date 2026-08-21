/// De fase waarin de tabata-timer zich bevindt op een bepaald moment.
/// [restBetweenSets] is de rust tussen twee sets (geen rust ná de laatste set).
enum TabataPhase { prepare, work, rest, restBetweenSets, finished }

/// Afgeleide, berekende voortgang van een [Tabata] op een gegeven verstreken
/// tijd. Bevat geen Firestore-state; wordt lokaal berekend (zowel in de
/// control app als in de display app) zodat er tijdens het lopen geen
/// netwerk-writes nodig zijn.
///
/// [round]/[totalRounds] en [set]/[totalSets] zijn elk precies één, nooit
/// samengevoegd getal per as — dit voorkomt de oude bug waarbij twee
/// onafhankelijke herhalings-tellers (groep × oefening) nooit tot één
/// gebruikersgerichte teller werden gecombineerd.
class TabataProgress {
  const TabataProgress({
    required this.phase,
    required this.round,
    required this.totalRounds,
    required this.set,
    required this.totalSets,
    required this.phaseRemaining,
    required this.phaseTotal,
    required this.elapsed,
    required this.totalRemaining,
  });

  final TabataPhase phase;

  /// 1-gebaseerd rondenummer binnen de huidige set. Tijdens
  /// [TabataPhase.restBetweenSets] wijst dit al naar ronde 1 van de volgende
  /// set, zodat het scherm toont waarvoor er gerust wordt.
  final int round;
  final int totalRounds;

  /// 1-gebaseerd setnummer.
  final int set;
  final int totalSets;

  /// Resterende tijd binnen de huidige fase.
  final Duration phaseRemaining;

  /// Totale duur van de huidige fase (voor de progress-ring).
  final Duration phaseTotal;

  /// Totaal verstreken tijd sinds de start van de voorbereiding.
  final Duration elapsed;

  /// Resterende tijd tot het einde van de laatste werkronde.
  final Duration totalRemaining;

  /// Fractie 0..1 van de huidige fase die nog resteert (voor de ring).
  double get phaseRemainingFraction => phaseTotal.inMilliseconds <= 0
      ? 0
      : (phaseRemaining.inMilliseconds / phaseTotal.inMilliseconds).clamp(0, 1);
}
