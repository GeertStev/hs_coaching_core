import 'package:json_annotation/json_annotation.dart';

/// Bewaart een [Duration] als gehele milliseconden in JSON.
///
/// Staat bewust hier en niet in `core/data/firestore_converters.dart`: dat
/// bestand importeert `cloud_firestore`, en de match engine moet pure Dart
/// blijven.
class DurationMillisConverter implements JsonConverter<Duration, int> {
  const DurationMillisConverter();

  @override
  Duration fromJson(int json) => Duration(milliseconds: json);

  @override
  int toJson(Duration object) => object.inMilliseconds;
}
