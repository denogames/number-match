abstract class SettingsRepository {
  Future<int> getCoins();
  Future<void> setCoins(int coins);

  Future<String> getThemeId();
  Future<void> setThemeId(String themeId);

  Future<bool> getSystemThemeSync();
  Future<void> setSystemThemeSync(bool sync);

  Future<bool> getHapticFeedbackEnabled();
  Future<void> setHapticFeedbackEnabled(bool enabled);

  Future<bool> getSoundEnabled();
  Future<void> setSoundEnabled(bool enabled);

  Future<bool> getReducedMotion();
  Future<void> setReducedMotion(bool enabled);

  Future<double> getTextScale();
  Future<void> setTextScale(double scale);

  Future<bool> getAnalyticsEnabled();
  Future<void> setAnalyticsEnabled(bool enabled);

  Future<bool> isAdsFreeEntitled();
  Future<void> setAdsFreeEntitled(
    bool entitled, {
    String? transactionId,
    String? signature,
  });
}
