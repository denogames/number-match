import 'dart:math';
import '../models/cell_model.dart';
import '../models/game_mode.dart';
import '../models/game_state.dart';
import '../models/match_pair.dart';
import '../models/move_history.dart';
import 'board_generator.dart';
import 'hint_finder.dart';
import 'pair_validator.dart';

enum SelectionOutcome {
  cellSelected,
  cellDeselected,
  matchSuccess,
  matchInvalid,
  ignored,
}

class SelectResult {
  final SelectionOutcome outcome;
  final GameState state;
  final MatchPair? matchedPair;
  final int pointsGained;
  final int combo;
  final int rowsClearedCount;
  final bool isBoardCleared;
  final String? message;

  const SelectResult({
    required this.outcome,
    required this.state,
    this.matchedPair,
    this.pointsGained = 0,
    this.combo = 1,
    this.rowsClearedCount = 0,
    this.isBoardCleared = false,
    this.message,
  });
}

class NumberMatchEngine {
  static const int baseMatchPoints = 10;
  static const int sumTenBonusPoints = 15;
  static const int rowClearedBonusPoints = 50;
  static const int boardClearedBonusPoints = 1000;
  static const int maxComboMultiplier = 10;

  final PairValidator validator;
  final HintFinder hintFinder;
  final BoardGenerator boardGenerator;
  final bool autoCompactRows;

  const NumberMatchEngine({
    this.validator = const PairValidator(),
    this.hintFinder = const HintFinder(),
    this.boardGenerator = const BoardGenerator(),
    this.autoCompactRows = true,
  });

  // Initialize Classic Game
  GameState initClassicGame({String? id}) {
    final board = boardGenerator.generateClassicBoard();
    return GameState(
      id: id ?? 'classic_${DateTime.now().millisecondsSinceEpoch}',
      mode: GameMode.classic,
      board: board,
      score: 0,
      combo: 1,
      maxCombo: 1,
      matchesCount: 0,
      addsCount: 0,
      elapsedSeconds: 0,
    );
  }

  // Initialize Daily Challenge Game
  GameState initDailyGame(DateTime date, {String? id}) {
    final normalizedDate = DateTime.utc(date.year, date.month, date.day);
    final board = boardGenerator.generateDailyChallengeBoard(normalizedDate);
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    return GameState(
      id: id ?? 'daily_$dateStr',
      mode: GameMode.daily,
      board: board,
      score: 0,
      combo: 1,
      maxCombo: 1,
      matchesCount: 0,
      addsCount: 0,
      elapsedSeconds: 0,
      seed: normalizedDate.millisecondsSinceEpoch,
    );
  }

  // Initialize Timed Game
  GameState initTimedGame({int durationSeconds = 180, String? id}) {
    final board = boardGenerator.generateTimedBoard();
    return GameState(
      id: id ?? 'timed_${DateTime.now().millisecondsSinceEpoch}',
      mode: GameMode.timed,
      board: board,
      score: 0,
      combo: 1,
      maxCombo: 1,
      matchesCount: 0,
      addsCount: 0,
      elapsedSeconds: 0,
      targetTimeSeconds: durationSeconds,
    );
  }

  // Initialize Game from Custom Level Pack values (Remote LiveOps CMS)
  GameState initCustomLevelGame(List<int> values, {String? id, GameMode mode = GameMode.classic}) {
    final board = boardGenerator.generateBoardFromValues(values);
    return GameState(
      id: id ?? 'pack_${DateTime.now().millisecondsSinceEpoch}',
      mode: mode,
      board: board,
      score: 0,
      combo: 1,
      maxCombo: 1,
      matchesCount: 0,
      addsCount: 0,
      elapsedSeconds: 0,
    );
  }

