import 'dart:async';

import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:http/http.dart' as http;

/// Fout met een melding die al geschikt is om aan de gebruiker te tonen.
/// Eigen domeinfouten (in core of in een app) implementeren dit, zodat
/// [userMessage] hun tekst ongewijzigd doorgeeft.
abstract interface class UserFacingException implements Exception {
  String get message;
}

/// Vertaalt een willekeurige fout naar een korte, begrijpelijke Engelse
/// melding voor de UI, zonder technische details te lekken. Beide apps
/// gebruiken dit als enige bron voor foutteksten; feature-specifieke
/// vertalingen (bv. login) vallen hierop terug voor wat ze niet kennen.
String userMessage(Object? error) {
  if (error is UserFacingException) return error.message;
  if (error is FirebaseException) return _firebaseMessage(error.code);
  if (error is TimeoutException || error is http.ClientException) {
    return _networkMessage;
  }
  if (error is FormatException) {
    return 'The data has an unexpected format. Try updating the app.';
  }
  return _genericMessage;
}

const _networkMessage =
    'Could not reach the server. Check the internet connection.';
const _genericMessage = 'Something went wrong. Please try again.';

String _firebaseMessage(String code) {
  switch (code) {
    case 'permission-denied':
      return "You don't have permission to do this.";
    case 'unauthenticated':
      return 'You are not signed in.';
    case 'not-found':
      return 'This item no longer exists.';
    case 'failed-precondition':
      // Meestal een ontbrekende Firestore-index; de aanmaaklink staat in de
      // debug-console (zie AppProviderObserver).
      return 'The database is not set up for this request yet.';
    case 'unavailable':
    case 'deadline-exceeded':
    case 'network-request-failed':
      return _networkMessage;
    case 'resource-exhausted':
    case 'too-many-requests':
      return 'Too many requests. Please try again later.';
    case 'canceled':
    case 'cancelled':
      return 'The action was cancelled.';
    default:
      return _genericMessage;
  }
}
