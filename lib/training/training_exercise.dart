import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/training/training_exercise_group.dart';

part 'training_exercise.freezed.dart';
part 'training_exercise.g.dart';

/// Een oefening — het blad van de Training-boom. Kan direct onder de root
/// staan, in een [TrainingSet], of in een [TrainingSubset]; heeft zelf geen
/// kinderen, alleen [groups] (timing-rijen).
@freezed
abstract class TrainingExercise with _$TrainingExercise {
  @JsonSerializable(explicitToJson: true)
  const factory TrainingExercise({
    required String id,
    required String title,
    @Default(<TrainingExerciseGroup>[]) List<TrainingExerciseGroup> groups,
  }) = _TrainingExercise;

  factory TrainingExercise.fromJson(Map<String, dynamic> json) =>
      _$TrainingExerciseFromJson(json);
}
