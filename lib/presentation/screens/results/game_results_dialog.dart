import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers.dart';
import '../../../domain/models/game_state.dart';
import '../../common/widgets/app_button.dart';

class GameResultsDialog extends ConsumerWidget {
  final GameState state;
  final VoidCallback onPlayAgain;

  const GameResultsDialog({
    super.key,
    required this.state,
    required this.onPlayAgain,
  });

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final theme = settings.currentTheme;
    final adService = ref.watch(adServiceProvider);
    final isWon = state.isWon;

    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: theme.divider),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon & Title
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isWon
                      ? theme.cellHintBackground
                      : theme.cellInvalidBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isWon ? Icons.emoji_events_rounded : Icons.timer_off_rounded,
                  size: 48,
                  color: isWon
                      ? theme.cellHintBorder
                      : theme.cellInvalidBorder,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isWon ? 'BOARD CLEARED!' : 'ROUND FINISHED',
                style: TextStyle(
                  fontSize: 24.0 * settings.textScale,
                  fontWeight: FontWeight.w900,
                  color: theme.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isWon
                    ? 'Fantastic job! You matched all pairs.'
                    : 'Great effort! Try to beat your record.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0 * settings.textScale,
                  color: theme.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              // Score Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: theme.surfaceSubtle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.divider),
                ),
                child: Column(
                  children: [
                    Text(
                      'TOTAL SCORE',
                      style: TextStyle(
                        fontSize: 12.0 * settings.textScale,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: theme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${state.score}',
                      style: TextStyle(
                        fontSize: 36.0 * settings.textScale,
                        fontWeight: FontWeight.w900,
                        color: theme.accent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Metrics Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatItem(
                    label: 'Pairs',
                    value: '${state.matchesCount}',
                    theme: theme,
                    textScale: settings.textScale,
                  ),
                  _StatItem(
                    label: 'Best Combo',
                    value: 'x${state.maxCombo}',
                    theme: theme,
                    textScale: settings.textScale,
                  ),
                  _StatItem(
                    label: 'Time',
                    value: _formatTime(state.elapsedSeconds),
                    theme: theme,
                    textScale: settings.textScale,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Action Buttons
              AppButton(
                label: 'Play Again',
                icon: Icons.replay_rounded,
                isFullWidth: true,
                onPressed: () async {
                  Navigator.of(context).pop();
                  await adService.showBreakInterstitial(placement: 'play_again');
                  onPlayAgain();
                },
                textScale: settings.textScale,
              ),
              const SizedBox(height: 10),
              AppButton(
                label: 'Return Home',
                icon: Icons.home_rounded,
                isSecondary: true,
                isFullWidth: true,
                onPressed: () async {
                  Navigator.of(context).pop();
                  await adService.showBreakInterstitial(placement: 'results_home');
                  if (context.mounted) {
                    context.go('/home');
                  }
                },
                textScale: settings.textScale,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final dynamic theme;
  final double textScale;

  const _StatItem({
    required this.label,
    required this.value,
    required this.theme,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18.0 * textScale,
            fontWeight: FontWeight.w800,
            color: theme.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0 * textScale,
            color: theme.textSecondary,
          ),
        ),
      ],
    );
  }
}
