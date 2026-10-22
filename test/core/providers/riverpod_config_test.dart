import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/core/providers/riverpod_config.dart';

void main() {
  test('permanente Firebase-fouten worden nooit herhaald', () {
    final error =
        FirebaseException(plugin: 'cloud_firestore', code: 'permission-denied');
    expect(appProviderRetry(0, error), isNull);
  });

  test('andere fouten: exponentiële backoff, maximaal 5 keer', () {
    final error = Exception('tijdelijk');
    expect(appProviderRetry(0, error), const Duration(milliseconds: 200));
    expect(appProviderRetry(3, error), const Duration(milliseconds: 1600));
    expect(appProviderRetry(5, error), isNull);
  });
}
