// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrainingNodeGroup _$TrainingNodeGroupFromJson(Map<String, dynamic> json) =>
    TrainingNodeGroup(
      group: TrainingGroup.fromJson(json['group'] as Map<String, dynamic>),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$TrainingNodeGroupToJson(TrainingNodeGroup instance) =>
    <String, dynamic>{
      'group': instance.group.toJson(),
      'runtimeType': instance.$type,
    };

TrainingNodeExercise _$TrainingNodeExerciseFromJson(
  Map<String, dynamic> json,
) => TrainingNodeExercise(
  exercise: TrainingExercise.fromJson(json['exercise'] as Map<String, dynamic>),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$TrainingNodeExerciseToJson(
  TrainingNodeExercise instance,
) => <String, dynamic>{
  'exercise': instance.exercise.toJson(),
  'runtimeType': instance.$type,
};
