import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hs_coaching_core/core/providers/firebase_database_provider.dart';

/// Whether this device currently has a live connection to Firebase, via
/// RTDB's special `.info/connected` path — the same zero-footprint mechanism
/// as `serverTimeOffsetProvider` (no reads/writes/rules against the real
/// data tree, doesn't require auth, free). RTDB and Firestore share the same
/// underlying connection to Firebase, so this doubles as a reasonable proxy
/// for "this device's Firestore listeners are probably also stale" — used to
/// drive a "sync lost" indicator on the poolside display.
final serverConnectionProvider = StreamProvider<bool>((ref) {
  final database = ref.watch(firebaseDatabaseProvider);
  return database
      .ref('.info/connected')
      .onValue
      .map((event) => event.snapshot.value as bool? ?? false);
});
