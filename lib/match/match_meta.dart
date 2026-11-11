import 'package:freezed_annotation/freezed_annotation.dart';

part 'match_meta.freezed.dart';
part 'match_meta.g.dart';

/// Welk toestel voor een wedstrijd mag schrijven (02-match-engine.md §6a).
@freezed
abstract class MatchLease with _$MatchLease {
  const factory MatchLease({
    required String deviceId,

    /// Server-tijd waarop dit toestel de lease nam.
    required int sinceMillis,
  }) = _MatchLease;

  factory MatchLease.fromJson(Map<String, dynamic> json) =>
      _$MatchLeaseFromJson(json);
}

/// Het document van één wedstrijd: alles wat niet in het event log zit.
///
/// Pad: `clubs/{clubId}/matches/{matchId}`; de events staan in de subcollectie
/// `events`. De stand, de klok en de fase staan hier bewust **niet**: die
/// worden altijd uit de events berekend.
@freezed
abstract class MatchMeta with _$MatchMeta {
  const MatchMeta._();

  @JsonSerializable(explicitToJson: true)
  const factory MatchMeta({
    required int createdAtMillis,
    String? tournamentId,

    /// Veld waarop de wedstrijd gepland is.
    String? fieldId,

    /// Het enige toestel dat events mag schrijven; `null` zolang geen
    /// tafeltoestel de wedstrijd genomen heeft.
    MatchLease? lease,

    /// Veld waarop de wedstrijd nu live is; `null` als ze niet live is.
    String? liveFieldId,
  }) = _MatchMeta;

  factory MatchMeta.fromJson(Map<String, dynamic> json) =>
      _$MatchMetaFromJson(json);

  bool get isLive => liveFieldId != null;
}
