import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/audio/audio_feedback_service.dart';
import '../core/haptics/haptic_feedback_service.dart';
import '../data/local/database/app_database.dart';
import '../data/local/preferences/app_preferences.dart';
import '../data/repositories/game_repository_impl.dart';
import '../data/repositories/settings_repository_impl.dart';
import '../data/repositories/stats_repository_impl.dart';
import '../domain/engine/number_match_engine.dart';
import '../domain/repositories/game_repository.dart';
import '../domain/repositories/settings_repository.dart';
import '../domain/repositories/stats_repository.dart';
import 'analytics/analytics_service.dart';
import 'economy/reward_service.dart';
import 'monetization/ads/ad_provider.dart';
import 'monetization/ads/ad_service.dart';
import 'monetization/ads/mock_ad_provider.dart';
import 'monetization/iap/entitlement_state.dart';
import 'monetization/iap/iap_service.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_state.dart';
import '../domain/models/game_state.dart';
import 'game/game_controller.dart';

// Foundation providers overridden in main.dart bootstrap
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider must be initialized');
});

final preferencesProvider = Provider<AppPreferences>((ref) {
  throw UnimplementedError('preferencesProvider must be initialized');
});

// Repositories
final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return GameRepositoryImpl(db);
});

final statsRepositoryProvider = Provider<StatsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return StatsRepositoryImpl(db);
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final prefs = ref.watch(preferencesProvider);
  return SettingsRepositoryImpl(preferences: prefs, database: db);
});

// Analytics & Entitlement
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

final entitlementStateProvider = Provider<EntitlementState>((ref) {
  return EntitlementState();
});

// Economy
final rewardServiceProvider = Provider<RewardService>((ref) {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  final analytics = ref.watch(analyticsServiceProvider);
  return RewardService(
    settingsRepository: settingsRepo,
    analyticsService: analytics,
  );
});

// Monetization
final adProviderProvider = Provider<AdProvider>((ref) {
  return MockAdProvider();
});

final adServiceProvider = Provider<AdService>((ref) {
  final provider = ref.watch(adProviderProvider);
  final analytics = ref.watch(analyticsServiceProvider);
  final entitlement = ref.watch(entitlementStateProvider);
  return AdService(
    provider: provider,
    analyticsService: analytics,
    entitlementState: entitlement,
  );
});

final iapServiceProvider = Provider<IapService>((ref) {
  final settingsRepo = ref.watch(settingsRepositoryProvider);
  final analytics = ref.watch(analyticsServiceProvider);
  final entitlement = ref.watch(entitlementStateProvider);
  return IapService(
    settingsRepository: settingsRepo,
    analyticsService: analytics,
    entitlementState: entitlement,
  );
});

// Settings Controller
final settingsControllerProvider =
    NotifierProvider<SettingsController, SettingsState>(SettingsController.new);

// Feedback services
final hapticServiceProvider = Provider<HapticFeedbackService>((ref) {
  final settings = ref.watch(settingsControllerProvider);
  return HapticFeedbackService(isEnabled: settings.hapticsEnabled);
});

final audioServiceProvider = Provider<AudioFeedbackService>((ref) {
  final settings = ref.watch(settingsControllerProvider);
  return AudioFeedbackService(isEnabled: settings.soundEnabled);
});

// Game Engine
final gameEngineProvider = Provider<NumberMatchEngine>((ref) {
  return const NumberMatchEngine(autoCompactRows: true);
});

// Game Controller
final gameControllerProvider =
    NotifierProvider<GameController, GameState?>(GameController.new);


