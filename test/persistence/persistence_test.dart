import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_match/data/local/database/app_database.dart';
import 'package:number_match/data/repositories/game_repository_impl.dart';
import 'package:number_match/data/repositories/stats_repository_impl.dart';
import 'package:number_match/domain/engine/board_generator.dart';
import 'package:number_match/domain/models/game_mode.dart';
import 'package:number_match/domain/models/game_state.dart';

void main() {
  late AppDatabase db;
  late GameRepositoryImpl gameRepo;
  late StatsRepositoryImpl statsRepo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    gameRepo = GameRepositoryImpl(db);
    statsRepo = StatsRepositoryImpl(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('GameRepository - Persistence', () {
    test('saveActiveGame and loadActiveGame restores board and score perfectly', () async {
      const generator = BoardGenerator();
      final board = generator.generateClassicBoard();
      final originalState = GameState(
        id: 'test_session',
        mode: GameMode.classic,
        board: board,
        score: 450,
        combo: 3,
        maxCombo: 5,
        matchesCount: 12,
        addsCount: 1,
        elapsedSeconds: 85,
      );

      await gameRepo.saveActiveGame(originalState);
      final restored = await gameRepo.loadActiveGame(GameMode.classic);

      expect(restored, isNotNull);
      expect(restored!.score, 450);
      expect(restored.combo, 3);
      expect(restored.maxCombo, 5);
      expect(restored.matchesCount, 12);
      expect(restored.addsCount, 1);
      expect(restored.elapsedSeconds, 85);
      expect(restored.board.cells.length, 27);
    });

    test('deleteActiveGame removes saved session', () async {
      const generator = BoardGenerator();
      final state = GameState(
        id: 'test_session',
        mode: GameMode.classic,
        board: generator.generateClassicBoard(),
        score: 100,
      );

      await gameRepo.saveActiveGame(state);
      await gameRepo.deleteActiveGame(GameMode.classic);
      final restored = await gameRepo.loadActiveGame(GameMode.classic);

      expect(restored, isNull);
    });
  });

  group('StatsRepository - Persistence', () {
    test('recordGameResult accumulates games played, wins, streaks, and best scores', () async {
      await statsRepo.recordGameResult(
        mode: GameMode.classic,
        score: 500,
        combo: 4,
        matches: 10,
        adds: 1,
        timeSeconds: 60,
        isWon: true,
      );

      var stats = await statsRepo.getStatistics('classic');
      expect(stats.gamesPlayed, 1);
      expect(stats.gamesWon, 1);
      expect(stats.bestScore, 500);
      expect(stats.totalScore, 500);
      expect(stats.bestCombo, 4);
      expect(stats.currentStreak, 1);

      // Record another game with higher score
      await statsRepo.recordGameResult(
        mode: GameMode.classic,
        score: 800,
        combo: 6,
        matches: 15,
        adds: 2,
        timeSeconds: 90,
        isWon: true,
      );

      stats = await statsRepo.getStatistics('classic');
      expect(stats.gamesPlayed, 2);
      expect(stats.gamesWon, 2);
      expect(stats.bestScore, 800);
      expect(stats.totalScore, 1300);
      expect(stats.bestCombo, 6);
      expect(stats.currentStreak, 2);
      expect(stats.winRate, 100.0);
    });
  });
}
