import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/training/training_node.dart';

part 'training_group.freezed.dart';
part 'training_group.g.dart';

/// Een groepering binnen de Training-boom, herhaald [repeatCount] keer.
/// "Set" en "Subset" zijn positionele UI-labels, geen aparte Dart-types —
/// een [TrainingGroup] met alleen oefeningen als kind is structureel
/// identiek aan een groep met genestelde groepen; het enige verschil is de
/// runtime-diepte-invariant (zie `training_validation.dart`s
/// `subtreeHeight`/`isValidTrainingTree`), niet het type. Max-diepte-3
/// vanaf de root blijft de eis, maar is nu een runtime-check in plaats van
/// een compile-time garantie via twee gescheiden unions.
@freezed
abstract class TrainingGroup with _$TrainingGroup {
  @JsonSerializable(explicitToJson: true)
  const factory TrainingGroup({
    required String id,
    String? title,
    @Default(1) int repeatCount,
    @Default(<TrainingNode>[]) List<TrainingNode> children,
  }) = _TrainingGroup;

  factory TrainingGroup.fromJson(Map<String, dynamic> json) =>
      _$TrainingGroupFromJson(json);
}
