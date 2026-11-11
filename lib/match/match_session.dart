import 'dart:async';

import 'package:hs_coaching_core/match/engine/clock_view.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_reducer.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';
import 'package:hs_coaching_core/match/match_meta.dart';
import 'package:hs_coaching_core/match/match_repository.dart';

/// Eén wedstrijd op één tafeltoestel: de stream, de toestand en de validator
/// (02-match-engine.md §6b).
///
/// Er is geen globale "actieve wedstrijd": wie een wedstrijd wil bedienen,
/// maakt een sessie voor dat `matchId`. De wedstrijdtafel heeft er één open;
/// een scherm dat alleen leest gebruikt `MatchRepository.watch` en heeft geen
/// sessie nodig.
///
/// Geen Flutter en geen Firebase: de server-tijd en de event-id's komen van de
/// aanroeper ([nowServerMs], [newEventId]).
class MatchSession {
  MatchSession({
    required this.matchId,
    required MatchWriteRepository repository,
    required this.deviceId,
    required int Function() nowServerMs,
    required String Function() newEventId,
    this.authorRole = MatchAuthorRole.tableOfficial,
    this.authorId,
    this.onWriteError,
  }) : _repository = repository,
       _nowServerMs = nowServerMs,
       _newEventId = newEventId {
    _eventsSubscription = repository
        .watchEvents(matchId)
        .listen(_onRemoteEvents, onError: _states.addError);
    _metaSubscription = repository
        .watchMeta(matchId)
        .listen((meta) => _meta = meta, onError: _states.addError);
  }

  final String matchId;

  /// Vast id van dit toestel; bepaalt wie de lease heeft.
  final String deviceId;
  final MatchAuthorRole authorRole;
  final String? authorId;

  /// Wordt aangeroepen als de server een event achteraf weigert (bv. omdat
  /// een ander toestel de wedstrijd overnam). Het event is dan al uit de
  /// lokale toestand gehaald.
  final void Function(MatchEvent event, Object error, StackTrace stack)?
  onWriteError;

  final MatchWriteRepository _repository;

  /// `serverNowMillis(offset)`: lokale tijd plus de offset van de server.
  final int Function() _nowServerMs;
  final String Function() _newEventId;

  final StreamController<MatchState> _states =
      StreamController<MatchState>.broadcast();
  late final StreamSubscription<List<MatchEvent>> _eventsSubscription;
  late final StreamSubscription<MatchMeta?> _metaSubscription;

  List<MatchEvent> _remote = const [];

  /// Events die hier getikt zijn en nog niet in het log van de server staan.
  final List<MatchEvent> _pending = [];
  final Set<Future<void>> _writes = {};
  MatchState _state = reduceMatch(const []);
  MatchMeta? _meta;
  int _lastIssuedSeq = 0;

  /// De huidige toestand, inclusief events die nog onderweg zijn naar de
  /// server.
  MatchState get state => _state;

  /// Elke nieuwe toestand. Geeft niet de huidige bij het luisteren; lees
  /// daarvoor [state].
  Stream<MatchState> get states => _states.stream;

  MatchMeta? get meta => _meta;

  /// Dit toestel mag schrijven.
  bool get holdsLease => _meta?.lease?.deviceId == deviceId;

  /// De klokken op dit moment.
  ClockView get clock => clockViewAt(_state, _nowServerMs());

  /// Klaar zodra alle lopende writes afgehandeld zijn (gelukt of geweigerd).
  /// Offline kan dat lang duren; de UI wacht hier niet op.
  Future<void> get pendingWrites => Future.wait(_writes.toList());

  /// Neemt de lease voor dit toestel. Met [takeOver] neemt het ze over van
  /// een ander toestel; vraag daar eerst een expliciete bevestiging voor.
  Future<void> takeLease({bool takeOver = false}) => _repository.acquireLease(
    matchId,
    deviceId: deviceId,
    nowMillis: _nowServerMs(),
    takeOver: takeOver,
  );

  Future<void> releaseLease() =>
      _repository.releaseLease(matchId, deviceId: deviceId);

  /// Wat de engine van [data] vindt op dit moment, zonder iets te schrijven.
  /// `null` betekent toegelaten.
  MatchRejection? check(MatchEventData data) =>
      validateEvent(_state, _build(data, EventSource.screen, _nextSeq));

  /// Logt [data] op het moment van de tik.
  ///
  /// Het event zit meteen in [state]; het schrijven naar de server loopt op
  /// de achtergrond, zodat de tafel ook zonder verbinding verder kan. Het
  /// tijdstip in het event is dat van de tik, niet van de upload.
  ///
  /// Gooit [NotLeaseHolderException] als dit toestel de lease niet heeft, en
  /// [MatchEventRejectedException] als de engine het event weigert.
  MatchEvent add(
    MatchEventData data, {
    EventSource source = EventSource.screen,
  }) {
    if (!holdsLease) throw const NotLeaseHolderException();
    final event = _build(data, source, _nextSeq);
    final rejection = validateEvent(_state, event);
    if (rejection != null) throw MatchEventRejectedException(rejection);

    _lastIssuedSeq = event.seq;
    _pending.add(event);
    _recompute();

    late final Future<void> write;
    write = _repository
        .append(event)
        .then<void>(
          (_) {},
          onError: (Object error, StackTrace stack) {
            _pending.removeWhere((pending) => pending.id == event.id);
            _recompute();
            onWriteError?.call(event, error, stack);
          },
        )
        .whenComplete(() => _writes.remove(write));
    _writes.add(write);
    return event;
  }

  Future<void> dispose() async {
    await _eventsSubscription.cancel();
    await _metaSubscription.cancel();
    await _states.close();
  }

  int get _nextSeq =>
      (_state.lastSeq > _lastIssuedSeq ? _state.lastSeq : _lastIssuedSeq) + 1;

  MatchEvent _build(MatchEventData data, EventSource source, int seq) =>
      MatchEvent(
        id: _newEventId(),
        matchId: matchId,
        seq: seq,
        serverTimeMillis: _nowServerMs(),
        deviceId: deviceId,
        authorRole: authorRole,
        authorId: authorId,
        source: source,
        data: data,
      );

  void _onRemoteEvents(List<MatchEvent> events) {
    _remote = events;
    final known = {for (final event in events) event.id};
    _pending.removeWhere((pending) => known.contains(pending.id));
    _recompute();
  }

  void _recompute() {
    _state = reduceMatch([..._remote, ..._pending]);
    if (!_states.isClosed) _states.add(_state);
  }
}
