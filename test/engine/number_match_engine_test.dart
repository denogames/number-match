import 'package:flutter_test/flutter_test.dart';
import 'package:number_match/domain/engine/number_match_engine.dart';
import 'package:number_match/domain/models/board_model.dart';
import 'package:number_match/domain/models/cell_model.dart';
import 'package:number_match/domain/models/game_mode.dart';

void main() {
  late NumberMatchEngine engine;

  setUp(() {
    engine = const NumberMatchEngine();
  });

  group('NumberMatchEngine - Selection and Matching', () {
    test('initClassicGame creates classic board with 27 cells', () {
      final state = engine.initClassicGame();
      expect(state.mode, GameMode.classic);
      expect(state.board.cells.length, 27);
      expect(state.score, 0);
      expect(state.combo, 1);
      expect(state.selectedIndex, isNull);
    });

    test('select first cell marks it as selected', () {
      final state = engine.initClassicGame();
      final result = engine.selectCell(state, 0);
      expect(result.outcome, SelectionOutcome.cellSelected);
      expect(result.state.selectedIndex, 0);
    });

    test('tapping same cell deselects it', () {
      final state = engine.initClassicGame();
      final sel1 = engine.selectCell(state, 0);
      final sel2 = engine.selectCell(sel1.state, 0);
      expect(sel2.outcome, SelectionOutcome.cellDeselected);
      expect(sel2.state.selectedIndex, isNull);
    });

    test('successful match clears cells, updates score, advances combo, and pushes undo', () {
      // Create custom board where index 0 and 1 are 5 and 5
      final cells = [
        const CellModel(id: 0, index: 0, value: 5),
        const CellModel(id: 1, index: 1, value: 5),
        const CellModel(id: 2, index: 2, value: 3),
      ];
      final state = engine.initClassicGame().copyWith(
        board: BoardModel(columns: 9, cells: cells),
      );

      final sel1 = engine.selectCell(state, 0);
      final sel2 = engine.selectCell(sel1.state, 1);

      expect(sel2.outcome, SelectionOutcome.matchSuccess);
      expect(sel2.pointsGained, greaterThan(0));
      expect(sel2.state.score, greaterThan(0));
      expect(sel2.state.matchesCount, 1);
      expect(sel2.state.combo, 2); // combo increased
      expect(sel2.state.canUndo, isTrue);
    });

    test('invalid match resets combo to 1 and preserves board', () {
      // Index 0 has 1, Index 2 has 3 (neither identical nor sum 10)
      final cells = [
        const CellModel(id: 0, index: 0, value: 1),
        const CellModel(id: 1, index: 1, value: 9),
        const CellModel(id: 2, index: 2, value: 3),
      ];
      final state = engine.initClassicGame().copyWith(
        board: BoardModel(columns: 9, cells: cells),
        combo: 4,
      );

      final sel1 = engine.selectCell(state, 0);
      final sel2 = engine.selectCell(sel1.state, 2);

      expect(sel2.outcome, SelectionOutcome.matchInvalid);
      expect(sel2.state.combo, 1); // combo reset
      expect(sel2.state.selectedIndex, isNull);
    });
  });

  group('NumberMatchEngine - Add Numbers and Undo', () {
    test('addNumbers duplicates active cells in reading order', () {
      final cells = [
        const CellModel(id: 0, index: 0, value: 4, isCleared: false),
        const CellModel(id: 1, index: 1, value: 5, isCleared: true),
        const CellModel(id: 2, index: 2, value: 6, isCleared: false),
      ];
      final state = engine.initClassicGame().copyWith(
        board: BoardModel(columns: 9, cells: cells),
      );

      final nextState = engine.addNumbers(state);
      // Active cells were 4 and 6. Should append 4 and 6 to end.
      expect(nextState.board.cells.length, 5);
      expect(nextState.board.cells[3].value, 4);
      expect(nextState.board.cells[4].value, 6);
      expect(nextState.addsCount, 1);
      expect(nextState.canUndo, isTrue);
    });

    test('undo restores previous board, score, combo, and addsCount', () {
      final cells = [
        const CellModel(id: 0, index: 0, value: 5),
        const CellModel(id: 1, index: 1, value: 5),
      ];
      final state = engine.initClassicGame().copyWith(
        board: BoardModel(columns: 9, cells: cells),
        score: 0,
        combo: 1,
      );

      final sel1 = engine.selectCell(state, 0);
      final sel2 = engine.selectCell(sel1.state, 1);
      expect(sel2.state.score, greaterThan(0));

      final undoneState = engine.undo(sel2.state);
      expect(undoneState.score, 0);
      expect(undoneState.combo, 1);
      expect(undoneState.matchesCount, 0);
      expect(undoneState.board.cells[0].isCleared, isFalse);
      expect(undoneState.board.cells[1].isCleared, isFalse);
    });
  });

  group('NumberMatchEngine - Hints', () {
    test('requestHint finds valid pair', () {
      final cells = [
        const CellModel(id: 0, index: 0, value: 2),
        const CellModel(id: 1, index: 1, value: 8),
      ];
      final state = engine.initClassicGame().copyWith(
        board: BoardModel(columns: 9, cells: cells),
      );

      final hintState = engine.requestHint(state);
      expect(hintState.hintPair, isNotNull);
      expect(hintState.hintPair!.indexA, 0);
      expect(hintState.hintPair!.indexB, 1);
    });

    test('requestHint returns null when no moves exist', () {
      final cells = [
        const CellModel(id: 0, index: 0, value: 1),
        const CellModel(id: 1, index: 1, value: 2),
      ];
      final state = engine.initClassicGame().copyWith(
        board: BoardModel(columns: 9, cells: cells),
      );

      final hintState = engine.requestHint(state);
      expect(hintState.hintPair, isNull);
    });
  });
}
