import 'dart:math';
import '../models/board_model.dart';
import '../models/cell_model.dart';
import 'hint_finder.dart';

class BoardGenerator {
  static const List<int> classicSequence = [
    1, 2, 3, 4, 5, 6, 7, 8, 9,
    1, 1, 1, 2, 1, 3, 1, 4, 1,
    5, 1, 6, 1, 7, 1, 8, 1, 9,
  ];

  final HintFinder hintFinder;

  const BoardGenerator({this.hintFinder = const HintFinder()});

  // Generates classic starting board (standard 1..19 sequence without 0)
  BoardModel generateClassicBoard({int columns = BoardModel.defaultColumns}) {
    return generateBoardFromValues(classicSequence, columns: columns);
  }

  // Generates a board from a custom sequence of values (e.g. Remote CMS level packs)
  BoardModel generateBoardFromValues(List<int> values, {int columns = BoardModel.defaultColumns}) {
    final cells = <CellModel>[];
    for (int i = 0; i < values.length; i++) {
      cells.add(CellModel(
        id: i,
        index: i,
        value: values[i],
      ));
    }
    return BoardModel(columns: columns, cells: cells);
  }

  // Generates deterministic daily challenge board from a date
  BoardModel generateDailyChallengeBoard(
    DateTime date, {
    int columns = BoardModel.defaultColumns,
    int cellCount = 36, // 4 full rows of 9
  }) {
    final normalizedDate = DateTime.utc(date.year, date.month, date.day);
    final seed = normalizedDate.millisecondsSinceEpoch;
    final random = Random(seed);

    final values = _generateSolvableValues(random, cellCount);
    final cells = <CellModel>[];
    for (int i = 0; i < values.length; i++) {
      cells.add(CellModel(
        id: i,
        index: i,
        value: values[i],
      ));
    }

    final board = BoardModel(columns: columns, cells: cells);
    return board;
  }

  // Generates board for Timed Mode with high match density
  BoardModel generateTimedBoard({
    int? seed,
    int columns = BoardModel.defaultColumns,
    int cellCount = 36,
  }) {
    final random = seed != null ? Random(seed) : Random();
    final values = _generateSolvableValues(random, cellCount);

    final cells = <CellModel>[];
    for (int i = 0; i < values.length; i++) {
      cells.add(CellModel(
        id: i,
        index: i,
        value: values[i],
      ));
    }

    return BoardModel(columns: columns, cells: cells);
  }

  // Generates a list of values 1-9 with guaranteed pairs and match density
  List<int> _generateSolvableValues(Random random, int totalCount) {
    final values = <int>[];
    
    // Generate pairs (identical or sum to 10)
    while (values.length < totalCount) {
      final pairType = random.nextInt(2); // 0: identical, 1: sum to 10
      if (pairType == 0) {
        final val = random.nextInt(9) + 1; // 1..9
        values.add(val);
        values.add(val);
      } else {
        final valA = random.nextInt(9) + 1;
        final valB = 10 - valA;
        values.add(valA);
        values.add(valB);
      }
    }

    if (values.length > totalCount) {
      values.removeRange(totalCount, values.length);
    }

    // Slightly shuffle pairs so adjacent or diagonal matches are formed
    // Deterministic shuffle using random
    for (int i = values.length - 1; i > 0; i--) {
      // 50% chance to swap with nearby element
      if (random.nextBool()) {
        final j = (i - 1 - random.nextInt(min(i, 4))).clamp(0, i - 1);
        final temp = values[i];
        values[i] = values[j];
        values[j] = temp;
      }
    }

    return values;
  }
}
