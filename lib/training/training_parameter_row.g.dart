// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_parameter_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingParameterRow _$TrainingParameterRowFromJson(
  Map<String, dynamic> json,
) => _TrainingParameterRow(
  id: json['id'] as String,
  reps: (json['reps'] as num?)?.toInt(),
  distance: (json['distance'] as num?)?.toInt(),
  stroke: json['stroke'] as String?,
  intensity: (json['intensity'] as num?)?.toInt(),
  zone: json['zone'] as String?,
);

Map<String, dynamic> _$TrainingParameterRowToJson(
  _TrainingParameterRow instance,
) => <String, dynamic>{
  'id': instance.id,
  'reps': instance.reps,
  'distance': instance.distance,
  'stroke': instance.stroke,
  'intensity': instance.intensity,
  'zone': instance.zone,
};
