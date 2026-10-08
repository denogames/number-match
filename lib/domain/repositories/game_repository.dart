import '../models/daily_challenge_meta.dart';
import '../models/game_mode.dart';
import '../models/game_state.dart';

abstract class GameRepository {
  Future<GameState?> loadActiveGame(GameMode mode);
  Future<void> saveActiveGame(GameState state);
  Future<void> deleteActiveGame(GameMode mode);
  Future<DailyChallengeMeta?> getDailyChallenge(String dateKey);
  Future<void> saveDailyChallenge(DailyChallengeMeta meta);
  Future<List<DailyChallengeMeta>> getAllDailyChallenges();
}
