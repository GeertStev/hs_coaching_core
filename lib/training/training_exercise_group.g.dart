// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_exercise_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingExerciseGroup _$TrainingExerciseGroupFromJson(
  Map<String, dynamic> json,
) => _TrainingExerciseGroup(
  id: json['id'] as String,
  name: json['name'] as String? ?? '',
  parameterRows:
      (json['parameterRows'] as List<dynamic>?)
          ?.map((e) => TrainingParameterRow.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TrainingParameterRow>[],
  workSeconds: (json['workSeconds'] as num?)?.toInt() ?? 0,
  restSeconds: (json['restSeconds'] as num?)?.toInt() ?? 0,
  deltaSeconds: (json['deltaSeconds'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$TrainingExerciseGroupToJson(
  _TrainingExerciseGroup instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'parameterRows': instance.parameterRows.map((e) => e.toJson()).toList(),
  'workSeconds': instance.workSeconds,
  'restSeconds': instance.restSeconds,
  'deltaSeconds': instance.deltaSeconds,
};
