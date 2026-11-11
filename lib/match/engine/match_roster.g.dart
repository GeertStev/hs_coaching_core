// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_roster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MatchPlayer _$MatchPlayerFromJson(Map<String, dynamic> json) => _MatchPlayer(
  cap: (json['cap'] as num).toInt(),
  name: json['name'] as String,
  role:
      $enumDecodeNullable(_$MatchPlayerRoleEnumMap, json['role']) ??
      MatchPlayerRole.none,
  playerId: json['playerId'] as String?,
);

Map<String, dynamic> _$MatchPlayerToJson(_MatchPlayer instance) =>
    <String, dynamic>{
      'cap': instance.cap,
      'name': instance.name,
      'role': _$MatchPlayerRoleEnumMap[instance.role]!,
      'playerId': instance.playerId,
    };

const _$MatchPlayerRoleEnumMap = {
  MatchPlayerRole.none: 'none',
  MatchPlayerRole.captain: 'captain',
  MatchPlayerRole.viceCaptain: 'viceCaptain',
};
