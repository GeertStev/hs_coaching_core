import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/scheduler/rating_config.dart';
import 'package:hs_coaching_core/scheduler/scheduler_models.dart';
import 'package:hs_coaching_core/scheduler/sheet_import.dart';

void main() {
  test('speler: JSON heen en terug, startrating per positiecode', () {
    const player = SquadPlayer(
      firstName: 'Test',
      nickname: 'T',
      positions: [PlayerPosition.forward, PlayerPosition.wing],
      startRatings: {PlayerPosition.forward: 1500, PlayerPosition.wing: 1200},
    );
    final json =
        jsonDecode(jsonEncode(player.toJson())) as Map<String, dynamic>;
    expect(json['startRatings'], {'F': 1500, 'W': 1200});
    expect(json['positions'], ['F', 'W']);
    expect(SquadPlayer.fromJson(json), player);
    expect(player.displayName, 'T');
    expect(player.copyWith(nickname: '').displayName, 'Test');
  });

  test('wedstrijd: JSON heen en terug met geneste opstelling', () {
    const game = PracticeGame(
      date: '2026-08-27',
      durationMinutes: 30,
      white: GameSide(
        composition: '2-3-1',
        score: 8,
        base: [LineupEntry(playerId: '001', position: PlayerPosition.goalie)],
        subs: [LineupEntry(playerId: '002', position: PlayerPosition.center)],
      ),
      black: GameSide(score: 2),
    );
    final json = jsonDecode(jsonEncode(game.toJson())) as Map<String, dynamic>;
    expect(PracticeGame.fromJson(json), game);
    expect(game.white.entries, hasLength(2));
  });

  test('aanpassing en rekenregels: JSON heen en terug', () {
    const adjustment = RatingAdjustment(
      playerId: '016',
      type: RatingAdjustmentType.linear,
      start: '2024-08-21',
      end: '2025-08-21',
      change: 400,
    );
    expect(
      RatingAdjustment.fromJson(
        jsonDecode(jsonEncode(adjustment.toJson())) as Map<String, dynamic>,
      ),
      adjustment,
    );

    const config = RatingConfig(timelineStart: '2022-02-01');
    final decoded = RatingConfig.fromJson(
      jsonDecode(jsonEncode(config.toJson())) as Map<String, dynamic>,
    );
    expect(decoded, config);
    expect(decoded.rankTiers, hasLength(31));
  });

  test('import: weigert een onbekende versie en een onbekende positie', () {
    expect(
      () => parseSheetExport({'schemaVersion': 2}),
      throwsA(isA<SheetImportException>()),
    );
    expect(
      () => parseSheetExport({
        'schemaVersion': 1,
        'players': [
          {
            'index': '001',
            'positions': ['X'],
          },
        ],
      }),
      throwsA(isA<SheetImportException>()),
    );
  });
}
