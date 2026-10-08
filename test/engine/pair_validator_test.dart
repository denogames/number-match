import 'package:flutter_test/flutter_test.dart';
import 'package:number_match/domain/engine/pair_validator.dart';
import 'package:number_match/domain/models/board_model.dart';
import 'package:number_match/domain/models/cell_model.dart';
import 'package:number_match/domain/models/match_pair.dart';

void main() {
  const validator = PairValidator();

  BoardModel createBoard(List<int> values, {Set<int> clearedIndices = const {}}) {
    final cells = <CellModel>[];
    for (int i = 0; i < values.length; i++) {
      cells.add(CellModel(
        id: i,
        index: i,
        value: values[i],
        isCleared: clearedIndices.contains(i),
      ));
    }
    return BoardModel(columns: 9, cells: cells);
  }

  group('PairValidator - Value Rules', () {
    test('identical numbers match', () {
      final board = createBoard([5, 5]);
      final result = validator.validate(board, 0, 1);
      expect(result.isValid, isTrue);
      expect(result.reason, MatchReason.sameValue);
    });

    test('numbers summing to 10 match', () {
      final board = createBoard([3, 7]);
      final result = validator.validate(board, 0, 1);
      expect(result.isValid, isTrue);
      expect(result.reason, MatchReason.sumTen);
    });

    test('different numbers not summing to 10 do not match', () {
      final board = createBoard([3, 8]);
      final result = validator.validate(board, 0, 1);
      expect(result.isValid, isFalse);
    });

    test('matching a cell with itself is invalid', () {
      final board = createBoard([5, 5]);
      final result = validator.validate(board, 0, 0);
      expect(result.isValid, isFalse);
    });

    test('cleared cells cannot match', () {
      final board = createBoard([5, 5], clearedIndices: {0});
      final result = validator.validate(board, 0, 1);
      expect(result.isValid, isFalse);
    });
  });

  group('PairValidator - Reading Order Adjacency', () {
    test('adjacent cells in reading order match', () {
      // 0 and 1 are adjacent
      final board = createBoard([4, 6]);
      final result = validator.validate(board, 0, 1);
      expect(result.isValid, isTrue);
    });

    test('cells separated by cleared cells in reading order match', () {
      // 0 and 3 are separated by 1 and 2 which are cleared
      final board = createBoard([4, 9, 9, 6], clearedIndices: {1, 2});
      final result = validator.validate(board, 0, 3);
      expect(result.isValid, isTrue);
      expect(result.reason, MatchReason.sumTen);
    });

    test('cells separated by non-cleared cells in reading order do not match (if not aligned)', () {
      // 0 and 3 separated by 1 (uncleared) and 2 (cleared)
      final board = createBoard([4, 2, 9, 6], clearedIndices: {2});
      final result = validator.validate(board, 0, 3);
      expect(result.isValid, isFalse);
    });

    test('row boundary: last cell of row 0 and first cell of row 1 match', () {
      // Index 8 is row 0 col 8; Index 9 is row 1 col 0
      final values = List.filled(18, 2);
      final board = createBoard(values);
      final result = validator.validate(board, 8, 9);
      expect(result.isValid, isTrue);
    });

    test('row boundary across cleared cells in between matches', () {
      // Index 7 and Index 11 with 8, 9, 10 cleared
      final values = List.filled(18, 5);
      final board = createBoard(values, clearedIndices: {8, 9, 10});
      final result = validator.validate(board, 7, 11);
      expect(result.isValid, isTrue);
    });
  });

  group('PairValidator - Geometrical Alignment', () {
    test('same column with cleared intermediate cells match', () {
      // Row 0 Col 3 (index 3) and Row 2 Col 3 (index 21)
      // Intermediate is Row 1 Col 3 (index 12)
      final values = List.filled(27, 4);
      final board = createBoard(values, clearedIndices: {12});
      final result = validator.validate(board, 3, 21);
      expect(result.isValid, isTrue);
      expect(result.reason, MatchReason.sameValue);
    });

    test('same column with active intermediate cell is blocked', () {
      final values = List.filled(27, 4);
      final board = createBoard(values); // index 12 is active
      final result = validator.validate(board, 3, 21);
      expect(result.isValid, isFalse);
    });

    test('diagonal with cleared intermediate cells match', () {
      // (Row 0, Col 0 -> index 0) and (Row 2, Col 2 -> index 20)
      // Intermediate is (Row 1, Col 1 -> index 10)
      final values = List.filled(27, 7);
      values[0] = 3;
      values[20] = 7;
      final board = createBoard(values, clearedIndices: {10});
      final result = validator.validate(board, 0, 20);
      expect(result.isValid, isTrue);
      expect(result.reason, MatchReason.sumTen);
    });

    test('anti-diagonal with cleared intermediate cells match', () {
      // (Row 0, Col 4 -> index 4) and (Row 2, Col 2 -> index 20)
      // Intermediate is (Row 1, Col 3 -> index 12)
      final values = List.filled(27, 8);
      values[4] = 8;
      values[20] = 8;
      final board = createBoard(values, clearedIndices: {12});
      final result = validator.validate(board, 4, 20);
      expect(result.isValid, isTrue);
      expect(result.reason, MatchReason.sameValue);
    });
  });
}
