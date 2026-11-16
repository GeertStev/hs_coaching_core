import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_config.freezed.dart';
part 'rating_config.g.dart';

/// Een rang: geldt vanaf [threshold]. [multiplier] bepaalt hoe snel een
/// rating in die rang beweegt (hoge ratings traag, lage snel).
@freezed
abstract class RankTier with _$RankTier {
  const factory RankTier({
    required int threshold,
    required String name,
    required double multiplier,
  }) = _RankTier;

  factory RankTier.fromJson(Map<String, dynamic> json) =>
      _$RankTierFromJson(json);
}

/// Welke wedstrijden meetellen voor de relevantie van een wedstrijd.
enum RelevanceCounting {
  /// Alle wedstrijden in het log, ook latere (zoals het blad). Oude
  /// wijzigingen van een nieuwe speler wegen dus zwaarder naarmate die meer
  /// speelt.
  allGames,

  /// Alleen de wedstrijden tot en met de wedstrijd zelf.
  gamesSoFar,
}

/// Alle getallen uit de rekenregels van het Teamscheduler-blad. De
/// standaardwaarden zijn die van het blad; niets hiervan staat elders in de
/// code.
///
/// Pad (later): onderdeel van `clubs/{clubId}/schedulerConfig/default`.
@freezed
abstract class RatingConfig with _$RatingConfig {
  @JsonSerializable(explicitToJson: true)
  const factory RatingConfig({
    /// Elo-schaal: 400 punten verschil is 10 tegen 1.
    @Default(400) double eloScale,

    /// Vermoeidheid: de sterkte van een speler zakt per minuut tot dit deel.
    @Default(0.99) double fatiguePerMinute,

    /// De ploegsterkte is de gewogen som gedeeld door dit getal.
    @Default(6) double teamRatingDivisor,

    /// Een wedstrijd van zoveel minuten telt voor 1.
    @Default(30) double referenceDurationMinutes,

    /// Relevantie = 1 / ([relevanceOffset] - min(k, [relevanceCap])), met k
    /// het kleinste aantal wedstrijden van een speler-positie in de wedstrijd.
    @Default(11) int relevanceOffset,
    @Default(10) int relevanceCap,
    @Default(RelevanceCounting.allGames) RelevanceCounting relevanceCounting,

    /// Meeneem-effect naar alle posities van de speler: deel van de
    /// dagwijziging bij winst en bij verlies of niet gespeeld.
    @Default(0.25) double crossPositionWinShare,
    @Default(0.1) double crossPositionLossShare,

    /// Een positie onder deze rating die niet de beste van de speler is, zakt
    /// niet mee door het meeneem-effect.
    @Default(1000) double crossPositionFloorRating,

    /// Reeksbonus: winstaandeel over de laatste [streakWindow] wedstrijden.
    @Default(25) int streakWindow,
    @Default(0.65) double streakHighShare,
    @Default(0.35) double streakLowShare,
    @Default(10) double streakBonus,

    /// Datum van de eerste, lege kolom in het blad (`yyyy-MM-dd`). Zie
    /// SHEET-1 in `rating_engine.dart`. `null` = geen lege eerste stap.
    String? timelineStart,
    @Default(defaultRankTiers) List<RankTier> rankTiers,
  }) = _RatingConfig;

  const RatingConfig._();

  factory RatingConfig.fromJson(Map<String, dynamic> json) =>
      _$RatingConfigFromJson(json);

  /// De rang bij een rating: de hoogste drempel die niet boven de rating ligt.
  /// `null` onder de laagste drempel.
  RankTier? tierFor(double rating) {
    RankTier? best;
    for (final tier in rankTiers) {
      if (tier.threshold <= rating &&
          (best == null || tier.threshold > best.threshold)) {
        best = tier;
      }
    }
    return best;
  }

  /// Factor waarmee een wijziging vermenigvuldigd wordt; 1 zonder rang.
  double multiplierFor(double rating) => tierFor(rating)?.multiplier ?? 1;
}

/// De 31 rangen uit het tabblad "Ranking System".
const List<RankTier> defaultRankTiers = [
  RankTier(threshold: 3000, name: '01.Poseidon', multiplier: 0.1),
  RankTier(threshold: 2900, name: '02.Kraken', multiplier: 0.2),
  RankTier(threshold: 2800, name: '03.Leviathan', multiplier: 0.3),
  RankTier(threshold: 2700, name: '04.Charybdis', multiplier: 0.4),
  RankTier(threshold: 2600, name: '05.Hydra', multiplier: 0.4),
  RankTier(threshold: 2500, name: '06.Megalodon', multiplier: 0.5),
  RankTier(threshold: 2400, name: '07.Mosasaurus', multiplier: 0.5),
  RankTier(threshold: 2300, name: '08.Killer Whale', multiplier: 0.6),
  RankTier(threshold: 2200, name: '09.Sperm Whale', multiplier: 0.6),
  RankTier(threshold: 2100, name: '10.Plesiosaur', multiplier: 0.7),
  RankTier(threshold: 2000, name: '11.Great White', multiplier: 0.7),
  RankTier(threshold: 1900, name: '12.Saltwater Crocodile', multiplier: 0.8),
  RankTier(threshold: 1800, name: '13.Giant Squid', multiplier: 0.8),
  RankTier(threshold: 1700, name: '14.Tiger Shark', multiplier: 0.9),
  RankTier(threshold: 1600, name: '15.Swordfish', multiplier: 0.9),
  RankTier(threshold: 1500, name: '16.Dolphin', multiplier: 1),
  RankTier(threshold: 1400, name: '17.Sea-Lion', multiplier: 1),
  RankTier(threshold: 1300, name: '18.Seal', multiplier: 1),
  RankTier(threshold: 1200, name: '19.Bluefin Tuna', multiplier: 1),
  RankTier(threshold: 1100, name: '20.Barracuda', multiplier: 1.5),
  RankTier(threshold: 1000, name: '21.Moray Eel', multiplier: 1.5),
  RankTier(threshold: 900, name: '22.Stingray', multiplier: 1.5),
  RankTier(threshold: 800, name: '23.Octopus', multiplier: 1.5),
  RankTier(threshold: 700, name: '24.Sea Otter', multiplier: 2),
  RankTier(threshold: 600, name: '25.Sea Turtle', multiplier: 2),
  RankTier(threshold: 500, name: '26.Crab', multiplier: 2),
  RankTier(threshold: 400, name: '27.Seahorse', multiplier: 2),
  RankTier(threshold: 300, name: '28.Shrimp', multiplier: 2),
  RankTier(threshold: 200, name: '29.Krill', multiplier: 2),
  RankTier(threshold: 100, name: '30.Plankton', multiplier: 2),
  RankTier(threshold: 0, name: '31.Phytoplankton', multiplier: 1),
];
