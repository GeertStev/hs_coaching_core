/// Pad van indices vanaf de Training-root naar een `TrainingNode` (zie
/// `training_node.dart`): lengte 0 duidt de root-lijst zelf aan
/// (`Training.children`); lengte N (N >= 1) duidt het N-de niveau diepe kind
/// aan, waarbij elk tussenliggend pad-segment door een `TrainingGroup` moet
/// lopen.
///
/// Zowel de editor-boomhelpers (`hs_coaching_app`'s `training_tree.dart`) als
/// de sessie-tijdlijn (`training_flatten.dart`) gebruiken hetzelfde type,
/// zodat een pad uit de ene wereld zonder conversie in de andere te
/// gebruiken is.
typedef TrainingPath = List<int>;
