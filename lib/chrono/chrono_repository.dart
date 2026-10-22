import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hs_coaching_core/chrono/chrono.dart';

/// Read-only base for the `clubs/{clubId}/displays/{displayId}/settings/chrono`
/// document. `hs_coaching_screen` uses this directly (it never writes);
/// `hs_coaching_app` extends it to add start/pause/lap/reset writes (lap
/// times from the Lap button and the lane buttons). Both apps format the
/// times with `chrono_laps.dart`.
///
/// The data lives in Firestore (same as every other content type), not RTDB —
/// RTDB's only role in this app is as a zero-footprint clock oracle (see
/// `core/providers/server_time_offset_provider.dart`); it never stores this
/// document's actual fields. Firestore also gets `firestore.rules`' proper
/// `isTrainerOrAdmin(clubId)` role check "for free" this way, rather than
/// RTDB's flatter `auth != null`-only rule.
class DisplayChronoRepository {
  DisplayChronoRepository({
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

  /// Reference to the 'chrono' settings document for a specific display.
  /// Path: /clubs/{clubId}/displays/{displayDeviceId}/settings/chrono
  @protected
  DocumentReference get chronoSettingsRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('settings')
        .doc('chrono');
  }

  /// Returns a stream of the current chrono state.
  Stream<Chrono> watchChrono() {
    return chronoSettingsRef.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) return const Chrono();
      return Chrono.fromJson(snapshot.data() as Map<String, dynamic>);
    });
  }
}
