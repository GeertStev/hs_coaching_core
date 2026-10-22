import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hs_coaching_core/core/data/switch_map.dart';
import 'package:hs_coaching_core/text/display_text.dart';

/// Read-only base for `clubs/{clubId}/displays/{displayId}/texts` and its
/// `settings/text` "currentId" document. `hs_coaching_screen` uses this
/// directly (it never writes); `hs_coaching_app` extends it to add
/// add/duplicate/archive/tag-mutating writes. Named with a `Base` suffix
/// (see the naming convention note in `hs_coaching_core` migration below)
/// because `hs_coaching_app`'s own writable repository was already named
/// `DisplayTextRepository` before this migration.
class DisplayTextRepositoryBase {
  DisplayTextRepositoryBase({
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

  /// Reference to the 'texts' collection for a specific display.
  @protected
  CollectionReference<DisplayText> get textsRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('texts')
        .withConverter<DisplayText>(
          fromFirestore: (snapshot, _) =>
              DisplayText.fromJson(snapshot.data()!).copyWith(id: snapshot.id),
          toFirestore: (text, _) => text.toJson(),
        );
  }

  /// Reference to the document that stores the active text ID.
  /// Path: `.../settings/text`
  @protected
  DocumentReference get currentTextRef {
    return firestore
        .collection('clubs')
        .doc(clubId)
        .collection('displays')
        .doc(displayId)
        .collection('settings')
        .doc('text');
  }

  /// Streams the ID of the active text (`currentId`), or null if none.
  Stream<String?> watchCurrentTextId() {
    return currentTextRef.snapshots().map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>?;
      return data?['currentId'] as String?;
    });
  }

  /// Watches the currently active display text. Uses `switchMap` (rather
  /// than a one-shot `.get()`/`.first`) so an edit to the text while it's
  /// showing is reflected immediately, and switching `currentId` cancels the
  /// previous text's listener instead of leaving it dangling.
  Stream<DisplayText?> watchCurrentText() {
    return watchCurrentTextId().switchMap((currentId) {
      if (currentId == null) return Stream.value(null);
      return textsRef.doc(currentId).snapshots().map((doc) => doc.data());
    });
  }

  /// Returns a stream of all active text documents, ordered by timestamp.
  /// Optionally filters by a specific tag.
  Stream<List<DisplayText>> watchAllActiveTexts({String? tag}) {
    Query<DisplayText> query = textsRef.where(
      'status',
      isEqualTo: DisplayTextStatus.active.name,
    );

    if (tag != null) {
      query = query.where('tags', arrayContains: tag);
    }

    return query
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// Returns a stream of the list of all used text tags.
  Stream<List<String>> watchAllTextTags() {
    return currentTextRef.snapshots().map((snapshot) {
      final data = snapshot.data() as Map<String, dynamic>?;
      return List<String>.from(data?['textTags'] ?? []);
    });
  }
}
