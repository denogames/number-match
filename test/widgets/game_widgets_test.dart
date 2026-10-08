import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_match/core/theme/app_themes.dart';
import 'package:number_match/domain/engine/board_generator.dart';
import 'package:number_match/domain/models/cell_model.dart';
import 'package:number_match/domain/models/game_mode.dart';
import 'package:number_match/domain/models/game_state.dart';
import 'package:number_match/domain/models/move_history.dart';
import 'package:number_match/presentation/screens/game/widgets/cell_tile_widget.dart';
import 'package:number_match/presentation/screens/game/widgets/game_controls_widget.dart';
import 'package:number_match/presentation/screens/game/widgets/game_header_widget.dart';

void main() {
  const theme = AppThemes.classicPaper;

  group('CellTileWidget Tests', () {
    testWidgets('renders active cell value and responds to tap', (tester) async {
      bool tapped = false;
      const cell = CellModel(id: 1, index: 0, value: 7, isCleared: false);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CellTileWidget(
              cell: cell,
              isSelected: false,
              isHinted: false,
              isInvalid: false,
              theme: theme,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('7'), findsOneWidget);
      await tester.tap(find.text('7'));
      expect(tapped, isTrue);
    });

    testWidgets('cleared cell does not show number', (tester) async {
      const cell = CellModel(id: 2, index: 1, value: 5, isCleared: true);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CellTileWidget(
              cell: cell,
              isSelected: false,
              isHinted: false,
              isInvalid: false,
              theme: theme,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('5'), findsNothing);
    });
  });

  group('GameControlsWidget Tests', () {
    testWidgets('invokes callbacks for Undo, Add Numbers, and Hint', (tester) async {
      bool undoCalled = false;
      bool addCalled = false;
      bool hintCalled = false;

      const generator = BoardGenerator();
      final board = generator.generateClassicBoard();
      final state = GameState(
        id: 'test',
        mode: GameMode.classic,
        board: board,
        undoHistory: [
          MoveHistory(
            previousCells: board.cells,
            previousScore: 0,
            previousCombo: 1,
            previousMatchesCount: 0,
            previousAddsCount: 0,
            actionDescription: 'initial',
          )
        ],
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameControlsWidget(
              state: state,
              theme: theme,
              onUndo: () => undoCalled = true,
              onAddNumbers: () => addCalled = true,
              onHint: () => hintCalled = true,
            ),
          ),
        ),
      );

      expect(find.text('Undo'), findsOneWidget);
      expect(find.text('Hint'), findsOneWidget);

      await tester.tap(find.text('Undo'));
      expect(undoCalled, isTrue);

      await tester.tap(find.text('Hint'));
      expect(hintCalled, isTrue);

      await tester.tap(find.textContaining('Add Numbers'));
      expect(addCalled, isTrue);
    });
  });

  group('GameHeaderWidget Tests', () {
    testWidgets('displays score, combo when > 1, and mode badge', (tester) async {
      const generator = BoardGenerator();
      final board = generator.generateClassicBoard();
      final state = GameState(
        id: 'test',
        mode: GameMode.classic,
        board: board,
        score: 350,
        combo: 3,
        elapsedSeconds: 75,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GameHeaderWidget(
              state: state,
              theme: theme,
              onPause: () {},
            ),
          ),
        ),
      );

      expect(find.text('350'), findsOneWidget);
      expect(find.text('x3 COMBO'), findsOneWidget);
      expect(find.text('Classic'), findsOneWidget);
      expect(find.text('01:15'), findsOneWidget);
    });
  });
}
