import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/training/training_exercise.dart';
import 'package:hs_coaching_core/training/training_group.dart';

part 'training_node.freezed.dart';
part 'training_node.g.dart';

/// Eén kind in de Training-boom: ofwel een [TrainingGroup] (kan zelf weer
/// kinderen bevatten) ofwel een losse [TrainingExercise] (blad). Vervangt
/// v1's twee gescheiden unions ([TrainingRootChild]/[TrainingSetChild]) door
/// één recursief type — de max-diepte-3-eis wordt niet meer afgedwongen
/// door het type zelf, maar door een runtime-invariant, zie
/// `training_validation.dart`.
@freezed
sealed class TrainingNode with _$TrainingNode {
  const TrainingNode._();

  @JsonSerializable(explicitToJson: true)
  const factory TrainingNode.group({required TrainingGroup group}) =
      TrainingNodeGroup;

  @JsonSerializable(explicitToJson: true)
  const factory TrainingNode.exercise({required TrainingExercise exercise}) =
      TrainingNodeExercise;

  factory TrainingNode.fromJson(Map<String, dynamic> json) =>
      _$TrainingNodeFromJson(json);

  String get id => switch (this) {
    TrainingNodeGroup(:final group) => group.id,
    TrainingNodeExercise(:final exercise) => exercise.id,
  };
}
