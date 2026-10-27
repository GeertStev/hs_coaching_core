import 'package:hs_coaching_core/chrono/chrono.dart';

/// Aantal tijden dat het poolscherm toont (twee kolommen van vier).
const int chronoVisibleLapCount = 8;

/// Een tweede druk op dezelfde baanknop binnen deze tijd telt niet
/// (denderende knop of dubbele druk).
const int laneBounceMillis = 1000;

/// Verstreken chrono-tijd op [nowServerMillis] (RTDB-serverklok). Negatief
/// tijdens de countdown voor de start.
int chronoElapsedMillisAt(Chrono chrono, int nowServerMillis) {
  if (chrono.status != ChronoStatus.running) {
    return chrono.accumulatedElapsedMillis;
  }
  final sinceStart = nowServerMillis - chrono.authoritativeStartTimeMillis;
  if (sinceStart < 0) return sinceStart;
  return chrono.accumulatedElapsedMillis + sinceStart;
}

/// Een tijd zoals beide apps hem tonen.
class ChronoLapRow {
  const ChronoLapRow({
    required this.lane,
    required this.number,
    required this.splitMillis,
    required this.totalMillis,
    this.isFinal = false,
  });

  /// Null voor de Lap-knop.
  final int? lane;

  /// Volgnummer binnen dezelfde baan (of binnen de Lap-knop-tijden).
  final int number;

  /// Tijd sinds de vorige druk van dezelfde baan (of vorige Lap), of sinds
  /// de start voor de eerste.
  final int splitMillis;

  /// Totale chrono-tijd op het moment van de druk.
  final int totalMillis;

  /// De laatste lap volgens `Chrono.maxLaps`: de finale tijd.
  final bool isFinal;

  @override
  bool operator ==(Object other) =>
      other is ChronoLapRow &&
      other.lane == lane &&
      other.number == number &&
      other.splitMillis == splitMillis &&
      other.totalMillis == totalMillis &&
      other.isFinal == isFinal;

  @override
  int get hashCode =>
      Object.hash(lane, number, splitMillis, totalMillis, isFinal);
}

/// Zet de opgenomen tijden om naar rijen, gesorteerd op tijd. Elke baan
/// (en de Lap-knop als geheel) telt zijn eigen rondes. Met [maxLaps] is lap
/// nummer [maxLaps] de finale tijd.
List<ChronoLapRow> chronoLapRows(List<ChronoLap> laps, {int? maxLaps}) {
  final sorted = [...laps]
    ..sort((a, b) => a.elapsedMillis.compareTo(b.elapsedMillis));
  final previous = <int?, int>{};
  final counts = <int?, int>{};
  final rows = <ChronoLapRow>[];
  for (final lap in sorted) {
    final number = (counts[lap.lane] ?? 0) + 1;
    rows.add(
      ChronoLapRow(
        lane: lap.lane,
        number: number,
        splitMillis: lap.elapsedMillis - (previous[lap.lane] ?? 0),
        totalMillis: lap.elapsedMillis,
        isFinal: number == maxLaps,
      ),
    );
    counts[lap.lane] = number;
    previous[lap.lane] = lap.elapsedMillis;
  }
  return rows;
}

/// De laatste [chronoVisibleLapCount] rijen, oudste eerst.
List<ChronoLapRow> visibleChronoLapRows(List<ChronoLap> laps, {int? maxLaps}) {
  final rows = chronoLapRows(laps, maxLaps: maxLaps);
  if (rows.length <= chronoVisibleLapCount) return rows;
  return rows.sublist(rows.length - chronoVisibleLapCount);
}

/// Of een druk op [lane] (null = Lap-knop) op [elapsedMillis] als nieuwe tijd
/// telt: niet als die baan zijn `maxLaps` al heeft, en voor een baanknop niet
/// binnen [laneBounceMillis] na een eerdere druk op dezelfde baan (extra
/// beveiliging; de ESP32 vangt denderen normaal zelf al op).
bool isLapAccepted(Chrono chrono, int? lane, int elapsedMillis) {
  final sameLane = chrono.lapTimes.where((lap) => lap.lane == lane);
  final maxLaps = chrono.maxLaps;
  if (maxLaps != null && sameLane.length >= maxLaps) return false;
  if (lane == null) return true;
  return sameLane.every(
    (lap) => (elapsedMillis - lap.elapsedMillis).abs() >= laneBounceMillis,
  );
}

/// Of alle tijden binnen zijn met `maxLaps`: elke baan (en de Lap-knop) die
/// al een tijd heeft, heeft zijn finale tijd. Dan stopt de app de chrono.
/// Banen zonder enige tijd zwemmen niet mee en tellen niet. Zonder maximum
/// of zonder tijden: false.
bool isChronoFinished(Chrono chrono) {
  final maxLaps = chrono.maxLaps;
  if (maxLaps == null || chrono.lapTimes.isEmpty) return false;
  final counts = <int?, int>{};
  for (final lap in chrono.lapTimes) {
    counts[lap.lane] = (counts[lap.lane] ?? 0) + 1;
  }
  return counts.values.every((count) => count >= maxLaps);
}

/// Label voor een rij, zelfde in app en scherm. Zonder maximum: "Lap 2",
/// "Lane 3", "Lane 3 · Lap 2". Met maximum 4: "Lap 2/4", "Lane 3 · 2/4",
/// en "Final" / "Lane 3 · Final" voor de laatste.
String chronoLapLabel(ChronoLapRow row, {int? maxLaps}) {
  final lane = row.lane;
  final String lap;
  if (row.isFinal) {
    lap = 'Final';
  } else if (maxLaps != null) {
    lap = lane == null
        ? 'Lap ${row.number}/$maxLaps'
        : '${row.number}/$maxLaps';
  } else {
    lap = 'Lap ${row.number}';
  }
  if (lane == null) return lap;
  if (maxLaps == null && row.number == 1) return 'Lane $lane';
  return 'Lane $lane · $lap';
}
