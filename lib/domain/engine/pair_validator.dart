import 'dart:math';
import '../models/board_model.dart';
import '../models/match_pair.dart';

class PairValidationResult {
  final bool isValid;
  final MatchReason reason;
  final String? failureMessage;

  const PairValidationResult.valid(this.reason)
      : isValid = true,
        failureMessage = null;

  const PairValidationResult.invalid(this.failureMessage)
      : isValid = false,
        reason = MatchReason.none;

  @override
  String toString() => isValid
      ? 'Valid match (${reason.name})'
      : 'Invalid match ($failureMessage)';
}

class PairValidator {
  const PairValidator();

  PairValidationResult validate(BoardModel board, int indexA, int indexB) {
    if (indexA == indexB) {
      return const PairValidationResult.invalid('Cannot match a cell with itself');
    }

    final cellA = board.getCell(indexA);
    final cellB = board.getCell(indexB);

    if (cellA == null || cellB == null) {
      return const PairValidationResult.invalid('Cell index out of bounds');
    }

    if (cellA.isCleared || cellB.isCleared) {
      return const PairValidationResult.invalid('One or both cells are already cleared');
    }

    // Check value match rule: identical OR sum to 10
    final isIdentical = cellA.value == cellB.value;
    final isSumTen = cellA.value + cellB.value == 10;

    if (!isIdentical && !isSumTen) {
      return const PairValidationResult.invalid(
          'Numbers must be equal or sum to 10');
    }

    final matchReason = isIdentical ? MatchReason.sameValue : MatchReason.sumTen;

    // Check spatial / reading order accessibility
    if (_isSelectable(board, indexA, indexB)) {
      return PairValidationResult.valid(matchReason);
    }

    return const PairValidationResult.invalid(
        'Cells must be consecutive in reading order or aligned horizontally, vertically, or diagonally with clear path');
  }

  bool isSelectable(BoardModel board, int indexA, int indexB) {
    return _isSelectable(board, indexA, indexB);
  }

  bool _isSelectable(BoardModel board, int indexA, int indexB) {
    if (indexA == indexB) return false;

    final first = min(indexA, indexB);
    final second = max(indexA, indexB);

    // Rule 3a: Consecutive non-empty cells in reading order (including across row boundaries)
    if (_isReadingOrderConsecutive(board, first, second)) {
      return true;
    }

    final rA = board.rowOf(first);
    final cA = board.colOf(first);
    final rB = board.rowOf(second);
    final cB = board.colOf(second);

    // Rule 3b: Same row (all intermediate cells empty)
    // Note: in reading order, row intermediate is already covered by reading order,
    // but check explicitly for safety:
    if (rA == rB) {
      if (_isSameRowClear(board, rA, min(cA, cB), max(cA, cB))) {
        return true;
      }
    }

    // Rule 3c: Same column (all intermediate cells empty)
    if (cA == cB) {
      if (_isSameColumnClear(board, cA, min(rA, rB), max(rA, rB))) {
        return true;
      }
    }

    // Rule 3d: Same diagonal (all intermediate cells empty)
    if ((rA - rB).abs() == (cA - cB).abs() && (rA - rB).abs() > 0) {
      if (_isDiagonalClear(board, rA, cA, rB, cB)) {
        return true;
      }
    }

    return false;
  }

  // Check if all cells between index `first` and `second` in reading order are cleared
  bool _isReadingOrderConsecutive(BoardModel board, int first, int second) {
    if (second == first + 1) return true;
    for (int i = first + 1; i < second; i++) {
      final cell = board.getCell(i);
      if (cell == null || !cell.isCleared) {
        return false;
      }
    }
    return true;
  }

  bool _isSameRowClear(BoardModel board, int row, int colStart, int colEnd) {
    for (int c = colStart + 1; c < colEnd; c++) {
      final cell = board.getCellAt(row, c);
      if (cell == null || !cell.isCleared) {
        return false;
      }
    }
    return true;
  }

  bool _isSameColumnClear(BoardModel board, int col, int rowStart, int rowEnd) {
    for (int r = rowStart + 1; r < rowEnd; r++) {
      final cell = board.getCellAt(r, col);
      if (cell == null || !cell.isCleared) {
        return false;
      }
    }
    return true;
  }

  bool _isDiagonalClear(BoardModel board, int r1, int c1, int r2, int c2) {
    final dr = (r2 - r1).sign;
    final dc = (c2 - c1).sign;
    final steps = (r2 - r1).abs();

    for (int s = 1; s < steps; s++) {
      final checkRow = r1 + s * dr;
      final checkCol = c1 + s * dc;
      final cell = board.getCellAt(checkRow, checkCol);
      if (cell == null || !cell.isCleared) {
        return false;
      }
    }
    return true;
  }
}
