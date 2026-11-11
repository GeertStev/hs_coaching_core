import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_reducer.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/in_memory_match_repository.dart';
import 'package:hs_coaching_core/match/match_meta.dart';
import 'package:hs_coaching_core/match/match_repository.dart';
import 'package:hs_coaching_core/match/match_session.dart';
import 'package:hs_coaching_core/team/team_model.dart';

const _white = TeamColor.white;

/// Eén nep-server-klok voor alle toestellen in een test.
class _Clock {
  int now = 1700000000000;
  void wait(Duration duration) => now += duration.inMilliseconds;
}

int _idCounter = 0;

MatchSession _session(
  InMemoryMatchRepository repository,
  _Clock clock, {
  String matchId = 'm1',
  required String deviceId,
  void Function(MatchEvent, Object, StackTrace)? onWriteError,
}) => MatchSession(
  matchId: matchId,
  repository: repository,
  deviceId: deviceId,
  nowServerMs: () => clock.now,
  newEventId: () => 'id-${++_idCounter}',
  onWriteError: onWriteError,
);

const _created = MatchEventData.matchCreated(
  config: MatchConfig(),
  teamWhite: 'Wit',
  teamBlack: 'Zwart',
);

/// Laat de streams van de opslag hun waarden afleveren.
Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  late InMemoryMatchRepository repository;
  late _Clock clock;

  setUp(() async {
    repository = InMemoryMatchRepository();
    clock = _Clock();
    await repository.createMatch('m1', createdAtMillis: clock.now);
  });

  group('T15: één schrijvend toestel per wedstrijd (lease)', () {
    test('02 §6a T15: een tweede toestel zonder lease wordt geweigerd, na een '
        'expliciete overname lukt het', () async {
      final tableA = _session(repository, clock, deviceId: 'tafel-A');
      final tableB = _session(repository, clock, deviceId: 'tafel-B');
      await tableA.takeLease();
      await _settle();
      expect(tableA.holdsLease, isTrue);
      expect(tableB.holdsLease, isFalse);

      tableA
        ..add(_created)
        ..add(const MatchEventData.playStarted());
      await tableA.pendingWrites;
      await _settle();

      // Toestel B leest mee, maar mag niet schrijven.
      expect(tableB.state.phase, MatchPhase.p1);
      expect(
        () => tableB.add(const MatchEventData.goalScored(team: _white)),
        throwsA(isA<NotLeaseHolderException>()),
      );
      // Ook wie de controle in de sessie omzeilt, wordt door de opslag
      // geweigerd.
      await expectLater(
        repository.append(
          MatchEvent(
            id: 'vals',
            matchId: 'm1',
            seq: 3,
            serverTimeMillis: clock.now,
            deviceId: 'tafel-B',
            data: const MatchEventData.goalScored(team: _white),
          ),
        ),
        throwsA(isA<NotLeaseHolderException>()),
      );
      // Zonder expliciete overname krijgt B de lease niet.
      await expectLater(
        tableB.takeLease(),
        throwsA(
          isA<LeaseHeldException>().having(
            (e) => e.holderDeviceId,
            'holderDeviceId',
            'tafel-A',
          ),
        ),
      );

      // Expliciete overname (bv. lege batterij van toestel A).
      clock.wait(const Duration(minutes: 1));
      await tableB.takeLease(takeOver: true);
      await _settle();
      expect(tableB.holdsLease, isTrue);
      expect(tableA.holdsLease, isFalse);
      tableB.add(const MatchEventData.goalScored(team: _white, scorerCap: 4));
      await tableB.pendingWrites;
      await _settle();
      expect(
        () => tableA.add(const MatchEventData.playStarted()),
        throwsA(isA<NotLeaseHolderException>()),
      );

      // Unieke, opeenvolgende seq; geen verloren of dubbel event.
      final events = await repository.watchEvents('m1').first;
      expect(events.map((event) => event.seq), [1, 2, 3]);
      expect(events.map((event) => event.id).toSet(), hasLength(3));
      expect(events.map((event) => event.deviceId), [
        'tafel-A',
        'tafel-A',
        'tafel-B',
      ]);
      expect(tableA.state.score.white, 1);
      expect(tableB.state.score.white, 1);

      await tableA.dispose();
      await tableB.dispose();
    });

    test('02 §6 T15: een dubbel volgnummer wordt door de opslag geweigerd en '
        'lokaal teruggedraaid', () async {
      final errors = <Object>[];
      final tableA = _session(
        repository,
        clock,
        deviceId: 'tafel-A',
        onWriteError: (event, error, stack) => errors.add(error),
      );
      await tableA.takeLease();
      await _settle();
      tableA.add(_created);
      await tableA.pendingWrites;
      await _settle();

      // Een ander pad schreef intussen seq 2 (bv. na herverbinden); deze
      // sessie weet dat nog niet als ze zelf seq 2 uitdeelt.
      final gate = Completer<void>();
      repository.writeGate = gate.future;
      final local = tableA.add(const MatchEventData.playStarted());
      expect(local.seq, 2);
      repository.writeGate = null;
      await repository.append(
        MatchEvent(
          id: 'ander-pad',
          matchId: 'm1',
          seq: 2,
          serverTimeMillis: clock.now,
          deviceId: 'tafel-A',
          data: const MatchEventData.rosterDeclared(team: _white, players: []),
        ),
      );
      gate.complete();
      await tableA.pendingWrites;
      await _settle();

      expect(errors.single, isA<DuplicateSeqException>());
      final events = await repository.watchEvents('m1').first;
      expect(events.map((event) => event.seq), [1, 2]);
      // Het geweigerde startsignaal zit niet meer in de lokale toestand.
      expect(tableA.state.phase, MatchPhase.notStarted);
      // De volgende tik krijgt het eerstvolgende vrije nummer.
      expect(tableA.add(const MatchEventData.playStarted()).seq, 3);
      await tableA.pendingWrites;
      await tableA.dispose();
    });

    test('02 §6a de lease vrijgeven laat een ander toestel toe', () async {
      final tableA = _session(repository, clock, deviceId: 'tafel-A');
      final tableB = _session(repository, clock, deviceId: 'tafel-B');
      await tableA.takeLease();
      // Nog eens nemen door dezelfde houder is geen fout.
      await tableA.takeLease();
      await tableA.releaseLease();
      await tableB.takeLease();
      await _settle();
      expect(tableB.holdsLease, isTrue);
      expect(tableB.meta!.lease!.sinceMillis, clock.now);
      await tableA.dispose();
      await tableB.dispose();
    });
  });

  group('offline: de tik is het officiële tijdstip', () {
    test('02 §6 een event zonder verbinding telt meteen lokaal en behoudt het '
        'tijdstip van de tik', () async {
      final table = _session(repository, clock, deviceId: 'tafel-A');
      await table.takeLease();
      await _settle();
      table
        ..add(_created)
        ..add(const MatchEventData.playStarted());
      await table.pendingWrites;

      // Verbinding weg: writes blijven hangen.
      final offline = Completer<void>();
      repository.writeGate = offline.future;
      clock.wait(const Duration(minutes: 2));
      final tapTime = clock.now;
      final goal = table.add(
        const MatchEventData.goalScored(team: _white),
        source: EventSource.remote,
      );
      expect(goal.serverTimeMillis, tapTime);
      // Lokaal telt de goal meteen, ook al staat ze nog niet op de server.
      expect(table.state.score.white, 1);
      expect((await repository.watchEvents('m1').first), hasLength(2));

      // 3 minuten later is er weer verbinding.
      clock.wait(const Duration(minutes: 3));
      repository.writeGate = null;
      offline.complete();
      await table.pendingWrites;
      await _settle();

      final stored = (await repository.watchEvents('m1').first).last;
      expect(stored.id, goal.id);
      expect(stored.serverTimeMillis, tapTime);
      expect(stored.source, EventSource.remote);
      expect(table.state.score.white, 1);
      expect(
        table.state.goals.single.elapsedInPhase,
        const Duration(minutes: 2),
      );
      await table.dispose();
    });

    test('02 §6 meerdere tikken na elkaar krijgen opeenvolgende nummers, ook '
        'zonder antwoord van de server', () async {
      final table = _session(repository, clock, deviceId: 'tafel-A');
      await table.takeLease();
      await _settle();
      final offline = Completer<void>();
      repository.writeGate = offline.future;
      final seqs = [
        table.add(_created).seq,
        table.add(const MatchEventData.playStarted()).seq,
        table.add(const MatchEventData.playStopped()).seq,
      ];
      expect(seqs, [1, 2, 3]);
      repository.writeGate = null;
      offline.complete();
      await table.pendingWrites;
      await _settle();
      expect(
        (await repository.watchEvents('m1').first).map((event) => event.seq),
        [1, 2, 3],
      );
      await table.dispose();
    });
  });

  group('validatie in de sessie', () {
    test('02 §5 een geweigerd event wordt niet geschreven', () async {
      final table = _session(repository, clock, deviceId: 'tafel-A');
      await table.takeLease();
      await _settle();
      table
        ..add(_created)
        ..add(const MatchEventData.playStarted());
      const timeOut = MatchEventData.teamTimeOutRequested(team: _white);
      expect(
        table.check(timeOut),
        const TimeOutNotAllowed(TimeOutProblem.playRunning),
      );
      expect(
        () => table.add(timeOut),
        throwsA(
          isA<MatchEventRejectedException>().having(
            (e) => e.rejection,
            'rejection',
            const TimeOutNotAllowed(TimeOutProblem.playRunning),
          ),
        ),
      );
      await table.pendingWrites;
      expect(await repository.watchEvents('m1').first, hasLength(2));
      await table.dispose();
    });

    test('02 §1 de sessie geeft elke nieuwe toestand door en berekent de '
        'klok met de server-tijd', () async {
      final table = _session(repository, clock, deviceId: 'tafel-A');
      final phases = <MatchPhase>[];
      final subscription = table.states.listen((s) => phases.add(s.phase));
      await table.takeLease();
      await _settle();
      table
        ..add(_created)
        ..add(const MatchEventData.playStarted());
      await table.pendingWrites;
      await _settle();
      clock.wait(const Duration(minutes: 5));
      expect(table.clock.periodRemaining, const Duration(minutes: 10));
      expect(phases, contains(MatchPhase.p1));
      await subscription.cancel();
      await table.dispose();
    });
  });

  group('T18: één live wedstrijd per veld', () {
    test('04 §3 T18: een tweede wedstrijd live zetten op een bezet veld wordt '
        'geweigerd', () async {
      await repository.createMatch('m2', createdAtMillis: clock.now);
      await repository.goLive('m1', fieldId: 'veld-1');
      expect(await repository.watchLiveMatchId('veld-1').first, 'm1');
      expect((await repository.watchMeta('m1').first)!.isLive, isTrue);

      await expectLater(
        repository.goLive('m2', fieldId: 'veld-1'),
        throwsA(
          isA<FieldBusyException>().having(
            (e) => e.liveMatchId,
            'liveMatchId',
            'm1',
          ),
        ),
      );
      expect((await repository.watchMeta('m2').first)!.isLive, isFalse);

      // Dezelfde wedstrijd nog eens live zetten is geen fout.
      await repository.goLive('m1', fieldId: 'veld-1');
      // Een ander veld is vrij.
      await repository.goLive('m2', fieldId: 'veld-2');

      // Zodra veld 1 vrijkomt, kan de volgende wedstrijd erop.
      await repository.endLive('m1');
      expect(await repository.watchLiveMatchId('veld-1').first, isNull);
      await repository.goLive('m2', fieldId: 'veld-1');
      expect(await repository.watchLiveMatchId('veld-1').first, 'm2');
      // m2 verhuisde: veld 2 is weer vrij.
      expect(await repository.watchLiveMatchId('veld-2').first, isNull);
    });

    test('04 §3 live zetten van een onbekende wedstrijd faalt', () async {
      await expectLater(
        repository.goLive('bestaat-niet', fieldId: 'veld-1'),
        throwsA(isA<MatchNotFoundException>()),
      );
    });
  });

  test('02 §6b T17: 3 wedstrijden tegelijk op 3 tafeltoestellen', () async {
    final sessions = <MatchSession>[];
    for (var field = 1; field <= 3; field++) {
      final matchId = 'veld-$field-match';
      await repository.createMatch(
        matchId,
        createdAtMillis: clock.now,
        fieldId: 'veld-$field',
      );
      final session = _session(
        repository,
        clock,
        matchId: matchId,
        deviceId: 'tafel-$field',
      );
      await session.takeLease();
      await repository.goLive(matchId, fieldId: 'veld-$field');
      sessions.add(session);
    }
    await _settle();

    // Events door elkaar: elke tafel tikt om beurten.
    for (final session in sessions) {
      session.add(_created);
    }
    clock.wait(const Duration(seconds: 10));
    sessions[0].add(const MatchEventData.playStarted());
    clock.wait(const Duration(seconds: 30));
    sessions[1].add(const MatchEventData.playStarted());
    clock.wait(const Duration(minutes: 1));
    sessions[0].add(const MatchEventData.goalScored(team: _white));
    sessions[2].add(const MatchEventData.playStarted());
    clock.wait(const Duration(minutes: 1));
    sessions[1].add(const MatchEventData.playStopped());
    sessions[0].add(const MatchEventData.playStarted());
    for (final session in sessions) {
      await session.pendingWrites;
    }
    await _settle();

    expect(sessions[0].state.score.white, 1);
    expect(sessions[1].state.score.white, 0);
    expect(sessions[2].state.score.white, 0);
    expect(
      sessions[0].clock.periodRemaining,
      const Duration(minutes: 12, seconds: 30),
    );
    expect(sessions[1].clock.periodRemaining, const Duration(minutes: 13));
    expect(sessions[2].clock.periodRemaining, const Duration(minutes: 14));

    // Elke wedstrijd apart gereduceerd geeft exact dezelfde toestand, en een
    // scherm dat alleen leest ziet hetzelfde als de tafel.
    for (final session in sessions) {
      final events = await repository.watchEvents(session.matchId).first;
      expect(events.every((event) => event.matchId == session.matchId), isTrue);
      final alone = reduceMatch(events);
      final viewer = await repository.watch(session.matchId).first;
      for (final other in [alone, viewer]) {
        expect(other.phase, session.state.phase);
        expect(other.score, session.state.score);
        expect(other.lastSeq, session.state.lastSeq);
        expect(other.remainingInPhase, session.state.remainingInPhase);
      }
      await session.dispose();
    }
    expect(await repository.watchLiveMatchId('veld-2').first, 'veld-2-match');
  });

  test('MatchMeta overleeft jsonEncode en jsonDecode', () {
    const meta = MatchMeta(
      createdAtMillis: 1700000000000,
      tournamentId: 'bk',
      fieldId: 'veld-1',
      lease: MatchLease(deviceId: 'tafel-A', sinceMillis: 1700000001000),
      liveFieldId: 'veld-1',
    );
    final json = jsonDecode(jsonEncode(meta.toJson())) as Map<String, dynamic>;
    expect(MatchMeta.fromJson(json), meta);
  });
}
