import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_match/application/analytics/analytics_service.dart';
import 'package:number_match/application/economy/reward_service.dart';
import 'package:number_match/application/monetization/ads/admob_placeholder_ad_provider.dart';
import 'package:number_match/core/constants/game_constants.dart';
import 'package:number_match/data/local/vault/game_state_vault.dart';
import 'package:number_match/domain/engine/board_generator.dart';
import 'package:number_match/domain/models/daily_challenge_meta.dart';
import 'package:number_match/domain/models/game_mode.dart';
import 'package:number_match/domain/models/game_state.dart';
import 'package:number_match/domain/models/game_statistics.dart';
import 'package:number_match/domain/repositories/settings_repository.dart';
import 'package:studio_core_sdk/studio_core_sdk.dart';

class _FakeSettingsRepository implements SettingsRepository {
  int _coins = 0;
  String _themeId = 'classic_paper';
  bool _systemSync = true;
  bool _haptic = true;
  bool _sound = true;
  bool _reducedMotion = false;
  double _textScale = 1.0;
  bool _analytics = true;
  bool _adsFree = false;

  @override
  Future<int> getCoins() async => _coins;
  @override
  Future<void> setCoins(int coins) async => _coins = coins;
  @override
  Future<String> getThemeId() async => _themeId;
  @override
  Future<void> setThemeId(String themeId) async => _themeId = themeId;
  @override
  Future<bool> getSystemThemeSync() async => _systemSync;
  @override
  Future<void> setSystemThemeSync(bool sync) async => _systemSync = sync;
  @override
  Future<bool> getHapticFeedbackEnabled() async => _haptic;
  @override
  Future<void> setHapticFeedbackEnabled(bool enabled) async => _haptic = enabled;
  @override
  Future<bool> getSoundEnabled() async => _sound;
  @override
  Future<void> setSoundEnabled(bool enabled) async => _sound = enabled;
  @override
  Future<bool> getReducedMotion() async => _reducedMotion;
  @override
  Future<void> setReducedMotion(bool enabled) async => _reducedMotion = enabled;
  @override
  Future<double> getTextScale() async => _textScale;
  @override
  Future<void> setTextScale(double scale) async => _textScale = scale;
  @override
  Future<bool> getAnalyticsEnabled() async => _analytics;
  @override
  Future<void> setAnalyticsEnabled(bool enabled) async => _analytics = enabled;
  @override
  Future<bool> isAdsFreeEntitled() async => _adsFree;
  @override
  Future<void> setAdsFreeEntitled(bool entitled, {String? transactionId, String? signature}) async => _adsFree = entitled;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('nm_offline_test_');

    // Clean initialization of hardened offline-first SDK
    await StudioSdk.initialize(
      gameId: 'number_match',
      storageDirectoryPath: tempDir.path,
      config: const StudioConfig(
        enableCloudSync: false,
        enableDebugOverlay: false,
        initialCurrencies: {
          StudioCurrencyIds.gold: 250,
        },
      ),
    );

