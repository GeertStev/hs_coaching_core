import 'dart:async';

import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/match_meta.dart';
import 'package:hs_coaching_core/match/match_repository.dart';

/// Wedstrijdopslag in het geheugen, zonder Firebase.
///
/// Gedraagt zich zoals de server: alleen de lease-houder mag schrijven, een
/// volgnummer kan maar één keer voorkomen, en per veld is hooguit één
/// wedstrijd live. Bedoeld voor tests en om de wedstrijdtafel te proberen
/// zonder Firebase.
class InMemoryMatchRepository implements MatchWriteRepository {
  final Map<String, _Value<List<MatchEvent>>> _events = {};
  final Map<String, _Value<MatchMeta?>> _metas = {};
  final Map<String, _Value<String?>> _fields = {};

  /// Zolang dit gezet is, wachten alle writes van [append] erop. Zo bootst
  /// een test een toestel zonder verbinding na.
  Future<void>? writeGate;

  _Value<List<MatchEvent>> _eventsOf(String matchId) =>
      _events.putIfAbsent(matchId, () => _Value(const []));

  _Value<MatchMeta?> _metaOf(String matchId) =>
      _metas.putIfAbsent(matchId, () => _Value(null));

  _Value<String?> _fieldOf(String fieldId) =>
      _fields.putIfAbsent(fieldId, () => _Value(null));

  MatchMeta _requireMeta(String matchId) {
    final meta = _metaOf(matchId).value;
    if (meta == null) throw MatchNotFoundException(matchId);
    return meta;
  }

  @override
  Stream<List<MatchEvent>> watchEvents(String matchId) =>
      _eventsOf(matchId).stream;

  @override
  Stream<MatchMeta?> watchMeta(String matchId) => _metaOf(matchId).stream;

  @override
  Stream<String?> watchLiveMatchId(String fieldId) => _fieldOf(fieldId).stream;

  @override
  Future<void> createMatch(
    String matchId, {
    required int createdAtMillis,
    String? tournamentId,
    String? fieldId,
  }) async {
    _metaOf(matchId).value = MatchMeta(
      createdAtMillis: createdAtMillis,
      tournamentId: tournamentId,
      fieldId: fieldId,
    );
  }

  @override
  Future<void> acquireLease(
    String matchId, {
    required String deviceId,
    required int nowMillis,
    bool takeOver = false,
  }) async {
    final meta = _requireMeta(matchId);
    final lease = meta.lease;
    if (lease != null && lease.deviceId == deviceId) return;
    if (lease != null && !takeOver) throw LeaseHeldException(lease.deviceId);
    _metaOf(matchId).value = meta.copyWith(
      lease: MatchLease(deviceId: deviceId, sinceMillis: nowMillis),
    );
  }

  @override
  Future<void> releaseLease(String matchId, {required String deviceId}) async {
    final meta = _requireMeta(matchId);
    if (meta.lease?.deviceId != deviceId) return;
    _metaOf(matchId).value = meta.copyWith(lease: null);
  }

  @override
  Future<void> append(MatchEvent event) async {
    final gate = writeGate;
    if (gate != null) await gate;

    final meta = _requireMeta(event.matchId);
    if (meta.lease?.deviceId != event.deviceId) {
      throw const NotLeaseHolderException();
    }
    final events = _eventsOf(event.matchId);
    if (events.value.any((existing) => existing.seq == event.seq)) {
      throw DuplicateSeqException(event.seq);
    }
    events.value = List.unmodifiable(
      [...events.value, event]..sort((a, b) => a.seq.compareTo(b.seq)),
    );
  }

  @override
  Future<void> goLive(String matchId, {required String fieldId}) async {
    final meta = _requireMeta(matchId);
    final field = _fieldOf(fieldId);
    final current = field.value;
    if (current != null && current != matchId) {
      throw FieldBusyException(current);
    }
    // Stond de wedstrijd op een ander veld live, dan komt dat veld vrij.
    final previous = meta.liveFieldId;
    if (previous != null && previous != fieldId) {
      _fieldOf(previous).value = null;
    }
    field.value = matchId;
    _metaOf(matchId).value = meta.copyWith(liveFieldId: fieldId);
  }

  @override
  Future<void> endLive(String matchId) async {
    final meta = _requireMeta(matchId);
    final fieldId = meta.liveFieldId;
    if (fieldId == null) return;
    final field = _fieldOf(fieldId);
    if (field.value == matchId) field.value = null;
    _metaOf(matchId).value = meta.copyWith(liveFieldId: null);
  }
}

/// Een waarde met een stream die bij het luisteren eerst de huidige waarde
/// geeft en daarna elke wijziging (zoals een Firestore-snapshotstream).
class _Value<T> {
  _Value(this._value);

  T _value;
  final StreamController<T> _changes = StreamController<T>.broadcast();

  T get value => _value;

  set value(T next) {
    _value = next;
    _changes.add(next);
  }

  Stream<T> get stream => Stream<T>.multi((listener) {
    listener.add(_value);
    final subscription = _changes.stream.listen(
      listener.add,
      onError: listener.addError,
    );
    listener.onCancel = subscription.cancel;
  });
}
