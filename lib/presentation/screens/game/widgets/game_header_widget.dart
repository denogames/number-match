import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../application/providers.dart';
import '../../../../core/theme/app_theme_tokens.dart';
import '../../../../domain/models/game_mode.dart';
import '../../../../domain/models/game_state.dart';

class GameTimerBadgeWidget extends ConsumerWidget {
  final GameMode mode;
  final AppThemeTokens theme;
  final double textScale;

  const GameTimerBadgeWidget({
    super.key,
    required this.mode,
    required this.theme,
    required this.textScale,
  });

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerData = ref.watch(
      gameControllerProvider.select((s) {
        if (s == null) return (0, 0);
        return (s.elapsedSeconds, s.remainingSeconds);
      }),
    );
    final elapsed = timerData.$1;
    final remaining = timerData.$2;
    final isLowTime = mode == GameMode.timed && remaining < 30;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 16.0 * textScale,
          color: isLowTime ? theme.cellInvalidBorder : theme.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          mode == GameMode.timed ? _formatTime(remaining) : _formatTime(elapsed),
          style: TextStyle(
            fontSize: 14.0 * textScale,
            fontWeight: FontWeight.w700,
            color: isLowTime ? theme.cellInvalidBorder : theme.textSecondary,
          ),
        ),
      ],
    );
  }
}

class GameHeaderWidget extends StatelessWidget {
  final GameState state;
  final AppThemeTokens theme;
  final double textScale;
  final VoidCallback onPause;
  final Widget? timerBadge;

  const GameHeaderWidget({
    super.key,
    required this.state,
    required this.theme,
    required this.onPause,
    this.textScale = 1.0,
    this.timerBadge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.divider.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Mode badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      state.mode == GameMode.timed
                          ? Icons.timer_outlined
                          : state.mode == GameMode.daily
                              ? Icons.event_available
                              : Icons.grid_view_rounded,
                      size: 14.0 * textScale,
                      color: theme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      state.mode.displayName,
                      style: TextStyle(
                        fontSize: 12.0 * textScale,
                        fontWeight: FontWeight.w700,
                        color: theme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              // Leaf Timer Badge (isolated re-renders)
              timerBadge ??
                  _DefaultTimerBadge(
                    mode: state.mode,
                    elapsed: state.elapsedSeconds,
                    remaining: state.remainingSeconds,
                    theme: theme,
                    textScale: textScale,
                  ),

              // Pause button
              IconButton(
                icon: const Icon(Icons.pause_circle_outline_rounded),
                color: theme.textSecondary,
                iconSize: 26,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onPause,
                tooltip: 'Pause',
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // Score
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SCORE',
                    style: TextStyle(
                      fontSize: 11.0 * textScale,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                      color: theme.textSecondary,
                    ),
                  ),
                  Text(
                    '${state.score}',
                    style: TextStyle(
                      fontSize: 26.0 * textScale,
                      fontWeight: FontWeight.w900,
                      color: theme.textPrimary,
                    ),
                  ),
                ],
              ),

              // Combo indicator
              if (state.combo > 1)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: theme.accent.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_fire_department_rounded,
                        color: theme.accent,
                        size: 18.0 * textScale,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'x${state.combo} COMBO',
                        style: TextStyle(
                          fontSize: 13.0 * textScale,
                          fontWeight: FontWeight.w800,
                          color: theme.accent,
                        ),
                      ),
                    ],
                  ),
                ),

              // Remaining numbers indicator
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'REMAINING',
                    style: TextStyle(
                      fontSize: 11.0 * textScale,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                      color: theme.textSecondary,
                    ),
                  ),
                  Text(
                    '${state.board.remainingActiveCount}',
                    style: TextStyle(
                      fontSize: 20.0 * textScale,
                      fontWeight: FontWeight.w700,
                      color: theme.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DefaultTimerBadge extends StatelessWidget {
  final GameMode mode;
  final int elapsed;
  final int remaining;
  final AppThemeTokens theme;
  final double textScale;

  const _DefaultTimerBadge({
    required this.mode,
    required this.elapsed,
    required this.remaining,
    required this.theme,
    required this.textScale,
  });

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final isLowTime = mode == GameMode.timed && remaining < 30;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 16.0 * textScale,
          color: isLowTime ? theme.cellInvalidBorder : theme.textSecondary,
        ),
        const SizedBox(width: 4),
        Text(
          mode == GameMode.timed
              ? _formatTime(remaining)
              : _formatTime(elapsed),
          style: TextStyle(
            fontSize: 14.0 * textScale,
            fontWeight: FontWeight.w700,
            color: isLowTime ? theme.cellInvalidBorder : theme.textSecondary,
          ),
        ),
      ],
    );
  }
}
