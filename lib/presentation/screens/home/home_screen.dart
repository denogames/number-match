import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers.dart';
import '../../../domain/models/game_mode.dart';
import '../../common/widgets/coin_chip.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _hasActiveClassic = false;
  int _classicHighScore = 0;
  bool _dailyCompletedToday = false;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    final gameRepo = ref.read(gameRepositoryProvider);
    final statsRepo = ref.read(statsRepositoryProvider);

    final activeClassic = await gameRepo.loadActiveGame(GameMode.classic);
    final stats = await statsRepo.getStatistics('classic');

    final now = DateTime.now();
    final todayKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final dailyMeta = await gameRepo.getDailyChallenge(todayKey);

    if (mounted) {
      setState(() {
        _hasActiveClassic = activeClassic != null && !activeClassic.isCompleted;
        _classicHighScore = stats.bestScore;
        _dailyCompletedToday = dailyMeta?.isCompleted ?? false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final theme = settings.currentTheme;

    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(
        backgroundColor: theme.background,
        elevation: 0,
        title: Text(
          'NUMBER MATCH',
          style: TextStyle(
            fontSize: 20.0 * settings.textScale,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // High Score Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.primary,
                      theme.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.military_tech_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CLASSIC HIGH SCORE',
                            style: TextStyle(
                              fontSize: 12.0 * settings.textScale,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                          Text(
                            '$_classicHighScore',
                            style: TextStyle(
                              fontSize: 28.0 * settings.textScale,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'SELECT GAME MODE',
                style: TextStyle(
                  fontSize: 13.0 * settings.textScale,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  color: theme.textSecondary,
                ),
              ),
              const SizedBox(height: 12),

              // 1. Classic Mode Card
              _ModeCard(
                title: 'Classic Mode',
                subtitle: _hasActiveClassic
                    ? 'Game in progress • Tap to resume'
                    : 'Relaxed number matching with unlimited adds',
                icon: Icons.grid_view_rounded,
                badge: _hasActiveClassic ? 'RESUME' : null,
                theme: theme,
                textScale: settings.textScale,
                onTap: () {
                  context.push('/game/classic');
                },
              ),
              const SizedBox(height: 14),

              // 2. Daily Challenge Card
              _ModeCard(
                title: 'Daily Challenge',
                subtitle: _dailyCompletedToday
                    ? 'Completed for today! Great job'
                    : 'Deterministic puzzle • +150 Coins Reward',
                icon: Icons.event_available_rounded,
                badge: _dailyCompletedToday ? 'DONE ✓' : 'DAILY',
                badgeColor: _dailyCompletedToday
                    ? theme.cellHintBorder
                    : theme.accent,
                theme: theme,
                textScale: settings.textScale,
                onTap: () {
                  context.push('/daily');
                },
              ),
              const SizedBox(height: 14),

              // 3. Timed Rush Card
              _ModeCard(
                title: 'Timed Rush',
                subtitle: 'Race the clock! 2 minutes blitz with time bonuses',
                icon: Icons.timer_outlined,
                badge: '2 MIN',
                badgeColor: theme.cellInvalidBorder,
                theme: theme,
                textScale: settings.textScale,
                onTap: () {
                  context.push('/game/timed');
                },
              ),
              const SizedBox(height: 28),

              // Bottom Shortcuts Grid (Tutorial, Stats, Shop, Settings)
              Row(
                children: [
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.help_outline_rounded,
                      label: 'How to Play',
                      theme: theme,
                      textScale: settings.textScale,
                      onTap: () => context.push('/tutorial'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.bar_chart_rounded,
                      label: 'Statistics',
                      theme: theme,
                      textScale: settings.textScale,
                      onTap: () => context.push('/stats'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.storefront_rounded,
                      label: 'Shop',
                      theme: theme,
                      textScale: settings.textScale,
                      onTap: () => context.push('/shop'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _QuickActionCard(
                      icon: Icons.settings_rounded,
                      label: 'Settings',
                      theme: theme,
                      textScale: settings.textScale,
                      onTap: () => context.push('/settings'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? badge;
  final Color? badgeColor;
  final dynamic theme;
  final double textScale;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.badge,
    this.badgeColor,
    required this.theme,
    required this.textScale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.divider),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: theme.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 17.0 * textScale,
                            fontWeight: FontWeight.w800,
                            color: theme.textPrimary,
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: (badgeColor ?? theme.primary)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              badge!,
                              style: TextStyle(
                                fontSize: 10.0 * textScale,
                                fontWeight: FontWeight.w800,
                                color: badgeColor ?? theme.primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13.0 * textScale,
                        color: theme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: theme.textSecondary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final dynamic theme;
  final double textScale;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.theme,
    required this.textScale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.divider),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: theme.primary, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.0 * textScale,
                  fontWeight: FontWeight.w700,
                  color: theme.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
