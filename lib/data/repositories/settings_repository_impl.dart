import 'package:drift/drift.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/game_constants.dart';
import '../../domain/repositories/settings_repository.dart';
import '../local/database/app_database.dart';
import '../local/preferences/app_preferences.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final AppPreferences preferences;
  final AppDatabase database;

  static const String walletKey = 'player_wallet';

  const SettingsRepositoryImpl({
    required this.preferences,
    required this.database,
  });

  @override
  Future<int> getCoins() async {
    final query = database.select(database.playerWalletsTable)
      ..where((tbl) => tbl.id.equals(walletKey));
    final entry = await query.getSingleOrNull();
    if (entry == null) {
      // Initialize with default
      await database.into(database.playerWalletsTable).insert(
            PlayerWalletsTableCompanion(
              id: const Value(walletKey),
              coins: const Value(GameConstants.startingCoins),
              totalCoinsEarned: const Value(GameConstants.startingCoins),
              totalCoinsSpent: const Value(0),
            ),
          );
      return GameConstants.startingCoins;
    }
    return entry.coins;
  }

  @override
  Future<void> setCoins(int coins) async {
    final query = database.select(database.playerWalletsTable)
      ..where((tbl) => tbl.id.equals(walletKey));
    final existing = await query.getSingleOrNull();

    final prevCoins = existing?.coins ?? GameConstants.startingCoins;
    final prevEarned = existing?.totalCoinsEarned ?? GameConstants.startingCoins;
    final prevSpent = existing?.totalCoinsSpent ?? 0;

    int newEarned = prevEarned;
    int newSpent = prevSpent;
    if (coins > prevCoins) {
      newEarned += (coins - prevCoins);
    } else if (coins < prevCoins) {
      newSpent += (prevCoins - coins);
    }

    await database.into(database.playerWalletsTable).insertOnConflictUpdate(
          PlayerWalletsTableCompanion(
            id: const Value(walletKey),
            coins: Value(coins),
            totalCoinsEarned: Value(newEarned),
            totalCoinsSpent: Value(newSpent),
          ),
        );
  }

  @override
  Future<String> getThemeId() async => preferences.getThemeId();

  @override
  Future<void> setThemeId(String themeId) async =>
      preferences.setThemeId(themeId);

  @override
  Future<bool> getSystemThemeSync() async => preferences.getSystemThemeSync();

  @override
  Future<void> setSystemThemeSync(bool sync) async =>
      preferences.setSystemThemeSync(sync);

  @override
  Future<bool> getHapticFeedbackEnabled() async =>
      preferences.getHapticsEnabled();

  @override
  Future<void> setHapticFeedbackEnabled(bool enabled) async =>
      preferences.setHapticsEnabled(enabled);

  @override
  Future<bool> getSoundEnabled() async => preferences.getSoundEnabled();

  @override
  Future<void> setSoundEnabled(bool enabled) async =>
      preferences.setSoundEnabled(enabled);

  @override
  Future<bool> getReducedMotion() async => preferences.getReducedMotion();

  @override
  Future<void> setReducedMotion(bool enabled) async =>
      preferences.setReducedMotion(enabled);

  @override
  Future<double> getTextScale() async => preferences.getTextScale();

  @override
  Future<void> setTextScale(double scale) async =>
      preferences.setTextScale(scale);

  @override
  Future<bool> getAnalyticsEnabled() async => preferences.getAnalyticsEnabled();

  @override
  Future<void> setAnalyticsEnabled(bool enabled) async =>
      preferences.setAnalyticsEnabled(enabled);

  @override
  Future<bool> isAdsFreeEntitled() async {
    final query = database.select(database.entitlementsTable)
      ..where((tbl) => tbl.productId.equals(AppConstants.adsFreeProductId));
    final entry = await query.getSingleOrNull();
    return entry?.isEntitled ?? false;
  }

  @override
  Future<void> setAdsFreeEntitled(
    bool entitled, {
    String? transactionId,
    String? signature,
  }) async {
    await database.into(database.entitlementsTable).insertOnConflictUpdate(
          EntitlementsTableCompanion(
            productId: Value(AppConstants.adsFreeProductId),
            isEntitled: Value(entitled),
            purchasedAt: Value(entitled ? DateTime.now() : null),
            transactionId: Value(transactionId),
            signature: Value(signature),
            isSandbox: const Value(false),
          ),
        );
  }
}
