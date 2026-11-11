// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'infringement_table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InfringementStep _$InfringementStepFromJson(Map<String, dynamic> json) =>
    _InfringementStep(
      options: (json['options'] as List<dynamic>)
          .map(
            (e) => (e as List<dynamic>)
                .map((e) => $enumDecode(_$SanctionEnumMap, e))
                .toList(),
          )
          .toList(),
      refereeChoice: json['refereeChoice'] as bool? ?? false,
    );

Map<String, dynamic> _$InfringementStepToJson(_InfringementStep instance) =>
    <String, dynamic>{
      'options': instance.options
          .map((e) => e.map((e) => _$SanctionEnumMap[e]!).toList())
          .toList(),
      'refereeChoice': instance.refereeChoice,
    };

const _$SanctionEnumMap = {
  Sanction.individualCaution: 'individualCaution',
  Sanction.teamCaution: 'teamCaution',
  Sanction.caution: 'caution',
  Sanction.oneMinute: 'oneMinute',
  Sanction.twoMinutes: 'twoMinutes',
  Sanction.fiveMinutes: 'fiveMinutes',
  Sanction.dismissal: 'dismissal',
  Sanction.penaltyShot: 'penaltyShot',
  Sanction.penaltyGoal: 'penaltyGoal',
  Sanction.gameForfeit: 'gameForfeit',
};

_Infringement _$InfringementFromJson(Map<String, dynamic> json) =>
    _Infringement(
      id: json['id'] as String,
      rules: (json['rules'] as List<dynamic>).map((e) => e as String).toList(),
      name: json['name'] as String,
      handSignal: json['handSignal'] as String,
      handSignalRules:
          (json['handSignalRules'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      note: json['note'] as String?,
      firstAccidental: json['firstAccidental'] == null
          ? null
          : InfringementStep.fromJson(
              json['firstAccidental'] as Map<String, dynamic>,
            ),
      firstDeliberate: InfringementStep.fromJson(
        json['firstDeliberate'] as Map<String, dynamic>,
      ),
      secondAccidental: json['secondAccidental'] == null
          ? null
          : InfringementStep.fromJson(
              json['secondAccidental'] as Map<String, dynamic>,
            ),
      secondDeliberate: InfringementStep.fromJson(
        json['secondDeliberate'] as Map<String, dynamic>,
      ),
      thirdOrMore: InfringementStep.fromJson(
        json['thirdOrMore'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$InfringementToJson(_Infringement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rules': instance.rules,
      'name': instance.name,
      'handSignal': instance.handSignal,
      'handSignalRules': instance.handSignalRules,
      'note': instance.note,
      'firstAccidental': instance.firstAccidental?.toJson(),
      'firstDeliberate': instance.firstDeliberate.toJson(),
      'secondAccidental': instance.secondAccidental?.toJson(),
      'secondDeliberate': instance.secondDeliberate.toJson(),
      'thirdOrMore': instance.thirdOrMore.toJson(),
    };

_InfringementTable _$InfringementTableFromJson(Map<String, dynamic> json) =>
    _InfringementTable(
      rulesVersion: json['rulesVersion'] as String,
      sourceRule: json['sourceRule'] as String,
      infringements: (json['infringements'] as List<dynamic>)
          .map((e) => Infringement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InfringementTableToJson(_InfringementTable instance) =>
    <String, dynamic>{
      'rulesVersion': instance.rulesVersion,
      'sourceRule': instance.sourceRule,
      'infringements': instance.infringements.map((e) => e.toJson()).toList(),
    };
