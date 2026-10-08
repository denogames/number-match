import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/app_constants.dart';

class AppPreferences {
  final SharedPreferences _prefs;

  const AppPreferences(this._prefs);

  static Future<AppPreferences> init() async {
    final prefs = await SharedPreferences.getInstance();
    return AppPreferences(prefs);
  }

  String getThemeId() =>
      _prefs.getString(AppConstants.keyThemeId) ?? 'classic_paper';

  Future<bool> setThemeId(String themeId) =>
      _prefs.setString(AppConstants.keyThemeId, themeId);

  bool getSystemThemeSync() =>
      _prefs.getBool(AppConstants.keySystemThemeSync) ?? false;

  Future<bool> setSystemThemeSync(bool sync) =>
      _prefs.setBool(AppConstants.keySystemThemeSync, sync);

  bool getHapticsEnabled() =>
      _prefs.getBool(AppConstants.keyHapticsEnabled) ?? true;

  Future<bool> setHapticsEnabled(bool enabled) =>
      _prefs.setBool(AppConstants.keyHapticsEnabled, enabled);

  bool getSoundEnabled() =>
      _prefs.getBool(AppConstants.keySoundEnabled) ?? true;

  Future<bool> setSoundEnabled(bool enabled) =>
      _prefs.setBool(AppConstants.keySoundEnabled, enabled);

  bool getReducedMotion() =>
      _prefs.getBool(AppConstants.keyReducedMotion) ?? false;

  Future<bool> setReducedMotion(bool enabled) =>
      _prefs.setBool(AppConstants.keyReducedMotion, enabled);

  double getTextScale() =>
      _prefs.getDouble(AppConstants.keyTextScale) ?? 1.0;

  Future<bool> setTextScale(double scale) =>
      _prefs.setDouble(AppConstants.keyTextScale, scale);

  bool getAnalyticsEnabled() =>
      _prefs.getBool(AppConstants.keyAnalyticsEnabled) ?? true;

  Future<bool> setAnalyticsEnabled(bool enabled) =>
      _prefs.setBool(AppConstants.keyAnalyticsEnabled, enabled);

  bool isTutorialCompleted() =>
      _prefs.getBool(AppConstants.keyTutorialCompleted) ?? false;

  Future<bool> setTutorialCompleted(bool completed) =>
      _prefs.setBool(AppConstants.keyTutorialCompleted, completed);
}
