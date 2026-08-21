// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tabata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Tabata _$TabataFromJson(Map<String, dynamic> json) => _Tabata(
  prepareSeconds: (json['prepareSeconds'] as num?)?.toInt() ?? 10,
  workSeconds: (json['workSeconds'] as num?)?.toInt() ?? 20,
  restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 10,
  stepSeconds: (json['stepSeconds'] as num?)?.toInt() ?? 0,
  rounds: (json['rounds'] as num?)?.toInt() ?? 8,
  sets: (json['sets'] as num?)?.toInt() ?? 1,
  restBetweenSets: (json['restBetweenSets'] as num?)?.toInt() ?? 0,
  status:
      $enumDecodeNullable(_$TabataStatusEnumMap, json['status']) ??
      TabataStatus.stopped,
  authoritativeStartTimeMillis:
      (json['authoritativeStartTimeMillis'] as num?)?.toInt() ?? 0,
  accumulatedElapsedMillis:
      (json['accumulatedElapsedMillis'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TabataToJson(_Tabata instance) => <String, dynamic>{
  'prepareSeconds': instance.prepareSeconds,
  'workSeconds': instance.workSeconds,
  'restSeconds': instance.restSeconds,
  'stepSeconds': instance.stepSeconds,
  'rounds': instance.rounds,
  'sets': instance.sets,
  'restBetweenSets': instance.restBetweenSets,
  'status': _$TabataStatusEnumMap[instance.status]!,
  'authoritativeStartTimeMillis': instance.authoritativeStartTimeMillis,
  'accumulatedElapsedMillis': instance.accumulatedElapsedMillis,
};

const _$TabataStatusEnumMap = {
  TabataStatus.stopped: 'stopped',
  TabataStatus.running: 'running',
  TabataStatus.paused: 'paused',
};
