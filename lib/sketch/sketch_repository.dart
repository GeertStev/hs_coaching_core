import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hs_coaching_core/sketch/sketch.dart';
import 'package:hs_coaching_core/sketch/sketch_element.dart';

/// Read-only base for the `clubs/{clubId}/displays/{displayId}/sketches`
/// subtree. Each app's writable `SketchRepository` extends this, adding its
/// own create/update/archive/background/tag methods.
class DisplaySketchRepositoryBase {
  DisplaySketchRepositoryBase({
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

  @protected
  CollectionReference<Sketch> get sketchesRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('sketches')
        .withConverter<Sketch>(
          fromFirestore: (snapshot, _) =>
              Sketch.fromJson(_normalizeLegacyName(snapshot.data()!))
                  .copyWith(id: snapshot.id),
          toFirestore: (sketch, _) => sketch.toJson(),
        );
  }

  /// Older documents stored the title under `name` instead of `title`.
  static Map<String, dynamic> _normalizeLegacyName(Map<String, dynamic> data) {
    if (data['title'] != null || data['name'] == null) return data;
    return {...data, 'title': data['name']};
  }

  @protected
  DocumentReference get currentSketchSettingsRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('settings')
        .doc('sketch');
  }

  @protected
  CollectionReference<SketchElement> elementsRef(String sketchId) {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('sketches')
        .doc(sketchId)
        .collection('elements')
        .withConverter<SketchElement>(
          fromFirestore: (snapshot, _) =>
              SketchElement.fromJson(snapshot.data()!),
          toFirestore: (element, _) => element.toJson(),
        );
  }

  Stream<List<SketchElement>> watchSketchElements(String sketchId) {
    return elementsRef(
      sketchId,
    ).snapshots().map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Streams the ID of the active sketch (`currentId`), or null if none.
  Stream<String?> watchCurrentSketchId() {
    return currentSketchSettingsRef.snapshots().map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>?;
      return data?['currentId'] as String?;
    });
  }

  Stream<Sketch?> watchSketch(String sketchId) {
    return sketchesRef
        .doc(sketchId)
        .snapshots()
        .map((snapshot) => snapshot.data());
  }
}
