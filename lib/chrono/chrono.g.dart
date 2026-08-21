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
  laps:
      (json['laps'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const <int>[],
);

Map<String, dynamic> _$ChronoToJson(_Chrono instance) => <String, dynamic>{
  'status': _$ChronoStatusEnumMap[instance.status]!,
  'authoritativeStartTimeMillis': instance.authoritativeStartTimeMillis,
  'accumulatedElapsedMillis': instance.accumulatedElapsedMillis,
  'laps': instance.laps,
};

const _$ChronoStatusEnumMap = {
  ChronoStatus.stopped: 'stopped',
  ChronoStatus.running: 'running',
  ChronoStatus.paused: 'paused',
};
