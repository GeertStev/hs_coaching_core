import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/sketch/sketch_background.dart';
import 'package:hs_coaching_core/sketch/sketch_settings.dart';

void main() {
  test('leeg document geeft defaults', () {
    final settings = SketchSettings.fromJson(<String, dynamic>{});
    expect(settings.currentId, isNull);
    expect(settings.sketchTags, isEmpty);
    expect(settings.backgrounds, isEmpty);
  });

  test('leest bestaand Firestore-document met extra velden', () {
    final settings = SketchSettings.fromJson({
      'currentId': 'abc',
      'sketchTags': ['attack', 'defence'],
      'backgrounds': [
        {'title': 'Pool', 'url': 'https://example.com/pool.png'},
      ],
      'unknownField': 42,
    });
    expect(settings.currentId, 'abc');
    expect(settings.sketchTags, ['attack', 'defence']);
    expect(settings.backgrounds.single.title, 'Pool');
  });

  test('toJson is jsonEncode-baar (geneste achtergronden)', () {
    const settings = SketchSettings(
      currentId: 'abc',
      backgrounds: [SketchBackground(title: 'Pool', url: 'u')],
    );
    final decoded = SketchSettings.fromJson(
      jsonDecode(jsonEncode(settings.toJson())) as Map<String, dynamic>,
    );
    expect(decoded, settings);
  });
}
