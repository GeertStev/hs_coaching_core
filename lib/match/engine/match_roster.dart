import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_roster.freezed.dart';
part 'match_roster.g.dart';

/// Kapitein "C" of vice-kapitein "VC" (3.2.4).
enum MatchPlayerRole { none, captain, viceCaptain }

/// Kleinste en grootste toegelaten kapnummer (3.2.2).
const int minCapNumber = 1;
const int maxCapNumber = 15;

/// Maximum aantal opgegeven spelers per wedstrijd (3.1.1).
const int maxPlayersPerMatch = 10;

/// Maximum aantal begeleiders per wedstrijd (3.1.4).
const int maxStaffPerMatch = 4;

/// Eén opgegeven speler in een wedstrijd.
///
/// Staat los van `team/player_model.dart` (teamweergave op het zwembadscherm).
/// [playerId] koppelt de speler optioneel aan een clublid, zodat
/// statistieken over wedstrijden heen aan dezelfde persoon hangen.
@freezed
abstract class MatchPlayer with _$MatchPlayer {
  const factory MatchPlayer({
    required int cap,
    required String name,
    @Default(MatchPlayerRole.none) MatchPlayerRole role,
    String? playerId,
  }) = _MatchPlayer;

  factory MatchPlayer.fromJson(Map<String, dynamic> json) =>
      _$MatchPlayerFromJson(json);
}

/// Waarom een roster geweigerd wordt (01-regels-domein.md §2).
enum RosterProblem {
  tooManyPlayers,
  capOutOfRange,
  duplicateCap,
  multipleCaptains,
  multipleViceCaptains,
  tooManyStaff,
}

/// Controleert een roster; `null` als alles in orde is.
RosterProblem? rosterProblem(List<MatchPlayer> players, List<String> staff) {
  if (players.length > maxPlayersPerMatch) return RosterProblem.tooManyPlayers;
  final caps = <int>{};
  for (final player in players) {
    if (player.cap < minCapNumber || player.cap > maxCapNumber) {
      return RosterProblem.capOutOfRange;
    }
    if (!caps.add(player.cap)) return RosterProblem.duplicateCap;
  }
  int count(MatchPlayerRole role) =>
      players.where((player) => player.role == role).length;
  if (count(MatchPlayerRole.captain) > 1) return RosterProblem.multipleCaptains;
  if (count(MatchPlayerRole.viceCaptain) > 1) {
    return RosterProblem.multipleViceCaptains;
  }
  if (staff.length > maxStaffPerMatch) return RosterProblem.tooManyStaff;
  return null;
}
