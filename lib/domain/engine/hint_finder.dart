import '../models/board_model.dart';
import '../models/match_pair.dart';
import 'pair_validator.dart';

class HintFinder {
  final PairValidator validator;

  const HintFinder({this.validator = const PairValidator()});

  // Find the first available matching pair on the board
  MatchPair? findFirstHint(BoardModel board) {
    final cells = board.cells;
    final total = cells.length;

    for (int i = 0; i < total; i++) {
      if (cells[i].isCleared) continue;

      for (int j = i + 1; j < total; j++) {
        if (cells[j].isCleared) continue;

        final result = validator.validate(board, i, j);
        if (result.isValid) {
          return MatchPair(
            indexA: i,
            indexB: j,
            reason: result.reason,
          );
        }
      }
    }
    return null;
  }

  // Find all currently available valid matches on the board
  List<MatchPair> findAllHints(BoardModel board) {
    final matches = <MatchPair>[];
    final cells = board.cells;
    final total = cells.length;

    for (int i = 0; i < total; i++) {
      if (cells[i].isCleared) continue;

      for (int j = i + 1; j < total; j++) {
        if (cells[j].isCleared) continue;

        final result = validator.validate(board, i, j);
        if (result.isValid) {
          matches.add(MatchPair(
            indexA: i,
            indexB: j,
            reason: result.reason,
          ));
        }
      }
    }
    return matches;
  }

  // Check if any valid move exists on the board
  bool hasAnyValidMoves(BoardModel board) {
    return findFirstHint(board) != null;
  }
}
