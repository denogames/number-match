import 'dart:async';
import 'dart:math';
import 'package:drift/drift.dart';
import '../../domain/models/game_mode.dart';
import '../../domain/models/game_statistics.dart';
import '../../domain/repositories/stats_repository.dart';
import '../local/database/app_database.dart';
import '../local/vault/game_state_vault.dart';

class StatsRepositoryImpl implements StatsRepository {
  final AppDatabase database;

  const StatsRepositoryImpl(this.database);

  @override
  Future<GameStatistics> getStatistics(String modeKey) async {
    // 1. Try crash-safe vault
    if (GameStateVault.instance.isInitialized) {
      final vaulted = GameStateVault.instance.getStatistics(modeKey);
      if (vaulted != null) return vaulted;
    }

    // 2. Fallback to SQLite
    final query = database.select(database.gameStatisticsTable)
      ..where((tbl) => tbl.modeKey.equals(modeKey));
    final entry = await query.getSingleOrNull();

    if (entry == null) {
      return const GameStatistics();
    }

    return GameStatistics(
      gamesPlayed: entry.gamesPlayed,
      gamesWon: entry.gamesWon,
      bestScore: entry.bestScore,
      totalScore: entry.totalScore,
      bestCombo: entry.bestCombo,
      totalPairsMatched: entry.totalPairsMatched,
      totalNumbersAdded: entry.totalNumbersAdded,
      totalTimeSeconds: entry.totalTimeSeconds,
      currentStreak: entry.currentStreak,
      bestStreak: entry.bestStreak,
    );
  }

  @override
  Future<void> saveStatistics(String modeKey, GameStatistics stats) async {
    // 1. Await persistent disk vault write
    if (GameStateVault.instance.isInitialized) {
      await GameStateVault.instance.saveStatistics(modeKey, stats);
    }

    // 2. Update SQLite
    await database.into(database.gameStatisticsTable).insertOnConflictUpdate(
          GameStatisticsTableCompanion(
            modeKey: Value(modeKey),
            gamesPlayed: Value(stats.gamesPlayed),
            gamesWon: Value(stats.gamesWon),
            bestScore: Value(stats.bestScore),
            totalScore: Value(stats.totalScore),
            bestCombo: Value(stats.bestCombo),
            totalPairsMatched: Value(stats.totalPairsMatched),
            totalNumbersAdded: Value(stats.totalNumbersAdded),
            totalTimeSeconds: Value(stats.totalTimeSeconds),
            currentStreak: Value(stats.currentStreak),
            bestStreak: Value(stats.bestStreak),
          ),
        );
  }

  @override
  Future<void> recordGameResult({
    required GameMode mode,
    required int score,
    required int combo,
    required int matches,
    required int adds,
    required int timeSeconds,
    required bool isWon,
  }) async {
    final modeKey = mode.storageKey;
    final currentStats = await getStatistics(modeKey);

    final newGamesPlayed = currentStats.gamesPlayed + 1;
    final newGamesWon = isWon ? currentStats.gamesWon + 1 : currentStats.gamesWon;
    final newBestScore = max(currentStats.bestScore, score);
    final newTotalScore = currentStats.totalScore + score;
    final newBestCombo = max(currentStats.bestCombo, combo);
    final newMatches = currentStats.totalPairsMatched + matches;
    final newAdds = currentStats.totalNumbersAdded + adds;
    final newTime = currentStats.totalTimeSeconds + timeSeconds;
    final newStreak = isWon ? currentStats.currentStreak + 1 : 0;
    final newBestStreak = max(currentStats.bestStreak, newStreak);

    final updatedStats = GameStatistics(
      gamesPlayed: newGamesPlayed,
      gamesWon: newGamesWon,
      bestScore: newBestScore,
      totalScore: newTotalScore,
      bestCombo: newBestCombo,
      totalPairsMatched: newMatches,
      totalNumbersAdded: newAdds,
      totalTimeSeconds: newTime,
      currentStreak: newStreak,
      bestStreak: newBestStreak,
    );

    await saveStatistics(modeKey, updatedStats);

    // Also update global aggregate stats
    final globalStats = await getStatistics('global');
    final updatedGlobal = GameStatistics(
      gamesPlayed: globalStats.gamesPlayed + 1,
      gamesWon: isWon ? globalStats.gamesWon + 1 : globalStats.gamesWon,
      bestScore: max(globalStats.bestScore, score),
      totalScore: globalStats.totalScore + score,
      bestCombo: max(globalStats.bestCombo, combo),
      totalPairsMatched: globalStats.totalPairsMatched + matches,
      totalNumbersAdded: globalStats.totalNumbersAdded + adds,
      totalTimeSeconds: globalStats.totalTimeSeconds + timeSeconds,
      currentStreak: isWon ? globalStats.currentStreak + 1 : 0,
      bestStreak: max(globalStats.bestStreak, isWon ? globalStats.currentStreak + 1 : 0),
    );
    await saveStatistics('global', updatedGlobal);
  }
}
