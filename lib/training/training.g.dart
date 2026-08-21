// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Training _$TrainingFromJson(Map<String, dynamic> json) => _Training(
  children:
      (json['children'] as List<dynamic>?)
          ?.map((e) => TrainingNode.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TrainingNode>[],
  status:
      $enumDecodeNullable(_$TrainingStatusEnumMap, json['status']) ??
      TrainingStatus.idle,
  authoritativeStartTimeMillis:
      (json['authoritativeStartTimeMillis'] as num?)?.toInt() ?? 0,
  accumulatedElapsedMillis:
      (json['accumulatedElapsedMillis'] as num?)?.toInt() ?? 0,
  currentPath:
      (json['currentPath'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
  currentGroupIndex: (json['currentGroupIndex'] as num?)?.toInt() ?? 0,
  currentPhase:
      $enumDecodeNullable(_$TrainingStepPhaseEnumMap, json['currentPhase']) ??
      TrainingStepPhase.work,
);

Map<String, dynamic> _$TrainingToJson(_Training instance) => <String, dynamic>{
  'children': instance.children.map((e) => e.toJson()).toList(),
  'status': _$TrainingStatusEnumMap[instance.status]!,
  'authoritativeStartTimeMillis': instance.authoritativeStartTimeMillis,
  'accumulatedElapsedMillis': instance.accumulatedElapsedMillis,
  'currentPath': instance.currentPath,
  'currentGroupIndex': instance.currentGroupIndex,
  'currentPhase': _$TrainingStepPhaseEnumMap[instance.currentPhase]!,
};

const _$TrainingStatusEnumMap = {
  TrainingStatus.idle: 'idle',
  TrainingStatus.running: 'running',
  TrainingStatus.paused: 'paused',
  TrainingStatus.finished: 'finished',
};

const _$TrainingStepPhaseEnumMap = {
  TrainingStepPhase.work: 'work',
  TrainingStepPhase.rest: 'rest',
};
