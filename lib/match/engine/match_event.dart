import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/match/engine/match_config.dart';
import 'package:hs_coaching_core/match/engine/match_phase.dart';
import 'package:hs_coaching_core/match/engine/match_roster.dart';
import 'package:hs_coaching_core/team/team_model.dart';

part 'match_event.freezed.dart';
part 'match_event.g.dart';

/// Invoermethode van het tafeltoestel. De afstandsbediening van de
/// hoofdscheidsrechter is geen aparte gebruiker (03 §5).
enum EventSource { screen, remote }

/// Rol van wie het event ingaf (03 §3).
enum MatchAuthorRole { tableOfficial, chiefReferee, tournamentAdmin }

/// Welke kant wit kiest bij de start; zwart staat aan de andere kant. De
/// kanten wisselen daarna volgens 01 §3.1.
enum StartingEnds { whiteLeft, whiteRight }

enum RestartType {
  endLineStart,
  equalPuck,
  advantagePuck,
  afterPenaltyShot,
  afterTimeOut,
}

/// Informatief: de klok hangt niet van de reden af (02 §5).
enum StopReason {
  unspecified,
  goal,
  infringement,
  injury,
  confer,
  outOfBounds,
  penaltyShot,
  other,
}

enum GoalKind { field, penaltyShot, penaltyGoal }

enum PenaltyShotOutcome { goal, defended }

/// Een stand, gebruikt als de Technical Delegate een resultaat oplegt.
@freezed
abstract class MatchScore with _$MatchScore {
  const MatchScore._();

  const factory MatchScore({@Default(0) int white, @Default(0) int black}) =
      _MatchScore;

  factory MatchScore.fromJson(Map<String, dynamic> json) =>
      _$MatchScoreFromJson(json);

  int of(TeamColor team) => team == TeamColor.white ? white : black;

  bool get isTied => white == black;

  /// Team met de meeste goals, of `null` bij gelijkspel.
  TeamColor? get leader => isTied
      ? null
      : (white > black ? TeamColor.white : TeamColor.black);
}

/// Eén regel in het append-only event log van een wedstrijd
/// (02-match-engine.md §1).
///
/// Events zijn onveranderlijk: corrigeren gebeurt met [EventVoided], nooit met
/// een update of delete. De engine maakt zelf geen id's of tijdstippen aan;
/// de aanroeper geeft ze mee, zodat de reducer deterministisch blijft.
@freezed
abstract class MatchEvent with _$MatchEvent {
  @JsonSerializable(explicitToJson: true)
  const factory MatchEvent({
    /// Uniek id (uuid), gekozen door het tafeltoestel.
    required String id,
    required String matchId,

    /// Monotoon oplopend per wedstrijd; bepaalt de volgorde in de reducer.
    required int seq,

    /// Moment van de **tik**, in server-tijd (lokale tijd + de offset uit
    /// `serverTimeOffsetProvider`). Nooit het uploadmoment.
    required int serverTimeMillis,
    @Default('') String deviceId,
    @Default(MatchAuthorRole.tableOfficial) MatchAuthorRole authorRole,
    String? authorId,
    @Default(EventSource.screen) EventSource source,
    required MatchEventData data,
  }) = _MatchEvent;

  factory MatchEvent.fromJson(Map<String, dynamic> json) =>
      _$MatchEventFromJson(json);
}

/// De inhoud van een [MatchEvent] (02-match-engine.md §3).
///
/// Wissels en assists bestaan bewust niet (OPEN-4 en OPEN-7).
@Freezed(unionKey: 'type')
sealed class MatchEventData with _$MatchEventData {
  const MatchEventData._();

  // ---------------------------------------------------- Opbouw van de wedstrijd

  @JsonSerializable(explicitToJson: true)
  const factory MatchEventData.matchCreated({
    /// Snapshot van de effectieve config; latere wijzigingen aan een preset
    /// raken deze wedstrijd niet meer.
    required MatchConfig config,
    required String teamWhite,
    required String teamBlack,
    @Default(StartingEnds.whiteLeft) StartingEnds startingEnds,
    String? tournamentId,
    String? fieldId,
  }) = MatchCreated;

  @JsonSerializable(explicitToJson: true)
  const factory MatchEventData.rosterDeclared({
    required TeamColor team,
    required List<MatchPlayer> players,
    @Default(<String>[]) List<String> staff,
  }) = RosterDeclared;

  const factory MatchEventData.officialsAssigned({
    required String chief,
    @Default(<String>[]) List<String> water,
    @Default(<String>[]) List<String> timekeepers,
  }) = OfficialsAssigned;

  // -------------------------------------------------------------- Klok en fase

