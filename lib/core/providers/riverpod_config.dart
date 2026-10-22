import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hs_coaching_core/core/errors/error_reporting.dart';

/// Firebase-foutcodes die permanent zijn: opnieuw proberen heeft geen zin
/// (bv. ontbrekende index of geweigerde toegang). Zonder deze uitzondering
/// blijft Riverpod 3 een falende provider automatisch herhalen, waardoor de
/// UI eindeloos tussen laden en fout flikkert en de echte foutmelding
/// onzichtbaar blijft.
const _permanentFirebaseCodes = {
  'permission-denied',
  'failed-precondition', // o.a. ontbrekende Firestore-index
  'unauthenticated',
  'invalid-argument',
  'not-found',
  'unimplemented',
};

/// Retry-beleid voor alle providers (via [ProviderScope.retry]) in beide
/// apps: permanente Firebase-fouten nooit herhalen, andere fouten maximaal
/// 5 keer met exponentiële backoff.
Duration? appProviderRetry(int retryCount, Object error) {
  if (error is FirebaseException &&
      _permanentFirebaseCodes.contains(error.code)) {
    return null;
  }
  if (retryCount >= 5) return null;
  return Duration(milliseconds: 200 * (1 << retryCount));
}

/// Meldt provider-fouten via [reportError], zodat bv. de "index
/// ontbreekt"-melding van Firestore (met aanmaaklink) zichtbaar is.
/// Registreer op de `ProviderScope` van beide apps.
final class AppProviderObserver extends ProviderObserver {
  const AppProviderObserver();

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    reportError(
      error,
      stackTrace,
      context:
          'Provider ${context.provider.name ?? context.provider.runtimeType}',
    );
  }
}
