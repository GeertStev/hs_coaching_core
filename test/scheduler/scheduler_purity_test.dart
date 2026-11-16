import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// De Team scheduler in core is pure Dart: de rekenregels moeten zonder
/// Flutter, Firebase en de systeemklok draaien.
void main() {
  test(
    'lib/scheduler: geen Flutter- of Firebase-imports, geen DateTime.now',
    () {
      final files = Directory('lib/scheduler')
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.endsWith('.dart'));
      expect(files, isNotEmpty);
      final forbidden = [
        RegExp(r'''import\s+['"]package:flutter'''),
        RegExp(r'''import\s+['"]package:(firebase_|cloud_)'''),
        RegExp(r'DateTime\.now\('),
      ];
      for (final file in files) {
        final source = file.readAsStringSync();
        for (final pattern in forbidden) {
          expect(
            pattern.hasMatch(source),
            isFalse,
            reason: '${file.path} matches ${pattern.pattern}',
          );
        }
      }
    },
  );
}
