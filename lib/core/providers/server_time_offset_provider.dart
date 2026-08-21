import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hs_coaching_core/core/providers/firebase_database_provider.dart';

/// Streams the millisecond offset between this device's clock and the RTDB
/// server clock, continuously updated by the SDK via the special
/// `.info/serverTimeOffset` path for as long as the connection is open.
///
/// Unlike a one-shot calibration taken from a single write's server
/// timestamp, this value keeps re-emitting as the connection detects drift
/// or reconnects, so consumers never need to re-derive it themselves.
final serverTimeOffsetProvider = StreamProvider<double>((ref) {
  final database = ref.watch(firebaseDatabaseProvider);
  return database
      .ref('.info/serverTimeOffset')
      .onValue
      .map((event) => (event.snapshot.value as num?)?.toDouble() ?? 0);
});

/// The current time expressed in RTDB server-clock milliseconds, given the
/// offset from [serverTimeOffsetProvider].
int serverNowMillis(double offsetMillis) {
  return DateTime.now().millisecondsSinceEpoch + offsetMillis.round();
}
