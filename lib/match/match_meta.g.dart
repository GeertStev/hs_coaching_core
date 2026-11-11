// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchLease _$MatchLeaseFromJson(Map<String, dynamic> json) => _MatchLease(
  deviceId: json['deviceId'] as String,
  sinceMillis: (json['sinceMillis'] as num).toInt(),
);

Map<String, dynamic> _$MatchLeaseToJson(_MatchLease instance) =>
    <String, dynamic>{
      'deviceId': instance.deviceId,
      'sinceMillis': instance.sinceMillis,
    };

_MatchMeta _$MatchMetaFromJson(Map<String, dynamic> json) => _MatchMeta(
  createdAtMillis: (json['createdAtMillis'] as num).toInt(),
  tournamentId: json['tournamentId'] as String?,
  fieldId: json['fieldId'] as String?,
  lease: json['lease'] == null
      ? null
      : MatchLease.fromJson(json['lease'] as Map<String, dynamic>),
  liveFieldId: json['liveFieldId'] as String?,
);

Map<String, dynamic> _$MatchMetaToJson(_MatchMeta instance) =>
    <String, dynamic>{
      'createdAtMillis': instance.createdAtMillis,
      'tournamentId': instance.tournamentId,
      'fieldId': instance.fieldId,
      'lease': instance.lease?.toJson(),
      'liveFieldId': instance.liveFieldId,
    };
