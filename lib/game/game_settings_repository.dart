import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hs_coaching_core/game/game_settings.dart';

/// Read-only base for the `clubs/{clubId}/displays/{displayId}/settings/game`
/// document. `hs_coaching_screen` uses this directly (it never writes);
/// `hs_coaching_app` extends it to add score-mutating write methods.
class DisplayGameSettingsRepository {
  DisplayGameSettingsRepository({
    required FirebaseFirestore firestore,
    required String clubId,
    required String displayId,
  }) : _firestore = firestore,
       _clubId = clubId,
       _displayId = displayId;

  final FirebaseFirestore _firestore;
  final String _clubId;
  final String _displayId;

  /// Reference to the 'game' settings document for a specific display.
  /// Path: /clubs/{clubId}/displays/{displayDeviceId}/settings/game
  @protected
  DocumentReference get gameSettingsRef {
    return _firestore
        .collection('clubs')
        .doc(_clubId)
        .collection('displays')
        .doc(_displayId)
        .collection('settings')
        .doc('game');
  }

  /// Returns a stream of the current game settings.
  Stream<GameSettings> watchGameSettings() {
    return gameSettingsRef.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return const GameSettings(); // Default settings if document doesn't exist
      }
      return GameSettings.fromJson(snapshot.data() as Map<String, dynamic>);
    });
  }
}
