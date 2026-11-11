// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchConfig _$MatchConfigFromJson(Map<String, dynamic> json) => _MatchConfig(
  periodLength: json['periodLength'] == null
      ? const Duration(minutes: 15)
      : const DurationMillisConverter().fromJson(
          (json['periodLength'] as num).toInt(),
        ),
  halfTimeBreak: json['halfTimeBreak'] == null
      ? const Duration(minutes: 3)
      : const DurationMillisConverter().fromJson(
          (json['halfTimeBreak'] as num).toInt(),
        ),
  requiresWinner: json['requiresWinner'] as bool? ?? false,
  overtimeBreak: json['overtimeBreak'] == null
      ? const Duration(minutes: 3)
      : const DurationMillisConverter().fromJson(
          (json['overtimeBreak'] as num).toInt(),
        ),
  overtimePeriod: json['overtimePeriod'] == null
      ? const Duration(minutes: 5)
      : const DurationMillisConverter().fromJson(
          (json['overtimePeriod'] as num).toInt(),
        ),
  overtimeInterval: json['overtimeInterval'] == null
      ? const Duration(minutes: 1)
      : const DurationMillisConverter().fromJson(
          (json['overtimeInterval'] as num).toInt(),
        ),
  suddenDeathBreak: json['suddenDeathBreak'] == null
      ? const Duration(minutes: 1)
      : const DurationMillisConverter().fromJson(
          (json['suddenDeathBreak'] as num).toInt(),
        ),
  stoppedClockWindow: json['stoppedClockWindow'] == null
      ? const Duration(minutes: 2)
      : const DurationMillisConverter().fromJson(
          (json['stoppedClockWindow'] as num).toInt(),
        ),
  teamTimeOutLength: json['teamTimeOutLength'] == null
      ? const Duration(minutes: 1)
      : const DurationMillisConverter().fromJson(
          (json['teamTimeOutLength'] as num).toInt(),
        ),
  timeOutWarningAt: json['timeOutWarningAt'] == null
      ? const Duration(seconds: 45)
      : const DurationMillisConverter().fromJson(
          (json['timeOutWarningAt'] as num).toInt(),
        ),
  periodStartWarning: json['periodStartWarning'] == null
      ? const Duration(seconds: 30)
      : const DurationMillisConverter().fromJson(
          (json['periodStartWarning'] as num).toInt(),
        ),
  goalRestartMax: json['goalRestartMax'] == null
      ? const Duration(seconds: 30)
      : const DurationMillisConverter().fromJson(
          (json['goalRestartMax'] as num).toInt(),
        ),
  timeOutsPerTeamPerHalf:
      (json['timeOutsPerTeamPerHalf'] as num?)?.toInt() ?? 1,
  penaltyClockPolicy:
      $enumDecodeNullable(
        _$PenaltyClockPolicyEnumMap,
        json['penaltyClockPolicy'],
      ) ??
      PenaltyClockPolicy.matchClockOnly,
  rulesVersion: json['rulesVersion'] as String? ?? 'CMAS-13.0',
  stoppedClockPhases:
      (json['stoppedClockPhases'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$MatchPhaseEnumMap, e))
          .toSet() ??
      const {MatchPhase.p2, MatchPhase.ot2, MatchPhase.suddenDeath},
  overtimePeriods: (json['overtimePeriods'] as num?)?.toInt() ?? 2,
  suddenDeathEnabled: json['suddenDeathEnabled'] as bool? ?? true,
  presetName: json['presetName'] as String? ?? 'CMAS standaard',
);

Map<String, dynamic> _$MatchConfigToJson(
  _MatchConfig instance,
) => <String, dynamic>{
  'periodLength': const DurationMillisConverter().toJson(instance.periodLength),
  'halfTimeBreak': const DurationMillisConverter().toJson(
    instance.halfTimeBreak,
  ),
  'requiresWinner': instance.requiresWinner,
  'overtimeBreak': const DurationMillisConverter().toJson(
    instance.overtimeBreak,
  ),
  'overtimePeriod': const DurationMillisConverter().toJson(
    instance.overtimePeriod,
  ),
  'overtimeInterval': const DurationMillisConverter().toJson(
    instance.overtimeInterval,
  ),
  'suddenDeathBreak': const DurationMillisConverter().toJson(
    instance.suddenDeathBreak,
  ),
  'stoppedClockWindow': const DurationMillisConverter().toJson(
    instance.stoppedClockWindow,
  ),
  'teamTimeOutLength': const DurationMillisConverter().toJson(
    instance.teamTimeOutLength,
  ),
  'timeOutWarningAt': const DurationMillisConverter().toJson(
    instance.timeOutWarningAt,
  ),
  'periodStartWarning': const DurationMillisConverter().toJson(
    instance.periodStartWarning,
  ),
  'goalRestartMax': const DurationMillisConverter().toJson(
    instance.goalRestartMax,
  ),
  'timeOutsPerTeamPerHalf': instance.timeOutsPerTeamPerHalf,
  'penaltyClockPolicy':
      _$PenaltyClockPolicyEnumMap[instance.penaltyClockPolicy]!,
  'rulesVersion': instance.rulesVersion,
  'stoppedClockPhases': instance.stoppedClockPhases
      .map((e) => _$MatchPhaseEnumMap[e]!)
      .toList(),
  'overtimePeriods': instance.overtimePeriods,
  'suddenDeathEnabled': instance.suddenDeathEnabled,
  'presetName': instance.presetName,
};

const _$PenaltyClockPolicyEnumMap = {
  PenaltyClockPolicy.matchClockOnly: 'matchClockOnly',
  PenaltyClockPolicy.wallClock: 'wallClock',
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
