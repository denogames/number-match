# Number Match — Production Mobile Game

A complete, production-oriented Number Match mobile game built with **Flutter**, **Riverpod**, **GoRouter**, and **Drift SQLite**. Designed with high visual polish, tactile haptics, responsive touch targets, a token-based theme engine, and a complete monetization architecture (Ads Free non-consumable IAP and smart interstitial/rewarded ads).

---

## 🎮 Core Gameplay & Rules

Number Match is a strategic logic puzzle played on a 9-column dynamic grid.
1. **Values**: Two cells match if their numbers are identical ($v_1 = v_2$) OR their sum is exactly 10 ($v_1 + v_2 = 10$).
2. **Selection Rules**:
   - Consecutive non-empty cells in reading order (including across row boundaries).
   - Horizontally, vertically, or diagonally aligned with all intermediate cells cleared.
3. **Add Numbers**: Duplicates all remaining active cells and appends them to the end of the board.
4. **Combos & Scoring**: Consecutive matches multiply points up to $10\times$. Row clearance and board victory grant huge bonuses.
5. **Undo & Hints**: Instant undo stack restoration and intelligent hint search.

---

## 🚀 Game Modes

- **Classic Mode**: Relaxed, untimed gameplay with automatic state persistence and resume.
- **Daily Challenge**: Date-seeded deterministic puzzle identical for all players on that calendar day, awarding +150 Coins.
- **Timed Rush**: 2-minute high-speed blitz with time bonus additions per match and row clearance.

---

## 🎨 Token-Based Theme Engine

Includes 4 handcrafted, tokenized themes with live switching:
1. **Classic Paper**: Warm cream parchment with ink navy digits.
2. **Midnight**: Dark OLED slate with neon amber accents.
3. **Ocean**: Deep nautical aquamarine with vibrant teal tiles.
4. **High Contrast**: Pure black/white with vivid focus borders (WCAG AAA accessibility).

Supports system dark/light synchronization, reduced motion, text scale factors (0.85x–1.30x), and haptic toggles.

---

## 💰 Monetization & Economy

- **Ads Free (Lifetime)**: Permanent non-consumable product (`com.numbermatch.game.ads_free`).
- **Smart Ad Delivery**: Interstitials appear strictly at natural game breaks with minimum 120s cooldown. Never interrupts active gameplay.
- **Rewarded Perk**: Ads Free players get instant claim privileges for all rewarded coin bonuses without watching ads.
- **Centralized Reward Service**: All coins and hint spending are synchronized and persisted locally in SQLite.

---

## 🛠️ Tech Stack & Architecture

- **Framework**: Flutter 3.47+ & Dart 3.13+
- **Architecture**: Clean Feature-Driven Hexagonal (Domain, Application, Data, Presentation)
- **State Management**: Riverpod 3 (`Notifier`, `NotifierProvider`)
- **Navigation**: `go_router`
- **Local Persistence**: `drift` (SQLite with native background isolates) & `shared_preferences`
- **Monetization**: `in_app_purchase` with `PurchaseVerifier` boundary and offline entitlement cache

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── audio/              # AudioFeedbackService
│   ├── constants/          # GameConstants, AppConstants
│   ├── haptics/            # HapticFeedbackService
│   ├── router/             # GoRouter configuration
│   └── theme/              # AppThemeTokens, AppThemes
├── domain/
│   ├── engine/             # NumberMatchEngine, PairValidator, HintFinder, BoardGenerator
│   ├── models/             # BoardModel, CellModel, GameState, MatchPair, MoveHistory
│   └── repositories/       # GameRepository, StatsRepository, SettingsRepository interfaces
├── application/
│   ├── analytics/          # AnalyticsService, AnalyticsEvent
│   ├── economy/            # RewardService
│   ├── game/               # GameController
│   ├── monetization/       # AdService, IapService, PurchaseVerifier, MockAdProvider
│   ├── settings/           # SettingsController, SettingsState
│   └── providers.dart      # Riverpod dependency injection container
├── data/
│   ├── local/database/     # Drift AppDatabase, SQLite tables
│   ├── local/preferences/  # AppPreferences
│   └── repositories/       # Drift & SharedPreferences repository implementations
└── presentation/
    ├── common/widgets/     # CoinChip, AppButton, CustomAppBar
    └── screens/
        ├── splash/         # Async initialization and routing
        ├── home/           # Dashboard, high score, mode selection
        ├── game/           # Main game screen with board, header, and controls
        ├── daily/          # Daily challenge calendar and completion tracking
        ├── stats/          # Lifetime statistics across all game modes
        ├── shop/           # Ads Free IAP, restore purchases, coin bundles
        ├── settings/       # Themes, accessibility, text scale, haptics
        └── tutorial/       # Interactive hands-on walkthrough
```

---

## 🧪 Testing

Run the automated test suite:
```bash
# Run all tests
flutter test

# Run specific test suites
flutter test test/engine/
flutter test test/persistence/
flutter test test/monetization/
flutter test test/widgets/
```

Verify analyzer passes with 0 issues:
```bash
flutter analyze
```

---

## 📱 Building the Application

### Android
```bash
# Generate Drift database code (already committed)
dart run build_runner build

# Run on connected device / emulator (specifying platform reduces APK size from ~175MB to ~84MB)
flutter run --target-platform android-x64

# Build debug APK
flutter build apk --debug --split-per-abi

# Build release APK / App Bundle
flutter build apk --release
flutter build appbundle --release
```

> **Note on Android Emulators**: Universal debug APKs bundle multiple native architecture libraries (`sqlite3`, Flutter engine for arm, arm64, x86, x86_64) totaling ~175MB. If your emulator has limited disk partition space and shows `INSTALL_FAILED_INSUFFICIENT_STORAGE`, run:
> ```bash
> flutter run --target-platform android-x64
> ```
> Or install the split ABI directly:
> ```bash
> flutter build apk --debug --split-per-abi
> adb install -r build/app/outputs/flutter-apk/app-x86_64-debug.apk
> ```

### iOS
```bash
# Build iOS bundle (macOS required)
flutter build ipa --release
```
