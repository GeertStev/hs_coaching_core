// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduler_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SquadPlayer _$SquadPlayerFromJson(Map<String, dynamic> json) => _SquadPlayer(
  firstName: json['firstName'] as String,
  surname: json['surname'] as String? ?? '',
  nickname: json['nickname'] as String? ?? '',
  totem: json['totem'] as String? ?? '',
  active: json['active'] as bool? ?? true,
  positions:
      (json['positions'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$PlayerPositionEnumMap, e))
          .toList() ??
      const <PlayerPosition>[],
  startRatings:
      (json['startRatings'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          $enumDecode(_$PlayerPositionEnumMap, k),
          (e as num).toInt(),
        ),
      ) ??
      const <PlayerPosition, int>{},
  uid: json['uid'] as String?,
);

Map<String, dynamic> _$SquadPlayerToJson(_SquadPlayer instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'surname': instance.surname,
      'nickname': instance.nickname,
      'totem': instance.totem,
      'active': instance.active,
      'positions': instance.positions
          .map((e) => _$PlayerPositionEnumMap[e]!)
          .toList(),
      'startRatings': instance.startRatings.map(
        (k, e) => MapEntry(_$PlayerPositionEnumMap[k]!, e),
      ),
      'uid': instance.uid,
    };

const _$PlayerPositionEnumMap = {
  PlayerPosition.forward: 'F',
  PlayerPosition.center: 'C',
  PlayerPosition.wing: 'W',
  PlayerPosition.goalie: 'G',
};

_RatingAdjustment _$RatingAdjustmentFromJson(Map<String, dynamic> json) =>
    _RatingAdjustment(
      playerId: json['playerId'] as String,
      type: $enumDecode(_$RatingAdjustmentTypeEnumMap, json['type']),
      start: json['start'] as String,
      end: json['end'] as String,
      change: (json['change'] as num).toDouble(),
      reason: json['reason'] as String? ?? '',
    );

Map<String, dynamic> _$RatingAdjustmentToJson(_RatingAdjustment instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'type': _$RatingAdjustmentTypeEnumMap[instance.type]!,
      'start': instance.start,
      'end': instance.end,
      'change': instance.change,
      'reason': instance.reason,
    };

const _$RatingAdjustmentTypeEnumMap = {
  RatingAdjustmentType.instant: 'instant',
  RatingAdjustmentType.linear: 'linear',
};

_LineupEntry _$LineupEntryFromJson(Map<String, dynamic> json) => _LineupEntry(
  playerId: json['playerId'] as String,
  position: $enumDecode(_$PlayerPositionEnumMap, json['position']),
);

Map<String, dynamic> _$LineupEntryToJson(_LineupEntry instance) =>
    <String, dynamic>{
      'playerId': instance.playerId,
      'position': _$PlayerPositionEnumMap[instance.position]!,
    };

_GameSide _$GameSideFromJson(Map<String, dynamic> json) => _GameSide(
  composition: json['composition'] as String? ?? '',
  score: (json['score'] as num).toInt(),
  base:
      (json['base'] as List<dynamic>?)
          ?.map((e) => LineupEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LineupEntry>[],
  subs:
      (json['subs'] as List<dynamic>?)
          ?.map((e) => LineupEntry.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <LineupEntry>[],
);

Map<String, dynamic> _$GameSideToJson(_GameSide instance) => <String, dynamic>{
  'composition': instance.composition,
  'score': instance.score,
  'base': instance.base.map((e) => e.toJson()).toList(),
  'subs': instance.subs.map((e) => e.toJson()).toList(),
};

_PracticeGame _$PracticeGameFromJson(Map<String, dynamic> json) =>
    _PracticeGame(
      date: json['date'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      white: GameSide.fromJson(json['white'] as Map<String, dynamic>),
      black: GameSide.fromJson(json['black'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PracticeGameToJson(_PracticeGame instance) =>
    <String, dynamic>{
      'date': instance.date,
      'durationMinutes': instance.durationMinutes,
      'white': instance.white.toJson(),
      'black': instance.black.toJson(),
    };

_TeamComposition _$TeamCompositionFromJson(Map<String, dynamic> json) =>
    _TeamComposition(
      name: json['name'] as String,
      slots: (json['slots'] as List<dynamic>)
          .map((e) => $enumDecode(_$PlayerPositionEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$TeamCompositionToJson(_TeamComposition instance) =>
    <String, dynamic>{
      'name': instance.name,
      'slots': instance.slots.map((e) => _$PlayerPositionEnumMap[e]!).toList(),
    };
