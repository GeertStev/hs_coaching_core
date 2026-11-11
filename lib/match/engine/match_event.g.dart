// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchScore _$MatchScoreFromJson(Map<String, dynamic> json) => _MatchScore(
  white: (json['white'] as num?)?.toInt() ?? 0,
  black: (json['black'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$MatchScoreToJson(_MatchScore instance) =>
    <String, dynamic>{'white': instance.white, 'black': instance.black};

_MatchEvent _$MatchEventFromJson(Map<String, dynamic> json) => _MatchEvent(
  id: json['id'] as String,
  matchId: json['matchId'] as String,
  seq: (json['seq'] as num).toInt(),
  serverTimeMillis: (json['serverTimeMillis'] as num).toInt(),
  deviceId: json['deviceId'] as String? ?? '',
  authorRole:
      $enumDecodeNullable(_$MatchAuthorRoleEnumMap, json['authorRole']) ??
      MatchAuthorRole.tableOfficial,
  authorId: json['authorId'] as String?,
  source:
      $enumDecodeNullable(_$EventSourceEnumMap, json['source']) ??
      EventSource.screen,
  data: MatchEventData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MatchEventToJson(_MatchEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'matchId': instance.matchId,
      'seq': instance.seq,
      'serverTimeMillis': instance.serverTimeMillis,
      'deviceId': instance.deviceId,
      'authorRole': _$MatchAuthorRoleEnumMap[instance.authorRole]!,
      'authorId': instance.authorId,
      'source': _$EventSourceEnumMap[instance.source]!,
      'data': instance.data.toJson(),
    };

const _$MatchAuthorRoleEnumMap = {
  MatchAuthorRole.tableOfficial: 'tableOfficial',
  MatchAuthorRole.chiefReferee: 'chiefReferee',
  MatchAuthorRole.tournamentAdmin: 'tournamentAdmin',
};

const _$EventSourceEnumMap = {
  EventSource.screen: 'screen',
  EventSource.remote: 'remote',
};

MatchCreated _$MatchCreatedFromJson(Map<String, dynamic> json) => MatchCreated(
  config: MatchConfig.fromJson(json['config'] as Map<String, dynamic>),
  teamWhite: json['teamWhite'] as String,
  teamBlack: json['teamBlack'] as String,
  startingEnds:
      $enumDecodeNullable(_$StartingEndsEnumMap, json['startingEnds']) ??
      StartingEnds.whiteLeft,
  tournamentId: json['tournamentId'] as String?,
  fieldId: json['fieldId'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$MatchCreatedToJson(MatchCreated instance) =>
    <String, dynamic>{
      'config': instance.config.toJson(),
      'teamWhite': instance.teamWhite,
      'teamBlack': instance.teamBlack,
      'startingEnds': _$StartingEndsEnumMap[instance.startingEnds]!,
      'tournamentId': instance.tournamentId,
      'fieldId': instance.fieldId,
      'type': instance.$type,
    };

const _$StartingEndsEnumMap = {
  StartingEnds.whiteLeft: 'whiteLeft',
  StartingEnds.whiteRight: 'whiteRight',
};

RosterDeclared _$RosterDeclaredFromJson(Map<String, dynamic> json) =>
    RosterDeclared(
      team: $enumDecode(_$TeamColorEnumMap, json['team']),
      players: (json['players'] as List<dynamic>)
          .map((e) => MatchPlayer.fromJson(e as Map<String, dynamic>))
          .toList(),
      staff:
          (json['staff'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$RosterDeclaredToJson(RosterDeclared instance) =>
    <String, dynamic>{
      'team': _$TeamColorEnumMap[instance.team]!,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'staff': instance.staff,
      'type': instance.$type,
    };

const _$TeamColorEnumMap = {TeamColor.white: 'white', TeamColor.black: 'black'};

OfficialsAssigned _$OfficialsAssignedFromJson(Map<String, dynamic> json) =>
    OfficialsAssigned(
      chief: json['chief'] as String,
      water:
          (json['water'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      timekeepers:
          (json['timekeepers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OfficialsAssignedToJson(OfficialsAssigned instance) =>
    <String, dynamic>{
      'chief': instance.chief,
      'water': instance.water,
      'timekeepers': instance.timekeepers,
      'type': instance.$type,
    };

PeriodWarningGiven _$PeriodWarningGivenFromJson(Map<String, dynamic> json) =>
    PeriodWarningGiven(
      phase: $enumDecode(_$MatchPhaseEnumMap, json['phase']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$PeriodWarningGivenToJson(PeriodWarningGiven instance) =>
    <String, dynamic>{
      'phase': _$MatchPhaseEnumMap[instance.phase]!,
      'type': instance.$type,
    };

const _$MatchPhaseEnumMap = {
  MatchPhase.notStarted: 'notStarted',
  MatchPhase.p1: 'p1',
  MatchPhase.halfTime: 'halfTime',
  MatchPhase.p2: 'p2',
  MatchPhase.otBreak: 'otBreak',
  MatchPhase.ot1: 'ot1',
  MatchPhase.otInterval: 'otInterval',
  MatchPhase.ot2: 'ot2',
  MatchPhase.sdBreak: 'sdBreak',
  MatchPhase.suddenDeath: 'suddenDeath',
  MatchPhase.awaitingSignOff: 'awaitingSignOff',
  MatchPhase.finalized: 'finalized',
};

PlayStarted _$PlayStartedFromJson(Map<String, dynamic> json) => PlayStarted(
  restartType:
      $enumDecodeNullable(_$RestartTypeEnumMap, json['restartType']) ??
      RestartType.endLineStart,
  team: $enumDecodeNullable(_$TeamColorEnumMap, json['team']),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PlayStartedToJson(PlayStarted instance) =>
    <String, dynamic>{
      'restartType': _$RestartTypeEnumMap[instance.restartType]!,
      'team': _$TeamColorEnumMap[instance.team],
      'type': instance.$type,
    };

const _$RestartTypeEnumMap = {
  RestartType.endLineStart: 'endLineStart',
  RestartType.equalPuck: 'equalPuck',
  RestartType.advantagePuck: 'advantagePuck',
  RestartType.afterPenaltyShot: 'afterPenaltyShot',
  RestartType.afterTimeOut: 'afterTimeOut',
};

PlayStopped _$PlayStoppedFromJson(Map<String, dynamic> json) => PlayStopped(
  reason:
      $enumDecodeNullable(_$StopReasonEnumMap, json['reason']) ??
      StopReason.unspecified,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PlayStoppedToJson(PlayStopped instance) =>
    <String, dynamic>{
      'reason': _$StopReasonEnumMap[instance.reason]!,
      'type': instance.$type,
    };

const _$StopReasonEnumMap = {
  StopReason.unspecified: 'unspecified',
  StopReason.goal: 'goal',
  StopReason.infringement: 'infringement',
  StopReason.injury: 'injury',
  StopReason.confer: 'confer',
  StopReason.outOfBounds: 'outOfBounds',
  StopReason.penaltyShot: 'penaltyShot',
  StopReason.other: 'other',
};

StopReasonSpecified _$StopReasonSpecifiedFromJson(Map<String, dynamic> json) =>
    StopReasonSpecified(
      targetId: json['targetId'] as String,
      reason: $enumDecode(_$StopReasonEnumMap, json['reason']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$StopReasonSpecifiedToJson(
  StopReasonSpecified instance,
) => <String, dynamic>{
  'targetId': instance.targetId,
  'reason': _$StopReasonEnumMap[instance.reason]!,
  'type': instance.$type,
};

OfficialsTimeOutStarted _$OfficialsTimeOutStartedFromJson(
  Map<String, dynamic> json,
) => OfficialsTimeOutStarted(
  reason: json['reason'] as String?,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$OfficialsTimeOutStartedToJson(
  OfficialsTimeOutStarted instance,
) => <String, dynamic>{'reason': instance.reason, 'type': instance.$type};

TeamTimeOutRequested _$TeamTimeOutRequestedFromJson(
  Map<String, dynamic> json,
) => TeamTimeOutRequested(
  team: $enumDecode(_$TeamColorEnumMap, json['team']),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$TeamTimeOutRequestedToJson(
  TeamTimeOutRequested instance,
) => <String, dynamic>{
  'team': _$TeamColorEnumMap[instance.team]!,
  'type': instance.$type,
};

PeriodEnded _$PeriodEndedFromJson(Map<String, dynamic> json) => PeriodEnded(
  phase: $enumDecode(_$MatchPhaseEnumMap, json['phase']),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PeriodEndedToJson(PeriodEnded instance) =>
    <String, dynamic>{
      'phase': _$MatchPhaseEnumMap[instance.phase]!,
      'type': instance.$type,
    };

GoalScored _$GoalScoredFromJson(Map<String, dynamic> json) => GoalScored(
  team: $enumDecode(_$TeamColorEnumMap, json['team']),
  scorerCap: (json['scorerCap'] as num?)?.toInt(),
  kind: $enumDecodeNullable(_$GoalKindEnumMap, json['kind']) ?? GoalKind.field,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$GoalScoredToJson(GoalScored instance) =>
    <String, dynamic>{
      'team': _$TeamColorEnumMap[instance.team]!,
      'scorerCap': instance.scorerCap,
      'kind': _$GoalKindEnumMap[instance.kind]!,
      'type': instance.$type,
    };

const _$GoalKindEnumMap = {
  GoalKind.field: 'field',
  GoalKind.penaltyShot: 'penaltyShot',
  GoalKind.penaltyGoal: 'penaltyGoal',
};

CautionGiven _$CautionGivenFromJson(Map<String, dynamic> json) => CautionGiven(
  team: $enumDecode(_$TeamColorEnumMap, json['team']),
  cap: (json['cap'] as num?)?.toInt(),
  infringementCode: json['infringementCode'] as String,
  deliberate: json['deliberate'] as bool? ?? false,
  isTeamCaution: json['isTeamCaution'] as bool? ?? false,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$CautionGivenToJson(CautionGiven instance) =>
    <String, dynamic>{
      'team': _$TeamColorEnumMap[instance.team]!,
      'cap': instance.cap,
      'infringementCode': instance.infringementCode,
      'deliberate': instance.deliberate,
      'isTeamCaution': instance.isTeamCaution,
      'type': instance.$type,
    };

TimePenaltyGiven _$TimePenaltyGivenFromJson(Map<String, dynamic> json) =>
    TimePenaltyGiven(
      team: $enumDecode(_$TeamColorEnumMap, json['team']),
      cap: (json['cap'] as num).toInt(),
      minutes: (json['minutes'] as num).toInt(),
      infringementCode: json['infringementCode'] as String,
      deliberate: json['deliberate'] as bool? ?? false,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$TimePenaltyGivenToJson(TimePenaltyGiven instance) =>
    <String, dynamic>{
      'team': _$TeamColorEnumMap[instance.team]!,
      'cap': instance.cap,
      'minutes': instance.minutes,
      'infringementCode': instance.infringementCode,
      'deliberate': instance.deliberate,
      'type': instance.$type,
    };

PlayerDismissed _$PlayerDismissedFromJson(Map<String, dynamic> json) =>
    PlayerDismissed(
      team: $enumDecode(_$TeamColorEnumMap, json['team']),
      cap: (json['cap'] as num).toInt(),
      infringementCode: json['infringementCode'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$PlayerDismissedToJson(PlayerDismissed instance) =>
    <String, dynamic>{
      'team': _$TeamColorEnumMap[instance.team]!,
      'cap': instance.cap,
      'infringementCode': instance.infringementCode,
      'type': instance.$type,
    };

OfficialDismissed _$OfficialDismissedFromJson(Map<String, dynamic> json) =>
    OfficialDismissed(
      team: $enumDecode(_$TeamColorEnumMap, json['team']),
      name: json['name'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$OfficialDismissedToJson(OfficialDismissed instance) =>
    <String, dynamic>{
      'team': _$TeamColorEnumMap[instance.team]!,
      'name': instance.name,
      'type': instance.$type,
    };

PenaltyShotAwarded _$PenaltyShotAwardedFromJson(Map<String, dynamic> json) =>
    PenaltyShotAwarded(
      againstTeam: $enumDecode(_$TeamColorEnumMap, json['againstTeam']),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$PenaltyShotAwardedToJson(PenaltyShotAwarded instance) =>
    <String, dynamic>{
      'againstTeam': _$TeamColorEnumMap[instance.againstTeam]!,
      'type': instance.$type,
    };

PenaltyShotResolved _$PenaltyShotResolvedFromJson(Map<String, dynamic> json) =>
    PenaltyShotResolved(
      outcome: $enumDecode(_$PenaltyShotOutcomeEnumMap, json['outcome']),
      attackers:
          (json['attackers'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const <int>[],
      defender: (json['defender'] as num?)?.toInt(),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$PenaltyShotResolvedToJson(
  PenaltyShotResolved instance,
) => <String, dynamic>{
  'outcome': _$PenaltyShotOutcomeEnumMap[instance.outcome]!,
  'attackers': instance.attackers,
  'defender': instance.defender,
  'type': instance.$type,
};

const _$PenaltyShotOutcomeEnumMap = {
  PenaltyShotOutcome.goal: 'goal',
  PenaltyShotOutcome.defended: 'defended',
};

PenaltyPlayerReturned _$PenaltyPlayerReturnedFromJson(
  Map<String, dynamic> json,
) => PenaltyPlayerReturned(
  team: $enumDecode(_$TeamColorEnumMap, json['team']),
  cap: (json['cap'] as num).toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$PenaltyPlayerReturnedToJson(
  PenaltyPlayerReturned instance,
) => <String, dynamic>{
  'team': _$TeamColorEnumMap[instance.team]!,
  'cap': instance.cap,
  'type': instance.$type,
};

ProtestLogged _$ProtestLoggedFromJson(Map<String, dynamic> json) =>
    ProtestLogged(
      team: $enumDecode(_$TeamColorEnumMap, json['team']),
      by: json['by'] as String,
      text: json['text'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ProtestLoggedToJson(ProtestLogged instance) =>
    <String, dynamic>{
      'team': _$TeamColorEnumMap[instance.team]!,
      'by': instance.by,
      'text': instance.text,
      'type': instance.$type,
    };

EventVoided _$EventVoidedFromJson(Map<String, dynamic> json) => EventVoided(
  targetId: json['targetId'] as String,
  reason: json['reason'] as String? ?? '',
  $type: json['type'] as String?,
);

Map<String, dynamic> _$EventVoidedToJson(EventVoided instance) =>
    <String, dynamic>{
      'targetId': instance.targetId,
      'reason': instance.reason,
      'type': instance.$type,
    };

MatchEndedBySignOff _$MatchEndedBySignOffFromJson(Map<String, dynamic> json) =>
    MatchEndedBySignOff(
      chiefSignature: json['chiefSignature'] as String,
      waterSignatures:
          (json['waterSignatures'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MatchEndedBySignOffToJson(
  MatchEndedBySignOff instance,
) => <String, dynamic>{
  'chiefSignature': instance.chiefSignature,
  'waterSignatures': instance.waterSignatures,
  'type': instance.$type,
};

ResultDecidedByDelegate _$ResultDecidedByDelegateFromJson(
  Map<String, dynamic> json,
) => ResultDecidedByDelegate(
  winner: $enumDecodeNullable(_$TeamColorEnumMap, json['winner']),
  text: json['text'] as String,
  $type: json['type'] as String?,
);

Map<String, dynamic> _$ResultDecidedByDelegateToJson(
  ResultDecidedByDelegate instance,
) => <String, dynamic>{
  'winner': _$TeamColorEnumMap[instance.winner],
  'text': instance.text,
  'type': instance.$type,
};

MatchForfeited _$MatchForfeitedFromJson(Map<String, dynamic> json) =>
    MatchForfeited(
      team: $enumDecode(_$TeamColorEnumMap, json['team']),
      decisionText: json['decisionText'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MatchForfeitedToJson(MatchForfeited instance) =>
    <String, dynamic>{
      'team': _$TeamColorEnumMap[instance.team]!,
      'decisionText': instance.decisionText,
      'type': instance.$type,
    };

MatchAbandoned _$MatchAbandonedFromJson(Map<String, dynamic> json) =>
    MatchAbandoned(
      decisionText: json['decisionText'] as String,
      resultOverride: json['resultOverride'] == null
          ? null
          : MatchScore.fromJson(json['resultOverride'] as Map<String, dynamic>),
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$MatchAbandonedToJson(MatchAbandoned instance) =>
    <String, dynamic>{
      'decisionText': instance.decisionText,
      'resultOverride': instance.resultOverride?.toJson(),
      'type': instance.$type,
    };
