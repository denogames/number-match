import '../../core/theme/app_theme_tokens.dart';
import '../../core/theme/app_themes.dart';

class SettingsState {
  final AppThemeTokens currentTheme;
  final bool systemThemeSync;
  final bool hapticsEnabled;
  final bool soundEnabled;
  final bool reducedMotion;
  final double textScale;
  final bool analyticsEnabled;

  const SettingsState({
    this.currentTheme = AppThemes.classicPaper,
    this.systemThemeSync = false,
    this.hapticsEnabled = true,
    this.soundEnabled = true,
    this.reducedMotion = false,
    this.textScale = 1.0,
    this.analyticsEnabled = true,
  });

  SettingsState copyWith({
    AppThemeTokens? currentTheme,
    bool? systemThemeSync,
    bool? hapticsEnabled,
    bool? soundEnabled,
    bool? reducedMotion,
    double? textScale,
    bool? analyticsEnabled,
  }) {
    return SettingsState(
      currentTheme: currentTheme ?? this.currentTheme,
      systemThemeSync: systemThemeSync ?? this.systemThemeSync,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      textScale: textScale ?? this.textScale,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
    );
  }
}
