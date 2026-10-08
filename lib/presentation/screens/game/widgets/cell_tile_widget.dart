import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme_tokens.dart';
import '../../../../domain/models/cell_model.dart';

class CellTileWidget extends StatefulWidget {
  final CellModel cell;
  final bool isSelected;
  final bool isHinted;
  final bool isInvalid;
  final VoidCallback onTap;
  final AppThemeTokens theme;
  final double textScale;
  final bool reducedMotion;

  const CellTileWidget({
    super.key,
    required this.cell,
    required this.isSelected,
    required this.isHinted,
    required this.isInvalid,
    required this.onTap,
    required this.theme,
    this.textScale = 1.0,
    this.reducedMotion = false,
  });

  @override
  State<CellTileWidget> createState() => _CellTileWidgetState();
}

class _CellTileWidgetState extends State<CellTileWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -4.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 4.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: -3.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -3.0, end: 3.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 3.0, end: 0.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(covariant CellTileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isInvalid && !oldWidget.isInvalid && !widget.reducedMotion) {
      _shakeController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;
    final cell = widget.cell;

    if (cell.isCleared) {
      // Empty / Matched cell
      return Container(
        margin: const EdgeInsets.all(2.5),
        decoration: BoxDecoration(
          color: t.cellCleared,
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    Color bgColor = t.cellBackground;
    Color borderColor = t.cellBorder;
    Color textColor = t.cellText;
    double borderWidth = 1.2;

    if (widget.isSelected) {
      bgColor = t.cellSelectedBackground;
      borderColor = t.cellSelectedBorder;
      textColor = t.cellSelectedText;
      borderWidth = 2.5;
    } else if (widget.isHinted) {
      bgColor = t.cellHintBackground;
      borderColor = t.cellHintBorder;
      borderWidth = 2.5;
    } else if (widget.isInvalid) {
      bgColor = t.cellInvalidBackground;
      borderColor = t.cellInvalidBorder;
      borderWidth = 2.0;
    }

    Widget content = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(10),
        splashColor: t.primary.withValues(alpha: 0.2),
        highlightColor: t.primary.withValues(alpha: 0.1),
        child: AnimatedContainer(
          duration: widget.reducedMotion
              ? Duration.zero
              : const Duration(milliseconds: 150),
          curve: Curves.easeOutQuad,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: borderColor,
              width: borderWidth,
            ),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: borderColor.withValues(alpha: 0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ]
                : widget.isHinted
                    ? [
                        BoxShadow(
                          color: borderColor.withValues(alpha: 0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 1),
                        )
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ],
          ),
          alignment: Alignment.center,
          child: Text(
            '${cell.value}',
            style: TextStyle(
              fontSize: (widget.isSelected ? 23 : 21) * widget.textScale,
              fontWeight:
                  widget.isSelected ? FontWeight.w800 : FontWeight.w700,
              color: textColor,
            ),
          ),
        ),
      ),
    );

    if (widget.reducedMotion) {
      return Padding(
        padding: const EdgeInsets.all(2.5),
        child: content,
      );
    }

    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: child,
          ),
        );
      },
      child: content,
    );
  }
}
