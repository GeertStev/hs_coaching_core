// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sketch_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SketchSettings _$SketchSettingsFromJson(Map<String, dynamic> json) =>
    _SketchSettings(
      currentId: json['currentId'] as String?,
      sketchTags:
          (json['sketchTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      backgrounds:
          (json['backgrounds'] as List<dynamic>?)
              ?.map((e) => SketchBackground.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <SketchBackground>[],
    );

Map<String, dynamic> _$SketchSettingsToJson(_SketchSettings instance) =>
    <String, dynamic>{
      'currentId': instance.currentId,
      'sketchTags': instance.sketchTags,
      'backgrounds': instance.backgrounds.map((e) => e.toJson()).toList(),
    };
