# hs_coaching_core

Shared Dart package for the Holy Squid underwater hockey coaching tool, used by:

- [`hs_coaching_app`](https://github.com/GeertStev/hs_coaching_app): Android control app (writes)
- [`hs_coaching_screen`](https://github.com/GeertStev/hs_coaching_screen): Flutter web pool display (read-only)

It contains the Freezed models, read-only Firestore repository base classes, pure timing/progress
helpers and shared Riverpod providers for every content type (chrono, tabata, training, game,
image, text, sketch, team, global settings).

Both apps reference it as a path dependency, so clone all three repos side by side:

```yaml
dependencies:
  hs_coaching_core:
    path: ../hs_coaching_core
```

See `CLAUDE.md` for the architecture and the conventions shared across the three repos.
