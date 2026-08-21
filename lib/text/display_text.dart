import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/core/data/firestore_converters.dart';

part 'display_text.freezed.dart';
part 'display_text.g.dart';

enum DisplayTextStatus { active, archived }

/// Represents a text on a display device in the Firebase database.
///
/// Path: /clubs/{clubId}/displays/{displayDeviceId}/texts/{textId}
@freezed
abstract class DisplayText with _$DisplayText {
  const factory DisplayText({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String id,
    String? title,
    required String text,
    required String userId,
    @ServerWriteTimestampConverter() required DateTime timestamp,
    @Default(DisplayTextStatus.active)
    @JsonKey(unknownEnumValue: DisplayTextStatus.active)
    DisplayTextStatus status,
    @Default(<String>[]) List<String> tags,
  }) = _DisplayText;

  factory DisplayText.fromJson(Map<String, dynamic> json) =>
      _$DisplayTextFromJson(json);
}
