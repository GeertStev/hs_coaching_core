import 'package:freezed_annotation/freezed_annotation.dart';

part 'chrono.freezed.dart';
part 'chrono.g.dart';

enum ChronoStatus { stopped, running, paused }

@freezed
abstract class Chrono with _$Chrono {
  @JsonSerializable(explicitToJson: true)
  const factory Chrono({
    @Default(ChronoStatus.stopped) ChronoStatus status,

    /// Start moment, expressed in RTDB server-clock milliseconds (see
    /// `serverNowMillis` in `core/providers/server_time_offset_provider.dart`)
    /// so every reader/writer agrees on it regardless of local clock drift.
    @Default(0) int authoritativeStartTimeMillis,

    /// Time accumulated before the current running session.
    @Default(0) int accumulatedElapsedMillis,

    /// Opgenomen tijden: de Lap-knop in de app (zonder baan) en de
    /// baanknoppen (met baan), in één lijst. Volgorde in Firestore is
    /// aankomstvolgorde; sorteer via `chronoLapRows` (chrono_laps.dart).
    ///
    /// Nieuwe veldnaam: het oude `laps` (lijst van ints) wordt genegeerd.
    @Default(<ChronoLap>[]) List<ChronoLap> lapTimes,

    /// Maximum aantal laps per baan (en voor de Lap-knop), ingesteld door de
    /// coach. De laatste is de finale tijd, de andere zijn tussentijden;
    /// verdere drukken op die baan tellen niet. Null = geen maximum.
    int? maxLaps,
  }) = _Chrono;

  factory Chrono.fromJson(Map<String, dynamic> json) => _$ChronoFromJson(json);
}

/// Eén opgenomen tijd.
///
/// [lane] is null voor de Lap-knop, anders het baannummer (1 = toets A).
/// Later kan een speler aan een baan gekoppeld worden; dan volstaat het om
/// de baan van elke tijd op te zoeken, zonder dit model te wijzigen.
@freezed
abstract class ChronoLap with _$ChronoLap {
  const factory ChronoLap({
    /// Totale verstreken chrono-tijd op het moment van de druk.
    required int elapsedMillis,
    int? lane,
  }) = _ChronoLap;

  factory ChronoLap.fromJson(Map<String, dynamic> json) =>
      _$ChronoLapFromJson(json);
}
