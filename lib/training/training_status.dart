/// Status van een lopende Training-sessie — zelfde vier basiswaarden en
/// zelfde betekenis als `ChronoStatus`/`TabataStatus`, met `finished` als
/// extra: een sessie kan (in tegenstelling tot Chrono) daadwerkelijk "op"
/// raken zodra de laatste stap in de platgeslagen tijdlijn voorbij is — zie
/// `training_session_progress.dart`.
enum TrainingStatus { idle, running, paused, finished }
