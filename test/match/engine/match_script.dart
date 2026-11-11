import 'package:hs_coaching_core/match/engine/clock_view.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_event.dart';
import 'package:hs_coaching_core/match/engine/match_reducer.dart';
import 'package:hs_coaching_core/match/engine/match_rejection.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';
import 'package:hs_coaching_core/team/team_model.dart';

const white = TeamColor.white;
const black = TeamColor.black;

Duration mmss(int minutes, int seconds) =>
    Duration(minutes: minutes, seconds: seconds);

/// Schrijft een wedstrijd als een reeks events met een nepklok: [wait] schuift
/// de server-tijd op, [add] logt een event op dat moment. Nergens echte tijd.
class MatchScript {
  MatchScript({
    this.config = const MatchConfig(),
    this.matchId = 'm1',
    int startMillis = 1700000000000,
  }) : now = startMillis {
    add(
      MatchEventData.matchCreated(
        config: config,
        teamWhite: 'Wit',
        teamBlack: 'Zwart',
      ),
    );
  }

  final MatchConfig config;
  final String matchId;
  final List<MatchEvent> events = [];

  /// De nep-server-tijd.
  int now;
  int _seq = 0;

  MatchEvent _make(MatchEventData data, EventSource source) => MatchEvent(
    id: '$matchId-e${_seq + 1}',
    matchId: matchId,
    seq: _seq + 1,
    serverTimeMillis: now,
    deviceId: 'tafel-1',
    source: source,
    data: data,
  );

  /// Logt [data] op het huidige tijdstip, ook als de engine het zou weigeren.
  MatchEvent add(MatchEventData data, {EventSource source = EventSource.screen}) {
    final event = _make(data, source);
    _seq++;
    events.add(event);
    return event;
  }

  /// Wat de validator van [data] vindt, zonder het te loggen.
  MatchRejection? check(MatchEventData data) =>
      validateEvent(state, _make(data, EventSource.screen));

  void wait(Duration duration) => now += duration.inMilliseconds;

  MatchState get state => reduceMatch(events);
  ClockView get clock => clockViewAt(state, now);
  Duration? get remaining => clock.periodRemaining;

  MatchEvent start([RestartType type = RestartType.endLineStart]) =>
      add(MatchEventData.playStarted(restartType: type));

  MatchEvent stop([StopReason reason = StopReason.infringement]) =>
      add(MatchEventData.playStopped(reason: reason));

  MatchEvent goal(
    TeamColor team, {
    int? cap,
    GoalKind kind = GoalKind.field,
  }) => add(MatchEventData.goalScored(team: team, scorerCap: cap, kind: kind));

  MatchEvent penalty(TeamColor team, int cap, int minutes) => add(
    MatchEventData.timePenaltyGiven(
      team: team,
      cap: cap,
      minutes: minutes,
      infringementCode: '16.3.8-barging',
    ),
  );

  MatchEvent voidEvent(MatchEvent target) =>
      add(MatchEventData.eventVoided(targetId: target.id, reason: 'vergissing'));

  /// Laat het lopende spel doorgaan tot de klok [target] toont.
  void playUntilRemaining(Duration target) => wait(remaining! - target);

  MatchEvent endPeriod() =>
      add(MatchEventData.periodEnded(phase: state.phase));

  /// Start de volgende speelfase, speelt ze zonder onderbreking uit en
  /// bevestigt het einde.
  void playFullPeriod() {
    start();
    wait(remaining!);
    endPeriod();
  }

  /// Speelt periode 1 uit en start periode 2.
  void startSecondPeriod() {
    playFullPeriod();
    start();
  }

  PenaltyRecord penaltyOf(MatchEvent event) =>
      clock.penalties.singleWhere((penalty) => penalty.eventId == event.id);
}
