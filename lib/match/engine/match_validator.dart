/// De validator van de match engine (02-match-engine.md §5 en prompts.md
/// fase 1, stap 4).
///
/// `validateEvent(state, candidate)` weigert een kandidaat-event met een
/// getypeerde reden, zodat de UI die reden kan tonen. De regels staan in
/// `match_reducer.dart`, omdat de reducer exact dezelfde regels toepast
/// wanneer hij een log afspeelt.
library;

export 'package:hs_coaching_core/match/engine/match_reducer.dart'
    show validateEvent;
export 'package:hs_coaching_core/match/engine/match_rejection.dart';
