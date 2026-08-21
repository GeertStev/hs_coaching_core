import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hs_coaching_core/tabata/tabata.dart';

/// Read-only base for the `clubs/{clubId}/displays/{displayId}/settings/tabata`
/// document — both configuration (`prepareSeconds`/`items`) and live
/// run-state (`status`/`authoritativeStartTimeMillis`/
/// `accumulatedElapsedMillis`) live in this one Firestore document; drift
/// correction on the run-state fields comes from RTDB's `.info/serverTimeOffset`
/// (see `core/providers/server_time_offset_provider.dart`), not from storing
/// the data itself in RTDB — same approach as `DisplayChronoRepository`.
/// `hs_coaching_screen` uses this directly (it never writes); `hs_coaching_app`
/// extends it to add config/start/pause/reset/preset writes.
class DisplayTabataRepository {
  DisplayTabataRepository({
    required this.firestore,
    required this.clubId,
    required this.displayId,
  });

  @protected
  final FirebaseFirestore firestore;
  @protected
  final String clubId;
  @protected
  final String displayId;

  /// Reference to the 'tabata' settings document for a specific display.
  /// Path: /clubs/{clubId}/displays/{displayDeviceId}/settings/tabata
  @protected
  DocumentReference get tabataSettingsRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('settings')
        .doc('tabata');
  }

  /// Returns a stream of the current tabata state.
  Stream<Tabata> watchTabata() {
    return tabataSettingsRef.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return const Tabata();
      }
      return Tabata.fromJson(snapshot.data() as Map<String, dynamic>);
    });
  }
}
