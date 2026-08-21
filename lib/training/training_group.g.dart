// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TrainingGroup _$TrainingGroupFromJson(Map<String, dynamic> json) =>
    _TrainingGroup(
      id: json['id'] as String,
      title: json['title'] as String?,
      repeatCount: (json['repeatCount'] as num?)?.toInt() ?? 1,
      children:
          (json['children'] as List<dynamic>?)
              ?.map((e) => TrainingNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TrainingNode>[],
    );

Map<String, dynamic> _$TrainingGroupToJson(_TrainingGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'repeatCount': instance.repeatCount,
      'children': instance.children.map((e) => e.toJson()).toList(),
    };
