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
  currentStepIndex: (json['currentStepIndex'] as num?)?.toInt() ?? -1,
);

Map<String, dynamic> _$TrainingToJson(_Training instance) => <String, dynamic>{
  'children': instance.children.map((e) => e.toJson()).toList(),
  'status': _$TrainingStatusEnumMap[instance.status]!,
  'authoritativeStartTimeMillis': instance.authoritativeStartTimeMillis,
  'accumulatedElapsedMillis': instance.accumulatedElapsedMillis,
  'currentStepIndex': instance.currentStepIndex,
};

const _$TrainingStatusEnumMap = {
  TrainingStatus.idle: 'idle',
  TrainingStatus.running: 'running',
  TrainingStatus.paused: 'paused',
  TrainingStatus.finished: 'finished',
};
