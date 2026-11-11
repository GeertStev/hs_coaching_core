import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hs_coaching_core/match/engine/match_state.dart';
import 'package:hs_coaching_core/team/team_model.dart';

part 'infringement_table.freezed.dart';
part 'infringement_table.g.dart';

/// Eén sanctie uit de overtredingentabel 17.7.1.
enum Sanction {
  individualCaution,
  teamCaution,

  /// De tabel zegt alleen "caution", zonder individueel of team.
  caution,
  oneMinute,
  twoMinutes,
  fiveMinutes,
  dismissal,
  penaltyShot,
  penaltyGoal,
  gameForfeit,
}

/// Wat de tabel voor één stap (bv. "eerste overtreding, opzettelijk") toelaat.
@freezed
abstract class InfringementStep with _$InfringementStep {
  const factory InfringementStep({
    /// Elke optie is een combinatie van sancties die samen opgelegd worden
    /// (bv. team caution én 2 minuten).
    required List<List<Sanction>> options,

    /// De "*" uit de tabel: de scheidsrechter kiest vrij tussen de opties.
    @Default(false) bool refereeChoice,
  }) = _InfringementStep;

  factory InfringementStep.fromJson(Map<String, dynamic> json) =>
      _$InfringementStepFromJson(json);
}

/// Eén rij uit tabel 17.7.1.
@freezed
abstract class Infringement with _$Infringement {
  @JsonSerializable(explicitToJson: true)
  const factory Infringement({
    /// Sleutel die in events als `infringementCode` bewaard wordt. Meestal het
    /// regelnummer; 16.3.8 komt drie keer voor en krijgt een achtervoegsel.
    required String id,

    /// Regelnummers (16.3.x) van de overtreding.
    required List<String> rules,
    required String name,

    /// Naam van het handsignaal zoals in de tabel, met de regelnummers
    /// (13.1.x) erbij.
    required String handSignal,
    @Default(<String>[]) List<String> handSignalRules,
    String? note,

    /// `null` = grijs vak in de tabel: deze overtreding kan niet accidenteel
    /// zijn.
    InfringementStep? firstAccidental,
    required InfringementStep firstDeliberate,
    InfringementStep? secondAccidental,
    required InfringementStep secondDeliberate,
    required InfringementStep thirdOrMore,
  }) = _Infringement;

  factory Infringement.fromJson(Map<String, dynamic> json) =>
      _$InfringementFromJson(json);
}

/// Hoe "eerste/tweede/derde overtreding" geteld wordt.
///
/// OPEN-3: default aanvaard, per speler en per wedstrijd.
enum InfringementCountScope { perPlayerPerMatch, perTeamPerMatch }

/// Suggestie voor de tafel. De tabel is uitdrukkelijk een **richtlijn**
/// (17.7.1): de scheidsrechter beslist en de app legt nooit zelf een straf op.
class PenaltySuggestion {
  const PenaltySuggestion({
    required this.infringement,
    required this.occurrence,
    required this.step,
  });

  final Infringement infringement;

  /// De hoeveelste overtreding van deze soort dit is (1, 2, 3, ...).
  final int occurrence;

  /// `null` als de tabel voor deze combinatie geen sanctie geeft (de
  /// overtreding kan niet accidenteel zijn).
  final InfringementStep? step;
}

/// De overtredingentabel 17.7.1 als data.
///
/// De inhoud staat in `assets/uwh/infringements_v13.json`. De engine laadt dat
/// bestand niet zelf (dat kan alleen via Flutter): de aanroeper geeft de
/// ingelezen JSON door aan [InfringementTable.fromJson].
@freezed
abstract class InfringementTable with _$InfringementTable {
  const InfringementTable._();

  @JsonSerializable(explicitToJson: true)
  const factory InfringementTable({
    required String rulesVersion,
    required String sourceRule,
    required List<Infringement> infringements,
  }) = _InfringementTable;

  factory InfringementTable.fromJson(Map<String, dynamic> json) =>
      _$InfringementTableFromJson(json);

  /// Pad van het JSON-bestand binnen dit pakket.
  static const String assetPath = 'assets/uwh/infringements_v13.json';

  Infringement? byId(String id) {
    for (final infringement in infringements) {
      if (infringement.id == id) return infringement;
    }
    return null;
  }

  /// Stelt een straf voor op basis van de eerdere overtredingen van dezelfde
  /// soort in deze wedstrijd. Geeft `null` voor een onbekende [code].
  ///
  /// [cap] is `null` als de overtreder niet gekend is; dan telt het team.
  PenaltySuggestion? suggestPenalty(
    MatchState state,
    TeamColor team,
    int? cap,
    String code,
    bool deliberate, {
    // OPEN-3.
    InfringementCountScope scope = InfringementCountScope.perPlayerPerMatch,
  }) {
    final infringement = byId(code);
    if (infringement == null) return null;

    final perPlayer =
        scope == InfringementCountScope.perPlayerPerMatch && cap != null;
    bool matches(TeamColor otherTeam, int? otherCap, String otherCode) =>
        otherTeam == team &&
        otherCode == code &&
        (!perPlayer || otherCap == cap);

    final earlier =
        state.cautions
            .where((c) => matches(c.team, c.cap, c.infringementCode))
            .length +
        state.penalties
            .where((p) => matches(p.team, p.cap, p.infringementCode))
            .length;
    final occurrence = earlier + 1;

    final step = switch (occurrence) {
      1 =>
        deliberate
            ? infringement.firstDeliberate
            : infringement.firstAccidental,
      2 =>
        deliberate
            ? infringement.secondDeliberate
            : infringement.secondAccidental,
      _ => infringement.thirdOrMore,
    };
    return PenaltySuggestion(
      infringement: infringement,
      occurrence: occurrence,
      step: step,
    );
  }
}
