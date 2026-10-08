import 'dart:convert';
import 'package:drift/drift.dart';
import '../../domain/models/board_model.dart';
import '../../domain/models/daily_challenge_meta.dart';
import '../../domain/models/game_mode.dart';
import '../../domain/models/game_state.dart';
import '../../domain/models/move_history.dart';
import '../../domain/repositories/game_repository.dart';
import '../local/database/app_database.dart';

class GameRepositoryImpl implements GameRepository {
  final AppDatabase database;

  const GameRepositoryImpl(this.database);

  @override
  Future<GameState?> loadActiveGame(GameMode mode) async {
    final sessionKey = '${mode.storageKey}_active';
    final query = database.select(database.gameSessionsTable)
      ..where((tbl) => tbl.id.equals(sessionKey));
    final entry = await query.getSingleOrNull();

    if (entry == null) return null;

    final boardJson = jsonDecode(entry.boardJson) as Map<String, dynamic>;
    final board = BoardModel.fromJson(boardJson);

    final undoJsonList = jsonDecode(entry.undoHistoryJson) as List<dynamic>;
    final undoHistory = undoJsonList
        .map((u) => MoveHistory.fromJson(u as Map<String, dynamic>))
        .toList();

    return GameState(
      id: entry.id,
      mode: GameModeExtension.fromStorageKey(entry.mode),
      board: board,
      score: entry.score,
      combo: entry.combo,
      maxCombo: entry.maxCombo,
      matchesCount: entry.matchesCount,
      addsCount: entry.addsCount,
      elapsedSeconds: entry.elapsedSeconds,
      selectedIndex: entry.selectedIndex,
      isCompleted: entry.isCompleted,
      isWon: entry.isWon,
      targetScore: entry.targetScore,
      targetTimeSeconds: entry.targetTimeSeconds,
      seed: entry.seed,
      undoHistory: undoHistory,
    );
  }

  @override
  Future<void> saveActiveGame(GameState state) async {
    final sessionKey = '${state.mode.storageKey}_active';
    final boardJsonStr = jsonEncode(state.board.toJson());
    final undoJsonStr = jsonEncode(state.undoHistory.map((u) => u.toJson()).toList());

    await database.into(database.gameSessionsTable).insertOnConflictUpdate(
          GameSessionsTableCompanion(
            id: Value(sessionKey),
            mode: Value(state.mode.storageKey),
            boardJson: Value(boardJsonStr),
            score: Value(state.score),
            combo: Value(state.combo),
            maxCombo: Value(state.maxCombo),
            matchesCount: Value(state.matchesCount),
            addsCount: Value(state.addsCount),
            elapsedSeconds: Value(state.elapsedSeconds),
            selectedIndex: Value(state.selectedIndex),
            isCompleted: Value(state.isCompleted),
            isWon: Value(state.isWon),
            targetScore: Value(state.targetScore),
            targetTimeSeconds: Value(state.targetTimeSeconds),
            seed: Value(state.seed),
            undoHistoryJson: Value(undoJsonStr),
            updatedAt: Value(DateTime.now()),
          ),
        );
  }

  @override
  Future<void> deleteActiveGame(GameMode mode) async {
    final sessionKey = '${mode.storageKey}_active';
    await (database.delete(database.gameSessionsTable)
          ..where((tbl) => tbl.id.equals(sessionKey)))
        .go();
  }

  @override
  Future<DailyChallengeMeta?> getDailyChallenge(String dateKey) async {
    final query = database.select(database.dailyChallengesTable)
      ..where((tbl) => tbl.dateKey.equals(dateKey));
    final entry = await query.getSingleOrNull();
    if (entry == null) return null;

    return DailyChallengeMeta(
      dateKey: entry.dateKey,
      isCompleted: entry.isCompleted,
      score: entry.score,
      moves: entry.moves,
      elapsedSeconds: entry.elapsedSeconds,
      completedAt: entry.completedAt,
    );
  }

  @override
  Future<void> saveDailyChallenge(DailyChallengeMeta meta) async {
    await database.into(database.dailyChallengesTable).insertOnConflictUpdate(
          DailyChallengesTableCompanion(
            dateKey: Value(meta.dateKey),
            isCompleted: Value(meta.isCompleted),
            score: Value(meta.score),
            moves: Value(meta.moves),
            elapsedSeconds: Value(meta.elapsedSeconds),
            completedAt: Value(meta.completedAt),
          ),
        );
  }

  @override
  Future<List<DailyChallengeMeta>> getAllDailyChallenges() async {
    final list = await database.select(database.dailyChallengesTable).get();
    return list
        .map((entry) => DailyChallengeMeta(
              dateKey: entry.dateKey,
              isCompleted: entry.isCompleted,
              score: entry.score,
              moves: entry.moves,
              elapsedSeconds: entry.elapsedSeconds,
              completedAt: entry.completedAt,
            ))
        .toList();
  }
}
