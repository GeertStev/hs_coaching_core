import 'dart:convert';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hs_coaching_core/team/player_model.dart';
import 'package:hs_coaching_core/team/team_model.dart';
import 'package:http/http.dart' as http;

/// Repository for fetching team composition data.
///
/// This class abstracts the data source (currently a Google Script) from the
/// rest of the application.
class TeamRepository {
  // ToDo: The URL should be configurable, possibly from global settings.
  final baseUrl =
      'https://script.google.com/macros/s/AKfycbwWrPIm8SPX5KP4ZQQiySbozRDmtgEjm1fqDEf4vQpHfgLuMO5JyJGmpSpxWOnodtm0/exec';

  /// Fetches the team compositions and returns a list containing both teams.
  Future<List<Team>> fetchTeams() async {
    final teamsUrl = Uri.parse(
      '$baseUrl?t=${DateTime.now().millisecondsSinceEpoch}',
    );

    final response = await http.get(teamsUrl);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);

      SchedulerBinding.instance.ensureVisualUpdate();

      return [
        Team.fromGoogleScriptResponse(jsonData, TeamColor.white),
        Team.fromGoogleScriptResponse(jsonData, TeamColor.black),
      ];
    } else {
      throw Exception(
        'Failed to load team composition: ${response.reasonPhrase}',
      );
    }
  }
}

class DummyTeamRepository {
  Future<List<Team>> fetchTeams() async {
    return [
      Team(
        teamColor: TeamColor.white,
        front: [
          Player(name: 'Player A'),
          Player(name: 'Player B'),
          Player(name: 'Player B'),
        ],
        center: [Player(name: 'Player C')],
        wing: [
          Player(name: 'Player D'),
          Player(name: 'Player E'),
        ],
        goalie: [Player(name: 'Player F')],
      ),
      Team(
        teamColor: TeamColor.black,
        front: [
          Player(name: 'Player G'),
          Player(name: 'Player H'),
        ],
        center: [Player(name: 'Player I')],
        wing: [
          Player(name: 'Player J'),
          Player(name: 'Player K'),
          Player(name: 'Player K'),
        ],
        goalie: [Player(name: 'Player L')],
      ),
    ];
  }
}

// --- Providers ---

/// Provider for the TeamRepository instance.
final teamRepositoryProvider = Provider.autoDispose<TeamRepository>(
  (ref) => TeamRepository(),
);

/// Provider that fetches the list of teams using the TeamRepository.
/// The `FutureProvider` automatically handles caching and error states.
final teamsProvider = FutureProvider.autoDispose<List<Team>>((ref) {
  return ref.watch(teamRepositoryProvider).fetchTeams();
});
