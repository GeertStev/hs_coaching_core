import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/chrono/chrono.dart';
import 'package:hs_coaching_core/chrono/chrono_laps.dart';

void main() {
  group('Chrono json', () {
    test('oud document met int-laps wordt genegeerd', () {
      final chrono = Chrono.fromJson({
        'status': 'paused',
        'accumulatedElapsedMillis': 5000,
        'laps': [1000, 2000],
      });
      expect(chrono.status, ChronoStatus.paused);
      expect(chrono.lapTimes, isEmpty);
    });

    test('toJson is jsonEncode-baar en leest terug', () {
      const chrono = Chrono(
        lapTimes: [
          ChronoLap(elapsedMillis: 1000),
          ChronoLap(elapsedMillis: 1500, lane: 3),
        ],
      );
      final decoded = Chrono.fromJson(
        jsonDecode(jsonEncode(chrono.toJson())) as Map<String, dynamic>,
      );
      expect(decoded, chrono);
    });
  });

  group('chronoElapsedMillisAt', () {
    test('gestopt of gepauzeerd geeft de opgebouwde tijd', () {
      const chrono = Chrono(
        status: ChronoStatus.paused,
        authoritativeStartTimeMillis: 100,
        accumulatedElapsedMillis: 4000,
      );
      expect(chronoElapsedMillisAt(chrono, 99999), 4000);
    });

    test('lopend telt de tijd sinds de start erbij', () {
      const chrono = Chrono(
        status: ChronoStatus.running,
        authoritativeStartTimeMillis: 10000,
        accumulatedElapsedMillis: 4000,
      );
      expect(chronoElapsedMillisAt(chrono, 12500), 6500);
    });

    test('negatief tijdens de countdown', () {
      const chrono = Chrono(
        status: ChronoStatus.running,
        authoritativeStartTimeMillis: 10000,
      );
      expect(chronoElapsedMillisAt(chrono, 7000), -3000);
    });
  });

  group('chronoLapRows', () {
    test('sorteert op tijd en telt per baan apart', () {
      final rows = chronoLapRows(const [
        ChronoLap(elapsedMillis: 30000, lane: 1),
        ChronoLap(elapsedMillis: 10000),
        ChronoLap(elapsedMillis: 20000, lane: 2),
        ChronoLap(elapsedMillis: 25000),
        ChronoLap(elapsedMillis: 12000, lane: 1),
      ]);
      expect(rows, const [
        ChronoLapRow(
          lane: null,
          number: 1,
          splitMillis: 10000,
          totalMillis: 10000,
        ),
        ChronoLapRow(
          lane: 1,
          number: 1,
          splitMillis: 12000,
          totalMillis: 12000,
        ),
        ChronoLapRow(
          lane: 2,
          number: 1,
          splitMillis: 20000,
          totalMillis: 20000,
        ),
        ChronoLapRow(
          lane: null,
          number: 2,
          splitMillis: 15000,
          totalMillis: 25000,
        ),
        ChronoLapRow(
          lane: 1,
          number: 2,
          splitMillis: 18000,
          totalMillis: 30000,
        ),
      ]);
    });

    test('scherm toont de laatste 8', () {
      final laps = [
        for (var i = 1; i <= 10; i++) ChronoLap(elapsedMillis: i * 1000),
      ];
      final rows = visibleChronoLapRows(laps);
      expect(rows, hasLength(chronoVisibleLapCount));
      expect(rows.first.number, 3);
      expect(rows.last.number, 10);
    });
  });

  group('isLapAccepted', () {
    const chrono = Chrono(lapTimes: [ChronoLap(elapsedMillis: 5000, lane: 2)]);

    test('dubbele druk op dezelfde baan binnen 1 s telt niet', () {
      expect(isLapAccepted(chrono, 2, 5800), isFalse);
    });

    test('andere baan, later of Lap-knop telt wel', () {
      expect(isLapAccepted(chrono, 3, 5100), isTrue);
      expect(isLapAccepted(chrono, 2, 6000), isTrue);
      expect(isLapAccepted(chrono, null, 5100), isTrue);
    });

    test('na maxLaps telt die baan niet meer, andere banen wel', () {
      final full = chrono.copyWith(maxLaps: 1);
      expect(isLapAccepted(full, 2, 20000), isFalse);
      expect(isLapAccepted(full, 3, 20000), isTrue);
      expect(isLapAccepted(full, null, 20000), isTrue);
    });
  });

  test('met maxLaps is de laatste lap de finale', () {
    final rows = chronoLapRows(const [
      ChronoLap(elapsedMillis: 1000, lane: 1),
      ChronoLap(elapsedMillis: 3000, lane: 1),
    ], maxLaps: 2);
    expect(rows.map((r) => r.isFinal), [false, true]);
  });

  test('chronoLapLabel', () {
    const final3 = ChronoLapRow(
      lane: 3,
      number: 4,
      splitMillis: 0,
      totalMillis: 0,
      isFinal: true,
    );
    expect(chronoLapLabel(final3, maxLaps: 4), 'Lane 3 · Final');
    ChronoLapRow row(int? lane, int number) => ChronoLapRow(
      lane: lane,
      number: number,
      splitMillis: 0,
      totalMillis: 0,
    );
    expect(chronoLapLabel(row(null, 2)), 'Lap 2');
    expect(chronoLapLabel(row(3, 1)), 'Lane 3');
    expect(chronoLapLabel(row(3, 2)), 'Lane 3 · Lap 2');
    expect(chronoLapLabel(row(3, 1), maxLaps: 4), 'Lane 3 · 1/4');
    expect(chronoLapLabel(row(null, 2), maxLaps: 4), 'Lap 2/4');
  });
}
