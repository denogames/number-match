import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_themes.dart';
import '../providers.dart';
import 'settings_state.dart';

class SettingsController extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    Future.microtask(() => _loadSettings());
    return const SettingsState();
  }

  Future<void> _loadSettings() async {
    final repository = ref.read(settingsRepositoryProvider);
    final analyticsService = ref.read(analyticsServiceProvider);

    final themeId = await repository.getThemeId();
    final systemSync = await repository.getSystemThemeSync();
    final haptics = await repository.getHapticFeedbackEnabled();
    final sound = await repository.getSoundEnabled();
    final reduced = await repository.getReducedMotion();
    final scale = await repository.getTextScale();
    final analytics = await repository.getAnalyticsEnabled();

    final theme = AppThemes.fromId(themeId);

    analyticsService.isEnabled = analytics;

    state = state.copyWith(
      currentTheme: theme,
      systemThemeSync: systemSync,
      hapticsEnabled: haptics,
      soundEnabled: sound,
      reducedMotion: reduced,
      textScale: scale,
      analyticsEnabled: analytics,
    );
  }

  Future<void> setTheme(String themeId) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setThemeId(themeId);
    final theme = AppThemes.fromId(themeId);
    state = state.copyWith(currentTheme: theme);
  }

  Future<void> setSystemThemeSync(bool sync) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setSystemThemeSync(sync);
    state = state.copyWith(systemThemeSync: sync);
  }

  Future<void> setHapticsEnabled(bool enabled) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setHapticFeedbackEnabled(enabled);
    state = state.copyWith(hapticsEnabled: enabled);
  }

  Future<void> setSoundEnabled(bool enabled) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setSoundEnabled(enabled);
    state = state.copyWith(soundEnabled: enabled);
  }

  Future<void> setReducedMotion(bool enabled) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setReducedMotion(enabled);
    state = state.copyWith(reducedMotion: enabled);
  }

  Future<void> setTextScale(double scale) async {
    final repository = ref.read(settingsRepositoryProvider);
    await repository.setTextScale(scale);
    state = state.copyWith(textScale: scale);
  }

  Future<void> setAnalyticsEnabled(bool enabled) async {
    final repository = ref.read(settingsRepositoryProvider);
    final analyticsService = ref.read(analyticsServiceProvider);
    await repository.setAnalyticsEnabled(enabled);
    analyticsService.isEnabled = enabled;
    state = state.copyWith(analyticsEnabled: enabled);
  }
}
