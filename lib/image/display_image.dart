import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/core/data/firestore_converters.dart';

part 'display_image.freezed.dart';
part 'display_image.g.dart';

enum DisplayImageStatus { active, archived }

/// Represents an image on a display device in the Firebase database.
///
/// Path: /clubs/{clubId}/displays/{displayDeviceId}/images/{imageId}
@freezed
abstract class DisplayImage with _$DisplayImage {
  const factory DisplayImage({
    @JsonKey(includeFromJson: false, includeToJson: false)
    @Default('')
    String id,
    String? title,
    String? description,
    required String url,
    required String userId,
    @ServerWriteTimestampConverter() required DateTime timestamp,
    @Default(DisplayImageStatus.active)
    @JsonKey(unknownEnumValue: DisplayImageStatus.active)
    DisplayImageStatus status,
    @Default(<String>[]) List<String> tags,
  }) = _DisplayImage;

  factory DisplayImage.fromJson(Map<String, dynamic> json) =>
      _$DisplayImageFromJson(json);
}
