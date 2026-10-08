# Number Match — Architectural Specification

## 1. Architectural Philosophy

The application follows a clean, feature-driven hexagonal architecture cleanly separating business rules from Flutter UI dependencies:

```
┌────────────────────────────────────────────────────────┐
│                   Presentation Layer                   │
│   (Screens, Widgets, Dialogs, Theme Tokens, Canvas)   │
└───────────────────────────┬────────────────────────────┘
                            │
┌───────────────────────────▼────────────────────────────┐
│                    Application Layer                   │
│   (GameController, Notifiers, RewardService, Ads/IAP)  │
└───────────────────────────┬────────────────────────────┘
                            │
┌───────────────────────────▼────────────────────────────┐
│                      Domain Layer                      │
│   (NumberMatchEngine, PairValidator, HintFinder, Models)│
└───────────────────────────▲────────────────────────────┘
                            │
┌───────────────────────────┴────────────────────────────┐
│                       Data Layer                       │
│    (Drift SQLite DB, Repositories, SharedPreferences)  │
└────────────────────────────────────────────────────────┘
```

---

## 2. Layer Responsibilities

### 2.1 Domain Layer (`lib/domain/`)
- **Purity**: Zero dependency on Flutter UI or framework widgets. Tested in pure Dart test harnesses.
- **Engine**: `NumberMatchEngine` drives gameplay state transitions: cell selection, matching, row compaction, undo stack snapshots, timer ticks, and hint resolution.
- **Rules**: `PairValidator` implements identical and sum-to-10 matching, reading-order adjacency, cross-row wrapping, column line of sight, and diagonal alignment.
- **Generation**: `BoardGenerator` provides deterministic date-based seed generation for Daily Challenges and classic starting layouts.

### 2.2 Application Layer (`lib/application/`)
- **State Management**: Built on Riverpod 3 using `Notifier` and `NotifierProvider`.
- **Game Controller**: `GameController` manages active session lifecycle, coordinates audio/haptic responses, records metrics, and invokes auto-saving.
- **Centralized Reward Service**: `RewardService` controls all wallet coin inflows (matches, milestones, line clears, daily wins) and outflows (hints).
- **Monetization Service**:
  - `AdService`: Enforces frequency cooldowns (min 120s), natural break insertion (post-game only), and complete suppression for `Ads Free` owners.
  - `IapService`: Observes platform purchase streams, prevents replay attacks via idempotent transaction caching, verifies tokens, and caches verified entitlements locally.

### 2.3 Data Layer (`lib/data/`)
- **Drift SQLite (`AppDatabase`)**:
  - `GameSessionsTable`: Persists active games (JSON-serialized board and undo history stack).
  - `DailyChallengesTable`: Stores completion metadata per calendar date (`YYYY-MM-DD`).
  - `GameStatisticsTable`: Tracks lifetime matches, high scores, combos, win streaks.
  - `PlayerWalletsTable`: Persists virtual coin balances and lifetime earnings.
  - `EntitlementsTable`: Persists cryptographic verification signatures and purchase tokens offline.
- **Preferences (`AppPreferences`)**: Fast key-value persistence for themes, accessibility toggles, and tutorial completion flags.

### 2.4 Presentation Layer (`lib/presentation/`)
- **Token-Based Theming**: `AppThemeTokens` defines semantic color and geometry tokens for Canvas, Surfaces, Cells (normal, selected, hinted, invalid), and Controls across 4 themes: Classic Paper, Midnight, Ocean, High Contrast.
- **Touch & Accessibility**: Minimum 44px hit testing targets, reduced motion overrides, text scale factors (0.85x–1.30x), and safe-area respecting responsive layouts.

---

## 3. Local Persistence & Schema Migration

The Drift SQLite database initializes automatically with native background isolates. Future migrations increment `schemaVersion` and register schema migrations within `MigrationStrategy(onUpgrade: (m, from, to) async { ... })`.
