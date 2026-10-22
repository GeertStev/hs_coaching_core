import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hs_coaching_core/core/data/switch_map.dart';
import 'package:hs_coaching_core/image/display_image.dart';

/// Read-only base for `clubs/{clubId}/displays/{displayId}/images` and its
/// `settings/image` "currentId" document. `hs_coaching_screen` uses this
/// directly (it never writes); `hs_coaching_app` extends it to add
/// upload/archive/tag-mutating writes. Named with a `Base` suffix (unlike
/// `DisplayGameSettingsRepository`/`DisplayTabataRepository`) because
/// `hs_coaching_app`'s own writable repository was already named
/// `DisplayImageRepository` before this migration, and keeping that name
/// avoids an app-side rename.
class DisplayImageRepositoryBase {
  DisplayImageRepositoryBase({
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

  /// Reference to the 'images' collection for a specific display.
  @protected
  CollectionReference<DisplayImage> get imagesRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('images')
        .withConverter<DisplayImage>(
          fromFirestore: (snapshot, _) =>
              DisplayImage.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (image, _) => image.toJson(),
        );
  }

  /// Reference to the document that stores the active image ID.
  /// Path: `.../settings/image`
  @protected
  DocumentReference get currentImageRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('settings')
        .doc('image');
  }

  /// Streams the ID of the active image (`currentId`), or null if none.
  Stream<String?> watchCurrentImageId() {
    return currentImageRef.snapshots().map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>?;
      return data?['currentId'] as String?;
    });
  }

  /// Watches the currently active display image. Uses `switchMap` (rather
  /// than a one-shot `.get()`/`.first`) so an edit to the image while it's
  /// showing is reflected immediately, and switching `currentId` cancels the
  /// previous image's listener instead of leaving it dangling.
  Stream<DisplayImage?> watchCurrentImage() {
    return watchCurrentImageId().switchMap((currentId) {
      if (currentId == null) return Stream.value(null);
      return imagesRef.doc(currentId).snapshots().map((doc) => doc.data());
    });
  }

  /// Returns a stream of all active image documents, ordered by timestamp.
  Stream<List<DisplayImage>> watchAllActiveImages({String? tag}) {
    Query<DisplayImage> query = imagesRef.where(
      'status',
      isEqualTo: DisplayImageStatus.active.name,
    );

    if (tag != null) {
      query = query.where('tags', arrayContains: tag);
    }

    return query
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Returns a stream of the list of all used image tags.
  Stream<List<String>> watchAllImageTags() {
    return currentImageRef.snapshots().map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>?;
      return List<String>.from(data?['imageTags'] ?? []);
    });
  }
}
