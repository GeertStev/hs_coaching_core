import 'package:flutter/foundation.dart';

/// Enige plek waar fouten gemeld worden. Voorlopig alleen naar de
/// debug-console; wil je later toch crashrapportage (bv. Crashlytics of
/// Sentry), dan haak je die hier in en hoeft geen feature te veranderen.
void reportError(Object error, StackTrace? stack, {String? context}) {
  debugPrint('${context == null ? '' : '[$context] '}$error');
  if (stack != null) debugPrintStack(stackTrace: stack, maxFrames: 20);
}

/// Stuurt ongevangen fouten via [reportError]: Flutter-fouten (build,
/// layout, ...) en losse async-fouten, bv. een `Future` uit een
/// knop-handler die niemand afwacht. Roep aan in `main()` vóór `runApp`.
void installGlobalErrorHandlers() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    reportError(
      details.exception,
      details.stack,
      context: 'Flutter${details.library == null ? '' : ' (${details.library})'}',
    );
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    reportError(error, stack, context: 'Uncaught');
    return true;
  };
}
