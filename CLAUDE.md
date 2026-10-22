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
progress with core's pure helpers (`Tabata.progressAt`, `training_flatten`/`training_navigation`/
`computeTrainingProgress`), and runs a `Timer.periodic` only while running. Only the app advances
the training pointer (`autoAdvanceDue` → `next()`); the screen reads that flag purely
informationally. RTDB is used only for `.info/serverTimeOffset` and `.info/connected`
(`serverConnectionProvider`).

For tree-shaped timing, "flatten to a timeline, then scan" (see `training_flatten.dart`).

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

## This repo
- `lib/<feature>/`: model(s) + `*_repository.dart` + pure helpers (e.g. `training/`, `tabata/`).
  `lib/core/`: converters and shared providers (Firebase instances, device ids, server time/connection).
- `team/` is backed by a Google Apps Script URL (`team_repository.dart`), not Firestore.
- Doc comments on each repository state how the two apps use it; keep them accurate when changing one.
