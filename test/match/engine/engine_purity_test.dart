import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Bewaakt de harde regels uit CLAUDE.md: de match engine is pure Dart, vraagt
/// zelf nooit de tijd op en bevat geen vaste speelduren.
void main() {
  // Handgeschreven bronbestanden van de engine, plus de twee bestaande
  // modellen die ze importeert.
  final sources = [
    ...Directory('lib/match/engine')
        .listSync()
        .whereType<File>()
        .where((file) => file.path.endsWith('.dart'))
        .where(
          (file) =>
              !file.path.endsWith('.g.dart') &&
              !file.path.endsWith('.freezed.dart'),
        ),
    File('lib/team/team_model.dart'),
    File('lib/team/player_model.dart'),
  ];

  String name(File file) => file.uri.pathSegments.last;

  test('de engine-map bevat bronbestanden', () {
    expect(sources.length, greaterThan(8));
  });

  test('geen imports van flutter, firebase, cloud of dart:io/dart:ui', () {
    final forbidden = RegExp(
      r'''import\s+['"](package:(flutter|firebase_|cloud_)|dart:(io|ui|html))''',
    );
    for (final file in sources) {
      expect(
        forbidden.hasMatch(file.readAsStringSync()),
        isFalse,
        reason: '${name(file)} importeert iets dat niet pure Dart is',
      );
    }
  });

  test('nergens DateTime.now(): de tijd komt altijd van de aanroeper', () {
    for (final file in sources) {
      expect(
        file.readAsStringSync().contains('DateTime.now'),
        isFalse,
        reason: name(file),
      );
    }
  });

  test('geen vaste duren buiten match_config.dart', () {
    final literal = RegExp(
      r'Duration\(\s*(days|hours|minutes|seconds|milliseconds):\s*\d',
    );
    for (final file in sources) {
      if (name(file) == 'match_config.dart') continue;
      expect(
        literal.hasMatch(file.readAsStringSync()),
        isFalse,
        reason: '${name(file)} bevat een vaste duur; gebruik MatchConfig',
      );
    }
  });
}
