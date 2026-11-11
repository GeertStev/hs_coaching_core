# HS Coaching — shared conventions (all three repos)

Coaching tool for the **Holy Squid** underwater hockey club. Three sibling repos, always checked out
side by side (both apps depend on core as the path dependency `../hs_coaching_core`):

| Repo | Role |
| --- | --- |
| `hs_coaching_app` | Android control app on a poolside tablet. Coaches create content and push it live. **The only writer.** |
| `hs_coaching_screen` | Flutter web display on the pool screen. Reads Firestore/RTDB, renders full-screen. **Never writes.** |
| `hs_coaching_core` (this repo) | Shared Dart package: Freezed models, read-only repository base classes, pure calculation helpers, shared providers. |

Data flows one way: **app writes → Firebase → screen reads.** Realtime sync is the core
requirement. Both apps import this file; their own `CLAUDE.md` only adds repo-specific rules.

## Firestore layout
```
clubs/{clubId}/
  displays/{displayId}/
    settings/{content|global|chrono|tabata|training|game|sketch|team|...}  # one doc per feature
    sketches/{sketchId}/elements/{elementId}
    ...                                     # app-only collections: see hs_coaching_app/CLAUDE.md
```
`clubId`/`displayId` come from `displayDeviceIdsProvider` (`lib/core/providers/`), still
**hardcoded** to `holySquid`/`bilzen`. Nearly every repository provider depends on it; replacing it
with a real config flow is an open issue.

## Repository pattern
- Core ships, per content type, the Freezed model + a **read-only** `Display<X>Repository`
  (constructor `{firestore, clubId, displayId}`; some are named `...RepositoryBase`).
- `hs_coaching_screen` uses that class directly. `hs_coaching_app` `extends` it to add writes.
- Each app exposes it through a hand-written `Provider` reading `firebaseFirestoreProvider` +
  `displayDeviceIdsProvider`, plus a `StreamProvider` on top.
- New content type: add model + read-only repository here first, then wire it into both apps. Never
  duplicate a core model locally.
- Keep Firestore types out of a repository's public API; map to domain models at the boundary.

## Realtime timers (chrono, tabata, training)
The Firestore doc holds **config + a runtime pointer** (`status`, `authoritativeStartTimeMillis`,
`accumulatedElapsedMillis`, in RTDB server-clock ms), never the ticking countdown. A
`*ScreenController` (`Notifier`) combines the doc stream with `serverTimeOffsetProvider`, derives
progress with core's pure helpers (`Tabata.progressAt`, `flattenTraining` + `trainingProgressAt`),
and runs a `Timer.periodic` only while running. Training's pointer is `currentStepIndex` (index in
the flattened timeline, so each repeat round is distinct): both apps walk from it through timed
steps by elapsed time and stop at an untimed step. Only the app moves the pointer (Next/Previous/
Reset); nothing needs the tablet awake for timed steps to advance. RTDB is used only for `.info/serverTimeOffset` and `.info/connected`
(`serverConnectionProvider`).

For tree-shaped timing, "flatten to a timeline, then scan" (see `training_flatten.dart`).
An exercise with two timing groups is a **group split**: the groups run at the same time as one step
lasting as long as the longest group (`TrainingStep.parallelGroups`, `parallelGroupStatesAt`). The
pool screen's coarser view (one step = one repetition of one exercise, breadcrumb levels, transitions,
lengths) lives in `lib/training/display/` on top of that timeline; it never changes `currentStepIndex`.

## Underwater hockey: match, tournament and statistics modules
**Specs** in `docs/uwh/`; read them before touching these modules:
- `01-regels-domein.md`: software extract of the CMAS rules v13 (source PDF in `docs/uwh/reference/`,
  only consult it when a spec is unclear).
- `02-match-engine.md`: event log, reducer, clock rules, acceptance tests.
- `03-wedstrijdtafel-ui.md`: table console and scoreboards.
- `04-toernooi.md`, `05-spelersstatistieken.md`: later phases.
- `open-vragen.md`: undecided points. **Never fill these in yourself**: implement the listed default
  as a configurable policy and mark it with `// OPEN-x`.
- `prompts.md`: the work is done phase by phase in this order. No UI before the engine tests are green.

