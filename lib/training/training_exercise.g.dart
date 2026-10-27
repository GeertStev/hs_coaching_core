// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingExercise _$TrainingExerciseFromJson(Map<String, dynamic> json) =>
    _TrainingExercise(
      id: json['id'] as String,
      title: json['title'] as String,
      repeatCount: (json['repeatCount'] as num?)?.toInt() ?? 1,
      groups:
          (json['groups'] as List<dynamic>?)
              ?.map(
                (e) =>
                    TrainingExerciseGroup.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <TrainingExerciseGroup>[],
    );

Map<String, dynamic> _$TrainingExerciseToJson(_TrainingExercise instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'repeatCount': instance.repeatCount,
      'groups': instance.groups.map((e) => e.toJson()).toList(),
    };
