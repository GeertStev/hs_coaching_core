import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hs_coaching_core/training/training.dart';
import 'package:hs_coaching_core/training/training_validation.dart';

/// Read-only base for the `clubs/{clubId}/displays/{displayId}/settings/training`
/// document — one current training per display, edited in place (same shape
/// as `Tabata`/`Chrono`'s singleton config), not a collection. `hs_coaching_screen`
/// uses this directly (it never writes) to drive its own read-only session
/// ticking (`TrainingScreenController`, mirrors `TabataScreenController` but
/// holds still on untimed steps — see `training.dart`'s doc comment);
/// `hs_coaching_app` extends it to add the card-builder's writes plus
/// session control (`start`/`pause`/`next`/`previous`/`reset`).
class DisplayTrainingRepository {
  DisplayTrainingRepository({
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

  /// Reference to the 'training' settings document for a specific display.
  /// Path: /clubs/{clubId}/displays/{displayDeviceId}/settings/training
  @protected
  DocumentReference get trainingSettingsRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('settings')
        .doc('training');
  }

  /// Returns a stream of the current training state. Logs (doesn't throw)
  /// if the document violates the max-depth-3 invariant — a defensive
  /// check against a manual edit or a future bug producing a tree deeper
  /// than any writer's UI should ever permit; see `training_validation.dart`.
  Stream<Training> watchTraining() {
    return trainingSettingsRef.snapshots().map((snapshot) {
      if (!snapshot.exists || snapshot.data() == null) {
        return const Training();
      }
      final training = Training.fromJson(
        snapshot.data() as Map<String, dynamic>,
      );
      if (!isValidTrainingTree(training)) {
        debugPrint(
          '[DisplayTrainingRepository] settings/training bij '
          'clubs/$clubId/displays/$displayId overschrijdt de max-diepte-3 '
          'invariant.',
        );
      }
      return training;
    });
  }
}
