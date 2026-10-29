import 'package:studio_core_sdk/studio_core_sdk.dart';
import '../../../domain/models/daily_challenge_meta.dart';
import '../../../domain/models/game_mode.dart';
import '../../../domain/models/game_state.dart';
import '../../../domain/models/game_statistics.dart';

/// Crash-safe persistent storage vault for Number Match game sessions, daily challenges,
/// and statistics, backed by Studio Core SDK's [EncryptedStorageBox].
class GameStateVault {
  static GameStateVault? _instance;
  static GameStateVault get instance => _instance ??= GameStateVault._();

  EncryptedStorageBox? _storageBox;

  GameStateVault._();

  bool get isInitialized => _storageBox != null && _storageBox!.isInitialized;

  EncryptedStorageBox get box {
    final b = _storageBox;
    if (b == null) {
      throw StateError('GameStateVault has not been initialized. Call initialize() first.');
    }
    return b;
  }

  /// Initializes the encrypted storage box inside the application support directory vault.
  Future<void> initialize({
    required String storageDirectoryPath,
    String encryptionKey = 'number_match_prod_hmac_secret_2026',
    String boxName = 'number_match_game_vault',
  }) async {
    final storageBox = EncryptedStorageBox(
      boxName: boxName,
      encryptionKey: encryptionKey,
      storageDirectoryPath: storageDirectoryPath,
    );
    await storageBox.initialize();
    _storageBox = storageBox;
  }

  // Active game session
  Future<void> saveActiveGame(GameState state) async {
    if (!isInitialized) return;
    await box.put('session_${state.mode.storageKey}', state.toJson());
  }

  GameState? loadActiveGame(GameMode mode) {
    if (!isInitialized) return null;
    final raw = box.get<Map<String, dynamic>>('session_${mode.storageKey}');
    if (raw == null) return null;
    try {
      return GameState.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteActiveGame(GameMode mode) async {
    if (!isInitialized) return;
    await box.delete('session_${mode.storageKey}');
  }

  // Daily Challenge
  Future<void> saveDailyChallenge(DailyChallengeMeta meta) async {
    if (!isInitialized) return;
    await box.put('daily_${meta.dateKey}', meta.toJson());
  }

  DailyChallengeMeta? getDailyChallenge(String dateKey) {
    if (!isInitialized) return null;
    final raw = box.get<Map<String, dynamic>>('daily_$dateKey');
    if (raw == null) return null;
    try {
      return DailyChallengeMeta.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  List<DailyChallengeMeta> getAllDailyChallenges() {
    if (!isInitialized) return const [];
    final List<DailyChallengeMeta> results = [];
    for (final key in box.keys) {
      if (key.startsWith('daily_')) {
        final raw = box.get<Map<String, dynamic>>(key);
        if (raw != null) {
          try {
            results.add(DailyChallengeMeta.fromJson(raw));
          } catch (_) {}
        }
      }
    }
    return results;
  }

  // Statistics
  Future<void> saveStatistics(String modeKey, GameStatistics stats) async {
    if (!isInitialized) return;
    await box.put('stats_$modeKey', stats.toJson());
  }

  GameStatistics? getStatistics(String modeKey) {
    if (!isInitialized) return null;
    final raw = box.get<Map<String, dynamic>>('stats_$modeKey');
    if (raw == null) return null;
    try {
      return GameStatistics.fromJson(raw);
    } catch (_) {
      return null;
    }
  }

  /// Wipes all entries in the game vault box.
  Future<void> clear() async {
    if (!isInitialized) return;
    await box.clear();
  }
}
