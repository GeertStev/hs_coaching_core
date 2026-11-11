import 'package:hs_coaching_core/core/errors/user_message.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_reducer.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';
import 'package:hs_coaching_core/match/match_meta.dart';

/// Leeskant van de wedstrijdopslag. Alles is per `matchId`: er bestaat geen
/// globale "actieve wedstrijd" (02-match-engine.md §6b).
///
/// Dit is bewust een interface (een uitzondering op de rest van de code): de
/// engine en `MatchSession` moeten zonder Firebase kunnen draaien en testen.
/// Implementaties: `FirestoreMatchRepository` (hier in core, alleen lezen;
/// `hs_coaching_screen` gebruikt die rechtstreeks) en
/// `InMemoryMatchRepository` (tests en proefdraaien zonder Firebase).
abstract interface class MatchRepository {
  /// Het volledige event log van een wedstrijd, gesorteerd op `seq`. Geeft
  /// bij elke wijziging de hele lijst opnieuw.
  Stream<List<MatchEvent>> watchEvents(String matchId);

  /// Het wedstrijddocument; `null` zolang de wedstrijd niet bestaat.
  Stream<MatchMeta?> watchMeta(String matchId);

  /// De wedstrijd die nu live is op [fieldId], of `null`.
  Stream<String?> watchLiveMatchId(String fieldId);
}

extension MatchRepositoryStates on MatchRepository {
  /// De toestand van een wedstrijd, lokaal gereduceerd uit het event log.
  /// Elk toestel berekent zo dezelfde toestand.
  Stream<MatchState> watch(String matchId) =>
      watchEvents(matchId).map(reduceMatch);
}

/// Schrijfkant van de wedstrijdopslag. Alleen `hs_coaching_app` gebruikt die
/// (`FirestoreMatchWriteRepository`); het scherm schrijft nooit.
abstract interface class MatchWriteRepository implements MatchRepository {
  /// Maakt het wedstrijddocument aan, nog zonder lease en zonder events.
  Future<void> createMatch(
    String matchId, {
    required int createdAtMillis,
    String? tournamentId,
    String? fieldId,
  });

  /// Neemt de schrijf-lease voor [deviceId] (02 §6a).
  ///
  /// Heeft een ander toestel de lease, dan faalt dit met
  /// [LeaseHeldException], tenzij [takeOver] true is: een overname mag alleen
  /// na een expliciete bevestiging op het nieuwe toestel.
  Future<void> acquireLease(
    String matchId, {
    required String deviceId,
    required int nowMillis,
    bool takeOver = false,
  });

  /// Geeft de lease vrij als [deviceId] ze heeft.
  Future<void> releaseLease(String matchId, {required String deviceId});

  /// Voegt [event] toe aan het log. Events zijn append-only: er is geen
  /// update of delete.
  ///
  /// De Future is pas klaar als de server het event aanvaard heeft. Offline
  /// kan dat lang duren: de tafel wacht er niet op (zie `MatchSession.add`).
  /// Het tijdstip in het event blijft dat van de tik, niet van de upload.
  Future<void> append(MatchEvent event);

  /// Zet de wedstrijd live op [fieldId]. Per veld is hooguit één wedstrijd
  /// live; anders faalt dit met [FieldBusyException] (04-toernooi.md §3).
  Future<void> goLive(String matchId, {required String fieldId});

  /// Haalt de wedstrijd van haar veld.
  Future<void> endLive(String matchId);
}

/// Een ander toestel heeft de lease van deze wedstrijd.
class LeaseHeldException implements UserFacingException {
  const LeaseHeldException(this.holderDeviceId);

  final String holderDeviceId;

  @override
  String get message =>
      'Another device is running this match. Take over to continue here.';

  @override
  String toString() => 'LeaseHeldException($holderDeviceId)';
}

/// Dit toestel probeert te schrijven zonder de lease.
class NotLeaseHolderException implements UserFacingException {
  const NotLeaseHolderException();

  @override
  String get message => 'This device is not running this match.';

  @override
  String toString() => 'NotLeaseHolderException';
}

/// Er bestaat al een event met dit volgnummer.
class DuplicateSeqException implements UserFacingException {
  const DuplicateSeqException(this.seq);

  final int seq;

  @override
  String get message =>
      'This action was already recorded by another device. Try again.';

  @override
  String toString() => 'DuplicateSeqException($seq)';
}

/// Op dit veld is al een andere wedstrijd live.
class FieldBusyException implements UserFacingException {
  const FieldBusyException(this.liveMatchId);

  final String liveMatchId;

  @override
  String get message => 'Another match is already live on this field.';

  @override
  String toString() => 'FieldBusyException($liveMatchId)';
}

class MatchNotFoundException implements UserFacingException {
  const MatchNotFoundException(this.matchId);

  final String matchId;

  @override
  String get message => 'This match no longer exists.';

  @override
  String toString() => 'MatchNotFoundException($matchId)';
}

/// De engine weigert het event; [rejection] zegt waarom.
class MatchEventRejectedException implements UserFacingException {
  const MatchEventRejectedException(this.rejection);

  final MatchRejection rejection;

  @override
  String get message => 'This action is not allowed right now.';

  @override
  String toString() => 'MatchEventRejectedException($rejection)';
}
