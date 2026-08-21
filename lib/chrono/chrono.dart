import 'package:freezed_annotation/freezed_annotation.dart';

part 'chrono.freezed.dart';
part 'chrono.g.dart';

enum ChronoStatus { stopped, running, paused }

@freezed
abstract class Chrono with _$Chrono {
  const factory Chrono({
    @Default(ChronoStatus.stopped) ChronoStatus status,

    /// Start moment, expressed in RTDB server-clock milliseconds (see
    /// `serverNowMillis` in `core/providers/server_time_offset_provider.dart`)
    /// so every reader/writer agrees on it regardless of local clock drift.
    @Default(0) int authoritativeStartTimeMillis,

    /// Time accumulated before the current running session.
    @Default(0) int accumulatedElapsedMillis,

    /// Lijst met rondetijden (opgeslagen als geaccumuleerde verstreken tijd in millis)
    @Default(<int>[]) List<int> laps,
  }) = _Chrono;

  factory Chrono.fromJson(Map<String, dynamic> json) => _$ChronoFromJson(json);
}