  // Handle cell selection
  SelectResult selectCell(GameState currentState, int index) {
    if (currentState.isCompleted) {
      return SelectResult(
        outcome: SelectionOutcome.ignored,
        state: currentState,
        message: 'Game is already completed',
      );
    }

    final cell = currentState.board.getCell(index);
    if (cell == null || cell.isCleared) {
      return SelectResult(
        outcome: SelectionOutcome.ignored,
        state: currentState,
      );
    }

    final selectedIdx = currentState.selectedIndex;

    // Case 1: No cell currently selected -> Select this cell
    if (selectedIdx == null) {
      final updated = currentState.copyWith(
        selectedIndex: index,
        clearHint: true,
        clearInvalid: true,
      );
      return SelectResult(
        outcome: SelectionOutcome.cellSelected,
        state: updated,
      );
    }

    // Case 2: Player tapped the already selected cell -> Deselect
    if (selectedIdx == index) {
      final updated = currentState.copyWith(
        clearSelected: true,
        clearHint: true,
        clearInvalid: true,
      );
      return SelectResult(
        outcome: SelectionOutcome.cellDeselected,
        state: updated,
      );
    }

    // Case 3: Player selected a second cell -> Attempt match
    final validation = validator.validate(currentState.board, selectedIdx, index);

    if (!validation.isValid) {
      // Invalid selection: break combo, clear selection, highlight invalid cell
      final updated = currentState.copyWith(
        combo: 1,
        clearSelected: true,
        invalidPairTargetIndex: index,
        clearHint: true,
      );
      return SelectResult(
        outcome: SelectionOutcome.matchInvalid,
        state: updated,
        message: validation.failureMessage,
      );
    }

    // Successful match!
    final cellA = currentState.board.getCell(selectedIdx)!;
    final cellB = currentState.board.getCell(index)!;

    // Snapshot state for undo
    final historyEntry = MoveHistory(
      previousCells: List<CellModel>.from(currentState.board.cells),
      previousScore: currentState.score,
      previousCombo: currentState.combo,
      previousMatchesCount: currentState.matchesCount,
      previousAddsCount: currentState.addsCount,
      actionDescription: 'Matched ${cellA.value} and ${cellB.value}',
    );

    final newUndoHistory = List<MoveHistory>.from(currentState.undoHistory)
      ..add(historyEntry);

    // Update cells to cleared
    final newCells = List<CellModel>.from(currentState.board.cells);
    newCells[selectedIdx] = cellA.copyWith(isCleared: true);
    newCells[index] = cellB.copyWith(isCleared: true);

    var newBoard = currentState.board.copyWith(cells: newCells);

    // Calculate score & combo
    final basePts = validation.reason == MatchReason.sumTen
        ? sumTenBonusPoints
        : baseMatchPoints;
    final currentCombo = currentState.combo;
    int pointsGained = basePts * currentCombo;

    final nextCombo = min(currentCombo + 1, maxComboMultiplier);
    final newMaxCombo = max(currentState.maxCombo, nextCombo);

    // Check row clearance
    final rowCountBefore = newBoard.rowCount;
    final clearedRowsBefore = newBoard.getFullyClearedRows();

    int rowsClearedCount = 0;
    if (autoCompactRows) {
      newBoard = newBoard.compactEmptyRows();
      rowsClearedCount = rowCountBefore - newBoard.rowCount;
    } else {
      rowsClearedCount = clearedRowsBefore.length;
    }

    if (rowsClearedCount > 0) {
      pointsGained += (rowsClearedCount * rowClearedBonusPoints);
    }

    // Check board win condition
    final isBoardCleared = newBoard.isClear;
    if (isBoardCleared) {
      pointsGained += boardClearedBonusPoints;
    }

    final newScore = currentState.score + pointsGained;
    final newMatchesCount = currentState.matchesCount + 1;
    final isGameWon = isBoardCleared;
    final isGameCompleted = isBoardCleared;

    final updatedState = currentState.copyWith(
      board: newBoard,
      score: newScore,
      combo: nextCombo,
      maxCombo: newMaxCombo,
      matchesCount: newMatchesCount,
      clearSelected: true,
      clearHint: true,
      clearInvalid: true,
      isWon: isGameWon,
      isCompleted: isGameCompleted,
      undoHistory: newUndoHistory,
    );

    return SelectResult(
      outcome: SelectionOutcome.matchSuccess,
      state: updatedState,
      matchedPair: MatchPair(
        indexA: selectedIdx,
        indexB: index,
        reason: validation.reason,
      ),
      pointsGained: pointsGained,
      combo: currentCombo,
      rowsClearedCount: rowsClearedCount,
      isBoardCleared: isBoardCleared,
    );
  }

