import 'package:flutter/material.dart';
import '../../../../core/constants/game_constants.dart';
import '../../../../core/theme/app_theme_tokens.dart';
import '../../../../domain/models/game_state.dart';

class GameControlsWidget extends StatelessWidget {
  final GameState state;
  final AppThemeTokens theme;
  final double textScale;
  final VoidCallback onUndo;
  final VoidCallback onAddNumbers;
  final VoidCallback onHint;

  const GameControlsWidget({
    super.key,
    required this.state,
    required this.theme,
    required this.onUndo,
    required this.onAddNumbers,
    required this.onHint,
    this.textScale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final canUndo = state.canUndo;
    final remainingToAdd = state.board.remainingActiveCount;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.divider.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 1. Undo Button
          _ControlButton(
            icon: Icons.undo_rounded,
            label: 'Undo',
            isEnabled: canUndo,
            theme: theme,
            textScale: textScale,
            onTap: onUndo,
          ),

          // 2. Add Numbers Button (Central Primary Action)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    foregroundColor: theme.onPrimary,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  onPressed: remainingToAdd > 0 ? onAddNumbers : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_circle_outline_rounded, size: 22),
                      const SizedBox(width: 8),
                      Text(
                        'Add Numbers (+$remainingToAdd)',
                        style: TextStyle(
                          fontSize: 14.0 * textScale,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Hint Button
          _ControlButton(
            icon: Icons.lightbulb_rounded,
            label: 'Hint',
            badge: '${GameConstants.hintCostCoins}🪙',
            isEnabled: true,
            theme: theme,
            textScale: textScale,
            onTap: onHint,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final bool isEnabled;
  final AppThemeTokens theme;
  final double textScale;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    this.badge,
    required this.isEnabled,
    required this.theme,
    required this.textScale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final fg = isEnabled ? theme.textPrimary : theme.textSecondary.withValues(alpha: 0.4);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          constraints: const BoxConstraints(minWidth: 64, minHeight: 52),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: fg, size: 24),
              const SizedBox(height: 3),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11.0 * textScale,
                      fontWeight: FontWeight.w600,
                      color: fg,
                    ),
                  ),
                  if (badge != null) ...[
                    const SizedBox(width: 3),
                    Text(
                      badge!,
                      style: TextStyle(
                        fontSize: 10.0 * textScale,
                        fontWeight: FontWeight.w700,
                        color: theme.accent,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