**Hard rules**
- The match engine lives in this repo as **pure Dart**: no imports of `flutter`, `firebase_*` or
  `cloud_*`, no `DateTime.now()` (tests use a fake clock).
- Firebase sits behind a `MatchRepository` interface. This is a deliberate exception to "no
  `I<X>Repository` interfaces" elsewhere: the engine and its tests must run without Firebase.
- Events are append-only. Correct with `EventVoided`, never with an update or delete.
- Clocks are **computed** from events + server time (`localNow + .info/serverTimeOffset`, reuse
  `serverTimeOffsetProvider`), never stored or ticked. Same principle as the realtime timers above.
- An event's time is the moment of the **tap**, not of the upload: no `ServerValue.timestamp` as
  event time.
- Every clock rule has a unit test whose name carries the CMAS rule number
  (`test('14.2.3.2 auto-stop at 2:00', ...)`).
- Several matches run at once (up to 3 fields): everything is keyed by `matchId`. **No** singleton or
  global "active match" in providers or services.
- One table device per match with two operators: the chief referee runs the time with a HID remote
  (`source: remote`, only start/stop and optionally officials' time-out), the fourth referee the
  screen.
- Substitutions and assists are **not** recorded: no events, UI or statistics for them.
- No hardcoded durations: everything comes from `MatchConfig`, which can differ per tournament phase
  and per match and is stored as a snapshot in `MatchCreated`.
- The infringement table 17.7.1 is a **suggestion**, never enforced.
- Domain terms in code are English as in the CMAS rules (penalty shot, advantage puck, ...). Comments
  stay Dutch and UI strings English, as everywhere else.

## Riverpod 3
- Hand-written providers only; no `@riverpod` codegen.
- No `FamilyNotifier`/`FamilyAsyncNotifier`/`FamilyStreamNotifier`: use the base class, pass family
  args through the **constructor**; `build()` takes no params.
- `.value` on `AsyncValue`, never `.valueOrNull`.

## Freezed / json_serializable
- After touching any `@freezed`/`fromJson` model: `dart run build_runner build --delete-conflicting-outputs`,
  and check that **both** `.freezed.dart` and `.g.dart` were written. Generated files are committed.
- `factory X.fromJson(Map<String, dynamic> json) => _$XFromJson(json);` must stay that exact one-liner,
  or `.g.dart` silently isn't generated. Normalize legacy fields in the repository instead.
- `@JsonSerializable(explicitToJson: true)` on **every** class holding a nested Freezed model, list
  or union, not just the outermost. Missing it only fails at Firestore write time. Cover such models
  with a test that actually calls `jsonEncode(model.toJson())`.
- A converter needing a per-field default uses a named const constructor
  (`ColorFromHexConverter.blue()`); constructor-argument converters aren't supported.
- Shared converters live in `lib/core/data/firestore_converters.dart`. Don't redefine them.
- No legacy-shape migration shims unless real data in Firestore needs one.

## Conventions
- Code comments in **Dutch**, UI strings in **English**, no localization layer.
- Pure domain logic (progress engines, tree ops) is Flutter-free and unit-tested; tests mirror the
  `lib/` path under `test/`. Run with `flutter test`.
- Commit early. `lib/` and `pubspec.yaml`/`pubspec.lock` must be tracked in git: a 2026-08-22
  data-loss in `hs_coaching_screen` was unrecoverable because they weren't.

## Errors
Shared in `lib/core/errors/` and `lib/core/providers/riverpod_config.dart`; both apps use them.
- Never show a raw error (`Text('Error: $err')`) to the user: show `userMessage(error)` (English).
  Domain errors with a user-ready text implement `UserFacingException`.
- Report caught-but-unexpected errors with `reportError(error, stack, context: ...)`; no silent
  `catch (_) {}`. It only logs to the console for now (no crash-reporting service, by choice).
- Both `main.dart` call `installGlobalErrorHandlers()` and put `appProviderRetry` +
  `AppProviderObserver` on the `ProviderScope`.

## This repo
- `lib/<feature>/`: model(s) + `*_repository.dart` + pure helpers (e.g. `training/`, `tabata/`).
  `lib/core/`: converters and shared providers (Firebase instances, device ids, server time/connection).
- `team/` is backed by a Google Apps Script URL (`team_repository.dart`), not Firestore.
- Doc comments on each repository state how the two apps use it; keep them accurate when changing one.
