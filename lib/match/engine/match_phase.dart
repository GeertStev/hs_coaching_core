/// Fase van een wedstrijd (02-match-engine.md §4).
///
/// Volgorde: `notStarted → p1 → halfTime → p2 → (otBreak → ot1 → otInterval →
/// ot2 → sdBreak → suddenDeath) → awaitingSignOff → finalized`.
enum MatchPhase {
  notStarted,
  p1,
  halfTime,
  p2,
  otBreak,
  ot1,
  otInterval,
  ot2,
  sdBreak,
  suddenDeath,
  awaitingSignOff,

  /// De spec noemt dit `final`; dat is een gereserveerd woord in Dart.
  finalized;

  /// Fase waarin gespeeld wordt en dus een wedstrijdklok bestaat.
  bool get isPlay => switch (this) {
    p1 || p2 || ot1 || ot2 || suddenDeath => true,
    _ => false,
  };

  /// Speelfase met een vaste duur (alles behalve sudden death).
  bool get isTimedPlay => isPlay && this != suddenDeath;

  /// Pauze tussen twee speelfases.
  bool get isBreak => switch (this) {
    halfTime || otBreak || otInterval || sdBreak => true,
    _ => false,
  };

  bool get isRegularPeriod => this == p1 || this == p2;

  bool get isOver => this == awaitingSignOff || this == finalized;

  /// Speelfase die op deze (pauze)fase volgt bij het startsignaal, of `null`
  /// als er vanuit deze fase geen spel kan starten.
  MatchPhase? get nextPlayPhase => switch (this) {
    notStarted => p1,
    halfTime => p2,
    otBreak => ot1,
    otInterval => ot2,
    sdBreak => suddenDeath,
    _ => null,
  };

  /// Helft waarin een team time-out telt (14.2.6): 1 of 2, anders `null`.
  int? get half => switch (this) {
    p1 => 1,
    p2 => 2,
    _ => null,
  };
}
