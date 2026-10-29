import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studio_core_sdk/studio_core_sdk.dart';
import '../../../application/providers.dart';
import '../../../core/constants/game_constants.dart';
import '../../../domain/models/game_mode.dart';
import '../../../domain/models/game_state.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/coin_chip.dart';
import '../results/game_results_dialog.dart';
import 'widgets/game_board_widget.dart';
import 'widgets/game_controls_widget.dart';
import 'widgets/game_header_widget.dart';

class GameScreen extends ConsumerStatefulWidget {
  final GameMode mode;

  const GameScreen({
    super.key,
    required this.mode,
  });

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _resultsDialogShown = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameControllerProvider.notifier).loadOrCreateGame(widget.mode);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutQuad,
        );
      }
    });
  }

  void _showPauseDialog() {
    final settings = ref.read(settingsControllerProvider);
    final theme = settings.currentTheme;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => Dialog(
        backgroundColor: theme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'GAME PAUSED',
                style: TextStyle(
                  fontSize: 22.0 * settings.textScale,
                  fontWeight: FontWeight.w800,
                  color: theme.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              AppButton(
                label: 'Resume',
                icon: Icons.play_arrow_rounded,
                isFullWidth: true,
                onPressed: () => Navigator.of(ctx).pop(),
                textScale: settings.textScale,
              ),
              const SizedBox(height: 10),
              AppButton(
                label: 'Restart Game',
                icon: Icons.replay_rounded,
                isSecondary: true,
                isFullWidth: true,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  ref.read(gameControllerProvider.notifier).restartGame();
                },
                textScale: settings.textScale,
              ),
              const SizedBox(height: 10),
              AppButton(
                label: 'How to Play',
                icon: Icons.help_outline_rounded,
                isSecondary: true,
                isFullWidth: true,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.push('/tutorial');
                },
                textScale: settings.textScale,
              ),
              const SizedBox(height: 10),
              AppButton(
                label: 'Quit to Home',
                icon: Icons.home_rounded,
                isSecondary: true,
                isFullWidth: true,
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.go('/home');
                },
                textScale: settings.textScale,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNoCoinsDialog() {
    final settings = ref.read(settingsControllerProvider);
    final theme = settings.currentTheme;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Need More Coins?',
          style: TextStyle(
            fontSize: 20.0 * settings.textScale,
            fontWeight: FontWeight.w800,
            color: theme.textPrimary,
          ),
        ),
        content: Text(
          'Hints cost ${GameConstants.hintCostCoins} coins. Complete daily challenges and games to earn more coins!',
          style: TextStyle(
            fontSize: 14.0 * settings.textScale,
            color: theme.textSecondary,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primary,
              foregroundColor: theme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to game completion to trigger results dialog without rebuilding full tree
    ref.listen<GameState?>(gameControllerProvider, (prev, next) {
      if (next != null && next.isCompleted && !_resultsDialogShown) {
        _resultsDialogShown = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => GameResultsDialog(
              state: next,
              onPlayAgain: () {
                _resultsDialogShown = false;
                ref.read(gameControllerProvider.notifier).restartGame();
              },
            ),
          ).then((_) {
            _resultsDialogShown = false;
          });
        });
      }
    });

    final hasGame = ref.watch(gameControllerProvider.select((s) => s != null));
    final settings = ref.watch(settingsControllerProvider);
    final theme = settings.currentTheme;

    if (!hasGame) {
      return Scaffold(
        backgroundColor: theme.background,
        body: Center(
          child: CircularProgressIndicator(color: theme.primary),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: theme.textPrimary,
          onPressed: () => context.go('/home'),
        ),
        title: Text(
          widget.mode.displayName,
          style: TextStyle(
            fontSize: 18.0 * settings.textScale,
            fontWeight: FontWeight.w700,
            color: theme.textPrimary,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(child: CoinChip()),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Column(
            children: [
              // Header with score, timer, combo, remaining (isolated from 1-second ticks)
              Consumer(
                builder: (context, ref, _) {
                  ref.watch(
                    gameControllerProvider.select(
                      (s) => s == null
                          ? 0
                          : Object.hash(
                              s.mode,
                              s.score,
                              s.combo,
                              s.board.remainingActiveCount,
                            ),
                    ),
                  );
                  final state = ref.read(gameControllerProvider);
                  if (state == null) return const SizedBox.shrink();
                  return GameHeaderWidget(
                    state: state,
                    theme: theme,
                    textScale: settings.textScale,
                    onPause: _showPauseDialog,
                    timerBadge: GameTimerBadgeWidget(
                      mode: state.mode,
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              // Game board grid (isolated from 1-second ticks)
              Expanded(
                child: Consumer(
                  builder: (context, ref, _) {
                    ref.watch(
                      gameControllerProvider.select(
                        (s) => s == null
                            ? 0
                            : Object.hash(
                                s.board.rowCount,
                                s.board.cells.length,
                                s.board.remainingActiveCount,
                                s.selectedIndex,
                                s.hintPair,
                                s.invalidPairTargetIndex,
                              ),
                      ),
                    );
                    final state = ref.read(gameControllerProvider);
                    if (state == null) return const SizedBox.shrink();
                    return GameBoardWidget(
                      board: state.board,
                      selectedIndex: state.selectedIndex,
                      hintPair: state.hintPair,
                      invalidIndex: state.invalidPairTargetIndex,
                      onCellTap: (index) {
                        ref
                            .read(gameControllerProvider.notifier)
                            .tapCell(index);
                      },
                      theme: theme,
                      textScale: settings.textScale,
                      reducedMotion: settings.reducedMotion,
                      scrollController: _scrollController,
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Controls: Undo, Add Numbers, Hint (isolated from 1-second ticks)
              Consumer(
                builder: (context, ref, _) {
                  ref.watch(
                    gameControllerProvider.select(
                      (s) => s == null
                          ? 0
                          : Object.hash(
                              s.canUndo,
                              s.board.remainingActiveCount,
                            ),
                    ),
                  );
                  final state = ref.read(gameControllerProvider);
                  if (state == null) return const SizedBox.shrink();
                  return GameControlsWidget(
                    state: state,
                    theme: theme,
                    textScale: settings.textScale,
                    onUndo: () {
                      ref.read(gameControllerProvider.notifier).undo();
                    },
                    onAddNumbers: () async {
                      await ref
                          .read(gameControllerProvider.notifier)
                          .addNumbers();
                      _scrollToBottom();
                    },
                    onHint: () async {
                      final success = await ref
                          .read(gameControllerProvider.notifier)
                          .requestHint();
                      if (!success && mounted) {
                        if (StudioSdk.isInitialized &&
                            StudioSdk.instance.pinchPoint.activeOffer !=
                                null) {
                          return;
                        }
                        _showNoCoinsDialog();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
