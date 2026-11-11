import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hs_coaching_core/core/errors/error_reporting.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/match_meta.dart';
import 'package:hs_coaching_core/match/match_repository.dart';

/// Alleen-lezen Firestore-opslag van wedstrijden:
///
/// ```
/// clubs/{clubId}/
///   matches/{matchId}                 # MatchMeta (lease, veld, live)
///     events/{seq}                    # MatchEvent, append-only
///   fields/{fieldId}                  # { liveMatchId }
/// ```
///
/// `hs_coaching_screen` gebruikt deze klasse rechtstreeks (het schrijft
/// nooit); `hs_coaching_app` breidt ze uit tot `FirestoreMatchWriteRepository`
/// met de schrijfacties. Anders dan de `Display<X>Repository`-klassen hangt
/// dit niet aan een display: een wedstrijd hoort bij de club.
class FirestoreMatchRepository implements MatchRepository {
  FirestoreMatchRepository({required this.firestore, required this.clubId});

  @protected
  final FirebaseFirestore firestore;
  @protected
  final String clubId;

  @protected
  DocumentReference<Map<String, dynamic>> get clubRef =>
      firestore.collection('clubs').doc(clubId);

  @protected
  DocumentReference<Map<String, dynamic>> matchRef(String matchId) =>
      clubRef.collection('matches').doc(matchId);

  @protected
  CollectionReference<Map<String, dynamic>> eventsRef(String matchId) =>
      matchRef(matchId).collection('events');

  @protected
  DocumentReference<Map<String, dynamic>> fieldRef(String fieldId) =>
      clubRef.collection('fields').doc(fieldId);

  @override
  Stream<List<MatchEvent>> watchEvents(String matchId) {
    return eventsRef(matchId).orderBy('seq').snapshots().map((snapshot) {
      final events = <MatchEvent>[];
      for (final doc in snapshot.docs) {
        try {
          events.add(MatchEvent.fromJson(doc.data()));
        } catch (error, stack) {
          // Eén onleesbaar event mag de wedstrijd niet blokkeren.
          reportError(
            error,
            stack,
            context: 'match event ${doc.reference.path}',
          );
        }
      }
      return events;
    });
  }

  @override
  Stream<MatchMeta?> watchMeta(String matchId) {
    return matchRef(matchId).snapshots().map((snapshot) {
      final data = snapshot.data();
      return data == null ? null : MatchMeta.fromJson(data);
    });
  }

  @override
  Stream<String?> watchLiveMatchId(String fieldId) {
    return fieldRef(
      fieldId,
    ).snapshots().map((snapshot) => snapshot.data()?['liveMatchId'] as String?);
  }
}
