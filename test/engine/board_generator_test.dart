import 'package:flutter_test/flutter_test.dart';
import 'package:number_match/domain/engine/board_generator.dart';

void main() {
  const generator = BoardGenerator();

  group('BoardGenerator', () {
    test('generateClassicBoard returns classic 1-19 digits without 0', () {
      final board = generator.generateClassicBoard();
      expect(board.cells.length, 27);
      expect(board.columns, 9);
      expect(board.rowCount, 3);
      expect(board.cells.map((c) => c.value).toList(), BoardGenerator.classicSequence);
    });

    test('generateDailyChallengeBoard is deterministic for same date', () {
      final date = DateTime.utc(2026, 10, 9);
      final board1 = generator.generateDailyChallengeBoard(date);
      final board2 = generator.generateDailyChallengeBoard(date);

      expect(board1.cells.length, board2.cells.length);
      for (int i = 0; i < board1.cells.length; i++) {
        expect(board1.cells[i].value, board2.cells[i].value);
      }
    });

    test('generateDailyChallengeBoard generates different board for different dates', () {
      final date1 = DateTime.utc(2026, 10, 9);
      final date2 = DateTime.utc(2026, 10, 10);
      final board1 = generator.generateDailyChallengeBoard(date1);
      final board2 = generator.generateDailyChallengeBoard(date2);

      final values1 = board1.cells.map((c) => c.value).toList();
      final values2 = board2.cells.map((c) => c.value).toList();
      expect(values1, isNot(equals(values2)));
    });
  });
}
