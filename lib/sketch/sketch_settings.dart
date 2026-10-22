import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/sketch/sketch_background.dart';

part 'sketch_settings.freezed.dart';
part 'sketch_settings.g.dart';

/// Het `settings/sketch` document: welke sketch live staat ([currentId]),
/// alle ooit gebruikte tags en de beschikbare achtergronden.
@freezed
abstract class SketchSettings with _$SketchSettings {
  @JsonSerializable(explicitToJson: true)
  const factory SketchSettings({
    String? currentId,
    @Default(<String>[]) List<String> sketchTags,
    @Default(<SketchBackground>[]) List<SketchBackground> backgrounds,
  }) = _SketchSettings;

  factory SketchSettings.fromJson(Map<String, dynamic> json) =>
      _$SketchSettingsFromJson(json);
}
