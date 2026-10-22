import 'dart:async';

import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/core/errors/user_message.dart';
import 'package:http/http.dart' as http;

class _DomainException implements UserFacingException {
  const _DomainException(this.message);
  @override
  final String message;
}

FirebaseException _firebase(String code) =>
    FirebaseException(plugin: 'cloud_firestore', code: code);

void main() {
  test('UserFacingException geeft zijn eigen melding door', () {
    expect(userMessage(const _DomainException('Team is full.')), 'Team is full.');
  });

  test('Firebase-codes krijgen een eigen melding', () {
    expect(userMessage(_firebase('permission-denied')),
        "You don't have permission to do this.");
    expect(userMessage(_firebase('not-found')), 'This item no longer exists.');
  });

  test('netwerkfouten krijgen dezelfde melding', () {
    final network = userMessage(_firebase('unavailable'));
    expect(userMessage(TimeoutException('x')), network);
    expect(userMessage(http.ClientException('x')), network);
  });

  test('onbekende fouten lekken geen technische details', () {
    final msg = userMessage(Exception('secret stack detail'));
    expect(msg, isNot(contains('secret')));
    expect(userMessage(_firebase('some-new-code')), msg);
    expect(userMessage(null), msg);
  });
}