  // Add Numbers: copies all remaining active numbers in reading order
  GameState addNumbers(GameState currentState) {
    if (currentState.isCompleted) return currentState;

    final activeCells =
        currentState.board.cells.where((c) => !c.isCleared).toList();
    if (activeCells.isEmpty) return currentState;

    // Snapshot state for undo
    final historyEntry = MoveHistory(
      previousCells: List<CellModel>.from(currentState.board.cells),
      previousScore: currentState.score,
      previousCombo: currentState.combo,
      previousMatchesCount: currentState.matchesCount,
      previousAddsCount: currentState.addsCount,
      actionDescription: 'Added ${activeCells.length} numbers',
    );

    final newUndoHistory = List<MoveHistory>.from(currentState.undoHistory)
      ..add(historyEntry);

    final currentCells = List<CellModel>.from(currentState.board.cells);
    int startIndex = currentCells.length;
    int maxId = currentCells.fold(0, (prev, c) => max(prev, c.id));

    for (final active in activeCells) {
      maxId++;
      currentCells.add(CellModel(
        id: maxId,
        index: startIndex,
        value: active.value,
        isCleared: false,
      ));
      startIndex++;
    }

    final newBoard = currentState.board.copyWith(cells: currentCells);

    return currentState.copyWith(
      board: newBoard,
      combo: 1, // Adding numbers resets combo streak
      addsCount: currentState.addsCount + 1,
      clearSelected: true,
      clearHint: true,
      clearInvalid: true,
      undoHistory: newUndoHistory,
    );
  }

  // Undo last action
  GameState undo(GameState currentState) {
    if (!currentState.canUndo) return currentState;

    final history = List<MoveHistory>.from(currentState.undoHistory);
    final lastSnapshot = history.removeLast();

    final restoredBoard = currentState.board.copyWith(
      cells: lastSnapshot.previousCells,
    );

    return currentState.copyWith(
      board: restoredBoard,
      score: lastSnapshot.previousScore,
      combo: lastSnapshot.previousCombo,
      matchesCount: lastSnapshot.previousMatchesCount,
      addsCount: lastSnapshot.previousAddsCount,
      clearSelected: true,
      clearHint: true,
      clearInvalid: true,
      undoHistory: history,
      isCompleted: false,
      isWon: false,
    );
  }

  // Request hint
  GameState requestHint(GameState currentState) {
    if (currentState.isCompleted) return currentState;

    final hint = hintFinder.findFirstHint(currentState.board);
    return currentState.copyWith(
      hintPair: hint,
      clearSelected: true,
      clearInvalid: true,
    );
  }

  // Advance timer by seconds
  GameState tickTimer(GameState currentState, {int seconds = 1}) {
    if (currentState.isCompleted) return currentState;

    final newElapsed = currentState.elapsedSeconds + seconds;
    bool completed = currentState.isCompleted;

    if (currentState.mode == GameMode.timed &&
        currentState.targetTimeSeconds != null &&
        newElapsed >= currentState.targetTimeSeconds!) {
      completed = true;
    }

    return currentState.copyWith(
      elapsedSeconds: newElapsed,
      isCompleted: completed,
    );
  }

  // Check if any valid moves exist
  bool hasAvailableMoves(GameState state) {
    return hintFinder.hasAnyValidMoves(state.board);
  }
}