  /// Het 30 s-signaal vóór de start van [phase] (15.1.5).
  const factory MatchEventData.periodWarningGiven({required MatchPhase phase}) =
      PeriodWarningGiven;

  /// Startsignaal van de hoofdscheidsrechter. [team] is alleen ingevuld bij
  /// [RestartType.advantagePuck].
  const factory MatchEventData.playStarted({
    @Default(RestartType.endLineStart) RestartType restartType,
    TeamColor? team,
  }) = PlayStarted;

  const factory MatchEventData.playStopped({
    @Default(StopReason.unspecified) StopReason reason,
  }) = PlayStopped;

  /// Vult achteraf de reden van een [PlayStopped] aan (bv. na een stop via de
  /// afstandsbediening).
  const factory MatchEventData.stopReasonSpecified({
    required String targetId,
    required StopReason reason,
  }) = StopReasonSpecified;

  /// Eindigt bij het volgende [PlayStarted], of bij een toegekende goal.
  const factory MatchEventData.officialsTimeOutStarted({String? reason}) =
      OfficialsTimeOutStarted;

  const factory MatchEventData.teamTimeOutRequested({required TeamColor team}) =
      TeamTimeOutRequested;

  /// De tafel bevestigt het einde van [phase] wanneer de klok op 0 staat.
  const factory MatchEventData.periodEnded({required MatchPhase phase}) =
      PeriodEnded;

  // --------------------------------------------------------- Spelgebeurtenissen

  const factory MatchEventData.goalScored({
    required TeamColor team,
    int? scorerCap,
    @Default(GoalKind.field) GoalKind kind,
  }) = GoalScored;

  const factory MatchEventData.cautionGiven({
    required TeamColor team,
    int? cap,
    required String infringementCode,
    @Default(false) bool deliberate,
    @Default(false) bool isTeamCaution,
  }) = CautionGiven;

  const factory MatchEventData.timePenaltyGiven({
    required TeamColor team,
    required int cap,
    required int minutes,
    required String infringementCode,
    @Default(false) bool deliberate,
  }) = TimePenaltyGiven;

  const factory MatchEventData.playerDismissed({
    required TeamColor team,
    required int cap,
    required String infringementCode,
  }) = PlayerDismissed;

  const factory MatchEventData.officialDismissed({
    required TeamColor team,
    required String name,
  }) = OfficialDismissed;

  /// [againstTeam] is het team dat de overtreding beging; de strafworp is
  /// voor het andere team.
  const factory MatchEventData.penaltyShotAwarded({
    required TeamColor againstTeam,
  }) = PenaltyShotAwarded;

  /// Sluit de strafworp af. Een gescoorde strafworp wordt daarnaast als
  /// [GoalScored] met [GoalKind.penaltyShot] gelogd: alleen dat event telt
  /// voor de stand.
  const factory MatchEventData.penaltyShotResolved({
    required PenaltyShotOutcome outcome,
    @Default(<int>[]) List<int> attackers,
    int? defender,
  }) = PenaltyShotResolved;

  /// De hoofdscheidsrechter geeft de terugkeer vrij (17.3.1.2.3).
  const factory MatchEventData.penaltyPlayerReturned({
    required TeamColor team,
    required int cap,
  }) = PenaltyPlayerReturned;

  const factory MatchEventData.protestLogged({
    required TeamColor team,
    required String by,
    required String text,
  }) = ProtestLogged;

  /// Maakt een eerder event ongeldig; de reducer slaat het doel dan over. Het
  /// doel blijft in het log staan (audit trail).
  const factory MatchEventData.eventVoided({
    required String targetId,
    @Default('') String reason,
  }) = EventVoided;

  // ---------------------------------------------------------------- Afsluiting

  const factory MatchEventData.matchEndedBySignOff({
    required String chiefSignature,
    @Default(<String>[]) List<String> waterSignatures,
  }) = MatchEndedBySignOff;

  /// Beslissing van de Technical Delegate, bv. een winnaar zonder volledige
  /// overtime (OPEN-10).
  const factory MatchEventData.resultDecidedByDelegate({
    TeamColor? winner,
    required String text,
  }) = ResultDecidedByDelegate;

  /// [team] geeft forfait.
  const factory MatchEventData.matchForfeited({
    required TeamColor team,
    required String decisionText,
  }) = MatchForfeited;

  @JsonSerializable(explicitToJson: true)
  const factory MatchEventData.matchAbandoned({
    required String decisionText,
    MatchScore? resultOverride,
  }) = MatchAbandoned;

  factory MatchEventData.fromJson(Map<String, dynamic> json) =>
      _$MatchEventDataFromJson(json);
}

/// Het andere team.
TeamColor opponentOf(TeamColor team) =>
    team == TeamColor.white ? TeamColor.black : TeamColor.white;
