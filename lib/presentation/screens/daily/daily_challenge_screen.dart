import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../application/providers.dart';
import '../../../core/constants/game_constants.dart';
import '../../../domain/models/daily_challenge_meta.dart';
import '../../common/widgets/app_button.dart';
import '../../common/widgets/coin_chip.dart';

class DailyChallengeScreen extends ConsumerStatefulWidget {
  const DailyChallengeScreen({super.key});

  @override
  ConsumerState<DailyChallengeScreen> createState() =>
      _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends ConsumerState<DailyChallengeScreen> {
  DailyChallengeMeta? _todayMeta;
  List<DailyChallengeMeta> _history = [];

  @override
  void initState() {
    super.initState();
    _loadDailyData();
  }

  Future<void> _loadDailyData() async {
    final gameRepo = ref.read(gameRepositoryProvider);
    final now = DateTime.now();
    final todayKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';

    final today = await gameRepo.getDailyChallenge(todayKey);
    final all = await gameRepo.getAllDailyChallenges();

    if (mounted) {
      setState(() {
        _todayMeta = today;
        _history = all;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final theme = settings.currentTheme;
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, MMMM d, yyyy').format(now);
    final isDone = _todayMeta?.isCompleted ?? false;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: theme.textPrimary,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Daily Challenge',
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: theme.divider),
                ),
                child: Column(
                  children: [
                    Icon(
                      isDone
                          ? Icons.check_circle_rounded
                          : Icons.calendar_today_rounded,
                      size: 56,
                      color: isDone ? theme.cellHintBorder : theme.primary,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      dateStr,
                      style: TextStyle(
                        fontSize: 18.0 * settings.textScale,
                        fontWeight: FontWeight.w800,
                        color: theme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isDone
                          ? 'Today\'s puzzle completed! Score: ${_todayMeta?.score}'
                          : 'A new deterministic puzzle awaits you every calendar day.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0 * settings.textScale,
                        color: theme.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: theme.accent.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: theme.accent.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            color: theme.accent,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '+${GameConstants.dailyChallengeRewardCoins} Reward Coins',
                            style: TextStyle(
                              fontSize: 13.0 * settings.textScale,
                              fontWeight: FontWeight.w700,
                              color: theme.accent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Text(
                'RECENT CHALLENGES',
                style: TextStyle(
                  fontSize: 12.0 * settings.textScale,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                  color: theme.textSecondary,
                ),
              ),
              const SizedBox(height: 10),

              // Calendar / History List
              Expanded(
                child: _history.isEmpty
                    ? Center(
                        child: Text(
                          'No previous challenge history yet.\nStart your first today!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.0 * settings.textScale,
                            color: theme.textSecondary,
                          ),
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _history.length,
                        separatorBuilder: (_, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final item = _history[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: theme.surface,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: theme.divider),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  item.isCompleted
                                      ? Icons.check_circle_rounded
                                      : Icons.radio_button_unchecked_rounded,
                                  color: item.isCompleted
                                      ? theme.cellHintBorder
                                      : theme.textSecondary,
                                  size: 22,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.dateKey,
                                    style: TextStyle(
                                      fontSize: 15.0 * settings.textScale,
                                      fontWeight: FontWeight.w700,
                                      color: theme.textPrimary,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Score: ${item.score}',
                                  style: TextStyle(
                                    fontSize: 14.0 * settings.textScale,
                                    fontWeight: FontWeight.w600,
                                    color: theme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 16),

              // Start button
              AppButton(
                label: isDone ? 'Replay Challenge' : 'Start Daily Challenge',
                icon: Icons.play_arrow_rounded,
                isFullWidth: true,
                onPressed: () {
                  context.push('/game/daily');
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
