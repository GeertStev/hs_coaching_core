// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chrono.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Chrono _$ChronoFromJson(Map<String, dynamic> json) => _Chrono(
  status:
      $enumDecodeNullable(_$ChronoStatusEnumMap, json['status']) ??
      ChronoStatus.stopped,
  authoritativeStartTimeMillis:
      (json['authoritativeStartTimeMillis'] as num?)?.toInt() ?? 0,
  accumulatedElapsedMillis:
      (json['accumulatedElapsedMillis'] as num?)?.toInt() ?? 0,
  lapTimes:
      (json['lapTimes'] as List<dynamic>?)
          ?.map((e) => ChronoLap.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <ChronoLap>[],
  maxLaps: (json['maxLaps'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChronoToJson(_Chrono instance) => <String, dynamic>{
  'status': _$ChronoStatusEnumMap[instance.status]!,
  'authoritativeStartTimeMillis': instance.authoritativeStartTimeMillis,
  'accumulatedElapsedMillis': instance.accumulatedElapsedMillis,
  'lapTimes': instance.lapTimes.map((e) => e.toJson()).toList(),
  'maxLaps': instance.maxLaps,
};

const _$ChronoStatusEnumMap = {
  ChronoStatus.stopped: 'stopped',
  ChronoStatus.running: 'running',
  ChronoStatus.paused: 'paused',
};

_ChronoLap _$ChronoLapFromJson(Map<String, dynamic> json) => _ChronoLap(
  elapsedMillis: (json['elapsedMillis'] as num).toInt(),
  lane: (json['lane'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChronoLapToJson(_ChronoLap instance) =>
    <String, dynamic>{
      'elapsedMillis': instance.elapsedMillis,
      'lane': instance.lane,
    };
