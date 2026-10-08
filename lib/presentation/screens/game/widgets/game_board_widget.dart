import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_tokens.dart';
import '../../../../domain/models/board_model.dart';
import '../../../../domain/models/match_pair.dart';
import 'cell_tile_widget.dart';

class GameBoardWidget extends StatelessWidget {
  final BoardModel board;
  final int? selectedIndex;
  final MatchPair? hintPair;
  final int? invalidIndex;
  final ValueChanged<int> onCellTap;
  final AppThemeTokens theme;
  final double textScale;
  final bool reducedMotion;
  final ScrollController scrollController;

  const GameBoardWidget({
    super.key,
    required this.board,
    required this.selectedIndex,
    required this.hintPair,
    required this.invalidIndex,
    required this.onCellTap,
    required this.theme,
    required this.scrollController,
    this.textScale = 1.0,
    this.reducedMotion = false,
  });

  @override
  Widget build(BuildContext context) {
    final cells = board.cells;

    return Container(
      decoration: BoxDecoration(
        color: theme.surfaceSubtle.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.divider.withValues(alpha: 0.6),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: GridView.builder(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: cells.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: BoardModel.defaultColumns,
          childAspectRatio: 0.95,
        ),
        itemBuilder: (context, index) {
          final cell = cells[index];
          final isSelected = selectedIndex == index;
          final isHinted = hintPair != null && hintPair!.contains(index);
          final isInvalid = invalidIndex == index;

          return CellTileWidget(
            key: ValueKey('cell_${cell.id}'),
            cell: cell,
            isSelected: isSelected,
            isHinted: isHinted,
            isInvalid: isInvalid,
            onTap: () => onCellTap(index),
            theme: theme,
            textScale: textScale,
            reducedMotion: reducedMotion,
          );
        },
      ),
    );
  }
}
