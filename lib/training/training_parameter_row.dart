import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_parameter_row.freezed.dart';
part 'training_parameter_row.g.dart';

/// Eén parameter-rij binnen een [TrainingExerciseGroup]: een vaste bundel van
/// vijf onafhankelijk instelbare velden (bijv. "5x 25m B 60% Bov"). `null`
/// betekent "niet ingesteld voor dit veld" — de rij zelf blijft bestaan (een
/// [TrainingExerciseGroup] kan meerdere van deze rijen hebben, bijv. drie
/// verschillende slagen na elkaar binnen één getimede blok, zie
/// `training_exercise_group.dart`), enkel het veld toont dan een placeholder
/// in de UI.
@freezed
abstract class TrainingParameterRow with _$TrainingParameterRow {
  const factory TrainingParameterRow({
    required String id,
    int? reps,
    int? distance,
    String? stroke,
    int? intensity,
    String? zone,
  }) = _TrainingParameterRow;

  factory TrainingParameterRow.fromJson(Map<String, dynamic> json) =>
      _$TrainingParameterRowFromJson(json);
}
