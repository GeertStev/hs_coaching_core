// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RankTier _$RankTierFromJson(Map<String, dynamic> json) => _RankTier(
  threshold: (json['threshold'] as num).toInt(),
  name: json['name'] as String,
  multiplier: (json['multiplier'] as num).toDouble(),
);

Map<String, dynamic> _$RankTierToJson(_RankTier instance) => <String, dynamic>{
  'threshold': instance.threshold,
  'name': instance.name,
  'multiplier': instance.multiplier,
};

_RatingConfig _$RatingConfigFromJson(Map<String, dynamic> json) =>
    _RatingConfig(
      eloScale: (json['eloScale'] as num?)?.toDouble() ?? 400,
      fatiguePerMinute: (json['fatiguePerMinute'] as num?)?.toDouble() ?? 0.99,
      teamRatingDivisor: (json['teamRatingDivisor'] as num?)?.toDouble() ?? 6,
      referenceDurationMinutes:
          (json['referenceDurationMinutes'] as num?)?.toDouble() ?? 30,
      relevanceOffset: (json['relevanceOffset'] as num?)?.toInt() ?? 11,
      relevanceCap: (json['relevanceCap'] as num?)?.toInt() ?? 10,
      relevanceCounting:
          $enumDecodeNullable(
            _$RelevanceCountingEnumMap,
            json['relevanceCounting'],
          ) ??
          RelevanceCounting.allGames,
      crossPositionWinShare:
          (json['crossPositionWinShare'] as num?)?.toDouble() ?? 0.25,
      crossPositionLossShare:
          (json['crossPositionLossShare'] as num?)?.toDouble() ?? 0.1,
      crossPositionFloorRating:
          (json['crossPositionFloorRating'] as num?)?.toDouble() ?? 1000,
      streakWindow: (json['streakWindow'] as num?)?.toInt() ?? 25,
      streakHighShare: (json['streakHighShare'] as num?)?.toDouble() ?? 0.65,
      streakLowShare: (json['streakLowShare'] as num?)?.toDouble() ?? 0.35,
      streakBonus: (json['streakBonus'] as num?)?.toDouble() ?? 10,
      timelineStart: json['timelineStart'] as String?,
      rankTiers:
          (json['rankTiers'] as List<dynamic>?)
              ?.map((e) => RankTier.fromJson(e as Map<String, dynamic>))
              .toList() ??
          defaultRankTiers,
    );

Map<String, dynamic> _$RatingConfigToJson(
  _RatingConfig instance,
) => <String, dynamic>{
  'eloScale': instance.eloScale,
  'fatiguePerMinute': instance.fatiguePerMinute,
  'teamRatingDivisor': instance.teamRatingDivisor,
  'referenceDurationMinutes': instance.referenceDurationMinutes,
  'relevanceOffset': instance.relevanceOffset,
  'relevanceCap': instance.relevanceCap,
  'relevanceCounting': _$RelevanceCountingEnumMap[instance.relevanceCounting]!,
  'crossPositionWinShare': instance.crossPositionWinShare,
  'crossPositionLossShare': instance.crossPositionLossShare,
  'crossPositionFloorRating': instance.crossPositionFloorRating,
  'streakWindow': instance.streakWindow,
  'streakHighShare': instance.streakHighShare,
  'streakLowShare': instance.streakLowShare,
  'streakBonus': instance.streakBonus,
  'timelineStart': instance.timelineStart,
  'rankTiers': instance.rankTiers.map((e) => e.toJson()).toList(),
};

const _$RelevanceCountingEnumMap = {
  RelevanceCounting.allGames: 'allGames',
  RelevanceCounting.gamesSoFar: 'gamesSoFar',
};
