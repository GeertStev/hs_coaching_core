// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduler_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SchedulerConfig _$SchedulerConfigFromJson(
  Map<String, dynamic> json,
) => _SchedulerConfig(
  gameMinutes: (json['gameMinutes'] as num?)?.toInt() ?? 30,
  blockedThreshold: (json['blockedThreshold'] as num?)?.toDouble() ?? 100000,
  noRatingPenalty: (json['noRatingPenalty'] as num?)?.toDouble() ?? 10000,
  scarcePositionBonus:
      (json['scarcePositionBonus'] as num?)?.toDouble() ?? 2000,
  scarcePositionMargin: (json['scarcePositionMargin'] as num?)?.toInt() ?? 1,
  reservedSlotPenalty:
      (json['reservedSlotPenalty'] as num?)?.toDouble() ?? 10000,
  candidateCutoff: (json['candidateCutoff'] as num?)?.toDouble() ?? -5000,
  experienceMinutes: (json['experienceMinutes'] as num?)?.toDouble() ?? 6000,
  playtimeOffset: (json['playtimeOffset'] as num?)?.toDouble() ?? 0.01,
);

Map<String, dynamic> _$SchedulerConfigToJson(_SchedulerConfig instance) =>
    <String, dynamic>{
      'gameMinutes': instance.gameMinutes,
      'blockedThreshold': instance.blockedThreshold,
      'noRatingPenalty': instance.noRatingPenalty,
      'scarcePositionBonus': instance.scarcePositionBonus,
      'scarcePositionMargin': instance.scarcePositionMargin,
      'reservedSlotPenalty': instance.reservedSlotPenalty,
      'candidateCutoff': instance.candidateCutoff,
      'experienceMinutes': instance.experienceMinutes,
      'playtimeOffset': instance.playtimeOffset,
    };
