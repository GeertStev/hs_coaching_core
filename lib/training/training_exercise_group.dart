import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/training/training_parameter_row.dart';

part 'training_exercise_group.freezed.dart';
part 'training_exercise_group.g.dart';

/// Eén "timing rij" binnen een [TrainingExercise]: werk/rust/delta plus een
/// set parameter-rijen (reps/afstand/slag/intensiteit/zone). [name] wordt in
/// de UI verborgen zolang een oefening maar één groep heeft — pas zichtbaar
/// zodra een tweede groep is toegevoegd (max [kMaxTrainingExerciseGroups]).
@freezed
abstract class TrainingExerciseGroup with _$TrainingExerciseGroup {
  @JsonSerializable(explicitToJson: true)
  const factory TrainingExerciseGroup({
    required String id,
    @Default('') String name,
    @Default(<TrainingParameterRow>[])
    List<TrainingParameterRow> parameterRows,
    @Default(0) int workSeconds,
    @Default(0) int restSeconds,
    @Default(0) int deltaSeconds,
  }) = _TrainingExerciseGroup;

  factory TrainingExerciseGroup.fromJson(Map<String, dynamic> json) =>
      _$TrainingExerciseGroupFromJson(json);
}

/// Huidige cap op het aantal groepen per oefening; bewust een losse
/// constante (niet hardcoded) zodat dit later naar 4 opgehoogd kan worden
/// zonder een modelwijziging.
const int kMaxTrainingExerciseGroups = 2;
