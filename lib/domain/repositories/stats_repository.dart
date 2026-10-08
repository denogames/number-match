import '../models/game_mode.dart';
import '../models/game_statistics.dart';

abstract class StatsRepository {
  Future<GameStatistics> getStatistics(String modeKey);
  Future<void> saveStatistics(String modeKey, GameStatistics stats);
  Future<void> recordGameResult({
    required GameMode mode,
    required int score,
    required int combo,
    required int matches,
    required int adds,
    required int timeSeconds,
    required bool isWon,
  });
}