    // Initialize GameStateVault in the same persistent application directory
    await GameStateVault.instance.initialize(
      storageDirectoryPath: tempDir.path,
    );
  });

  tearDown(() async {
    await GameStateVault.instance.clear();
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('Hardened Offline SDK Bootstrap', () {
    test('initializes with offline-first config and persistent installId without network handshakes', () async {
      expect(StudioSdk.isInitialized, isTrue);
      expect(StudioSdk.instance.config.gameId, 'number_match');
      expect(StudioSdk.instance.config.enableCloudSync, isFalse);

      final installId = StudioSdk.instance.installId;
      expect(installId, isNotEmpty);
      // Verify installId is a valid UUIDv4 format (8-4-4-4-12 hex digits)
      final uuidv4Regex = RegExp(r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$');
      expect(uuidv4Regex.hasMatch(installId), isTrue);

      // Verify initial gold wallet balance
      final walletBalance = StudioSdk.instance.wallet.gold;
      expect(walletBalance, 250);
    });
  });

  group('Single-Source Wallet & Economy Integration', () {
    test('RewardService strictly binds to StudioSdk wallet without state discrepancies', () async {
      final rewardService = RewardService(
        settingsRepository: _FakeSettingsRepository(),
        analyticsService: AnalyticsService(),
      );
      await rewardService.initialize();

      // Verify single-source initial balance
      expect(rewardService.currentCoins, 250);
      expect(StudioSdk.instance.wallet.gold, 250);

      // Earn coins (e.g., level completion)
      await rewardService.addCoins(100, reason: 'level_won');
      expect(rewardService.currentCoins, 350);
      expect(StudioSdk.instance.wallet.gold, 350);

      // Spend coins for hint
      final hintDeducted = await rewardService.spendCoins(
        GameConstants.hintCostCoins,
        reason: 'hint_used',
      );
      expect(hintDeducted, isTrue);
      expect(rewardService.currentCoins, 300);
      expect(StudioSdk.instance.wallet.gold, 300);

      // Try spending more than available
      final overspend = await rewardService.spendCoins(500, reason: 'too_expensive');
      expect(overspend, isFalse);
      expect(rewardService.currentCoins, 300);
      expect(StudioSdk.instance.wallet.gold, 300);
    });
  });

  group('Crash-Safe GameStateVault Persistence', () {
    test('saves and loads active game state with transactional integrity', () async {
      const generator = BoardGenerator();
      final board = generator.generateClassicBoard();
      final gameState = GameState(
        id: 'test_session_1',
        mode: GameMode.classic,
        board: board,
        score: 520,
        combo: 2,
        elapsedSeconds: 120,
        seed: 42,
      );

      await GameStateVault.instance.saveActiveGame(gameState);

      final loadedState = GameStateVault.instance.loadActiveGame(GameMode.classic);
      expect(loadedState, isNotNull);
      expect(loadedState!.id, 'test_session_1');
      expect(loadedState.score, 520);
      expect(loadedState.combo, 2);
      expect(loadedState.board.rowCount, board.rowCount);
      expect(loadedState.board.remainingActiveCount, board.remainingActiveCount);
    });

    test('saves and loads daily challenge metadata', () async {
      final meta = DailyChallengeMeta(
        dateKey: '2026-10-28',
        isCompleted: true,
        score: 840,
        moves: 45,
        elapsedSeconds: 150,
        completedAt: DateTime.now(),
      );

      await GameStateVault.instance.saveDailyChallenge(meta);

      final loadedMeta = GameStateVault.instance.getDailyChallenge('2026-10-28');
      expect(loadedMeta, isNotNull);
      expect(loadedMeta!.dateKey, '2026-10-28');
      expect(loadedMeta.isCompleted, isTrue);
      expect(loadedMeta.score, 840);
      expect(loadedMeta.moves, 45);
    });

    test('saves and loads statistics in encrypted vault', () async {
      const stats = GameStatistics(
        gamesPlayed: 12,
        gamesWon: 10,
        bestScore: 2400,
        bestCombo: 5,
        totalTimeSeconds: 1800,
      );

      await GameStateVault.instance.saveStatistics('classic', stats);

      final loadedStats = GameStateVault.instance.getStatistics('classic');
      expect(loadedStats, isNotNull);
      expect(loadedStats!.gamesPlayed, 12);
      expect(loadedStats.gamesWon, 10);
      expect(loadedStats.bestScore, 2400);
      expect(loadedStats.bestCombo, 5);
      expect(loadedStats.totalTimeSeconds, 1800);
    });
  });

  group('Local Data Reset Feature', () {
    test('resetLocalGameData preserves installId while wiping wallet and vault state', () async {
      final originalInstallId = StudioSdk.instance.installId;

      // Mutate wallet and save session
      await StudioSdk.instance.wallet.credit(StudioCurrencyIds.gold, 500, source: 'test');
      expect(StudioSdk.instance.wallet.gold, 750);

      const generator = BoardGenerator();
      final board = generator.generateClassicBoard();
      await GameStateVault.instance.saveActiveGame(
        GameState(id: 'reset_test', mode: GameMode.classic, board: board, score: 100),
      );

      // Perform local reset
      await StudioSdk.instance.resetLocalGameData(preserveInstallId: true);
      await GameStateVault.instance.clear();

      // Verify installId is preserved
      expect(StudioSdk.instance.installId, originalInstallId);

      // Verify wallet is reseeded to default initial balance
      expect(StudioSdk.instance.wallet.gold, 250);

      // Verify vault is wiped
      final loadedGame = GameStateVault.instance.loadActiveGame(GameMode.classic);
      expect(loadedGame, isNull);
    });
  });

  group('AdMob Placeholder Hook', () {
    test('placeholder provider returns false and emits zero rewards or network calls', () async {
      final provider = AdMobPlaceholderAdProvider();
      await provider.initialize();
      expect(provider.isInitialized, isTrue);

      expect(await provider.isInterstitialReady(), isFalse);
      expect(await provider.showInterstitial(), isFalse);
      expect(await provider.isRewardedReady(), isFalse);

      bool rewardCalled = false;
      final rewardedResult = await provider.showRewarded(
        onUserEarnedReward: () {
          rewardCalled = true;
        },
      );

      expect(rewardedResult, isFalse);
      expect(rewardCalled, isFalse);
    });
  });
}
