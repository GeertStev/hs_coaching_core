import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The RTDB instance backing this project's clock-sync oracle
/// (`serverTimeOffsetProvider`) and connectivity check
/// (`serverConnectionProvider`) — both special `.info/*` paths, not real
/// data. Chrono/tabata's actual state lives in Firestore, same as every
/// other content type; this RTDB instance is deliberately never used to
/// store or read that data. Deliberately **not** read off
/// `FirebaseOptions.databaseURL` — this project's `google-services.json`
/// predates enabling RTDB and has no `firebase_url` entry, so setting
/// `databaseURL` on `FirebaseOptions` makes Android's native auto-initialized
/// default `FirebaseApp` (built from `google-services.json` before Dart's
/// `Firebase.initializeApp()` even runs) disagree with the options Dart
/// passes explicitly, which throws `[core/duplicate-app]` instead of
/// reusing the existing app. `FirebaseDatabase.instanceFor` sidesteps that
/// by pointing at this URL without touching `FirebaseOptions` at all — also
/// the officially correct approach for a non-`us-central1` regional
/// database, which requires an explicit URL either way.
const _databaseURL =
    'https://hs-coaching-default-rtdb.europe-west1.firebasedatabase.app';

final firebaseDatabaseProvider = Provider<FirebaseDatabase>(
  (ref) => FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: _databaseURL,
  ),
);
