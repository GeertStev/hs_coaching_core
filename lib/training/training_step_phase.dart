/// Werk- of rustfase binnen één `TrainingExerciseGroup`-rij. Een rij levert
/// altijd een werk-stap op; een rust-stap alleen als `restSeconds > 0` (zie
/// `training_flatten.dart`) — dus deze waarde is alleen relevant zolang er
/// daadwerkelijk een rust-stap bestaat voor die rij.
enum TrainingStepPhase { work, rest }
