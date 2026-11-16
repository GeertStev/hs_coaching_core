import 'package:hs_coaching_core/scheduler/scheduler_models.dart';
import 'package:hs_coaching_core/scheduler/team_scheduler.dart';
import 'package:hs_coaching_core/team/team_model.dart';

/// Veld in `displays/{displayId}/settings/team` met de opstelling die de app
/// (Team scheduler) naar het zwembadscherm stuurt.
const String teamLineupField = 'lineup';

const _keys = {
  PlayerPosition.forward: 'front',
  PlayerPosition.center: 'center',
  PlayerPosition.wing: 'wing',
  PlayerPosition.goalie: 'goalie',
};

/// De opstelling van wit en zwart als map voor Firestore. Dezelfde vorm als
/// het antwoord van het Google-script, zodat het scherm beide bronnen met
/// [Team.fromGoogleScriptResponse] leest: per kleur en per positie een lijst
/// namen, eerst de basisspelers en dan de wissels.
Map<String, dynamic> teamLineupJson({
  required ScheduledTeam white,
  required ScheduledTeam black,
  required String Function(String playerId) nameOf,
}) {
  Map<String, dynamic> side(ScheduledTeam team) => {
    for (final entry in _keys.entries)
      entry.value: [
        for (final lineup in [...team.base, ...team.subs])
          if (lineup.position == entry.key) nameOf(lineup.playerId),
      ],
  };
  return {TeamColor.white.name: side(white), TeamColor.black.name: side(black)};
}

/// Leest de opstelling uit het document `settings/team`. `null` als de app
/// nog geen opstelling heeft gestuurd.
List<Team>? teamsFromLineup(Map<String, dynamic>? settings) {
  final lineup = settings?[teamLineupField];
  if (lineup is! Map<String, dynamic>) return null;
  if (lineup[TeamColor.white.name] is! Map<String, dynamic> ||
      lineup[TeamColor.black.name] is! Map<String, dynamic>) {
    return null;
  }
  return [
    Team.fromGoogleScriptResponse(lineup, TeamColor.white),
    Team.fromGoogleScriptResponse(lineup, TeamColor.black),
  ];
}
