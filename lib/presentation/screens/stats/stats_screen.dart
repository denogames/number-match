import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers.dart';
import '../../../domain/models/game_statistics.dart';

class StatsScreen extends ConsumerStatefulWidget {
  const StatsScreen({super.key});

  @override
  ConsumerState<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends ConsumerState<StatsScreen> {
  String _selectedMode = 'classic';
  GameStatistics _currentStats = const GameStatistics();

  @override
  void initState() {
    super.initState();
    _loadStats(_selectedMode);
  }

  Future<void> _loadStats(String mode) async {
    final repo = ref.read(statsRepositoryProvider);
    final s = await repo.getStatistics(mode);
    if (mounted) {
      setState(() {
        _selectedMode = mode;
        _currentStats = s;
      });
    }
  }

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final mins = (totalSeconds % 3600) ~/ 60;
    if (hours > 0) {
      return '${hours}h ${mins}m';
    }
    return '${mins}m';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: theme.textPrimary,
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Player Statistics',
          style: TextStyle(
            fontSize: 18.0 * settings.textScale,
            fontWeight: FontWeight.w700,
            color: theme.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Mode Selector Tabs
              Container(
                decoration: BoxDecoration(
                  color: theme.surfaceSubtle,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: theme.divider),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _buildTab('classic', 'Classic', theme, settings.textScale),
                    _buildTab('daily', 'Daily', theme, settings.textScale),
                    _buildTab('timed', 'Timed', theme, settings.textScale),
                    _buildTab('global', 'Global', theme, settings.textScale),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Summary Highlight Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme.divider),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _HighlightColumn(
                      label: 'High Score',
                      value: '${_currentStats.bestScore}',
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                    Container(height: 40, width: 1, color: theme.divider),
                    _HighlightColumn(
                      label: 'Win Rate',
                      value: '${_currentStats.winRate.toStringAsFixed(1)}%',
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                    Container(height: 40, width: 1, color: theme.divider),
                    _HighlightColumn(
                      label: 'Best Combo',
                      value: 'x${_currentStats.bestCombo}',
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Detail Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.45,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  children: [
                    _MetricCard(
                      title: 'Games Played',
                      value: '${_currentStats.gamesPlayed}',
                      icon: Icons.sports_esports_rounded,
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                    _MetricCard(
                      title: 'Games Won',
                      value: '${_currentStats.gamesWon}',
                      icon: Icons.emoji_events_rounded,
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                    _MetricCard(
                      title: 'Pairs Matched',
                      value: '${_currentStats.totalPairsMatched}',
                      icon: Icons.join_inner_rounded,
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                    _MetricCard(
                      title: 'Numbers Added',
                      value: '${_currentStats.totalNumbersAdded}',
                      icon: Icons.post_add_rounded,
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                    _MetricCard(
                      title: 'Current Streak',
                      value: '${_currentStats.currentStreak}',
                      icon: Icons.local_fire_department_rounded,
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                    _MetricCard(
                      title: 'Play Time',
                      value: _formatTime(_currentStats.totalTimeSeconds),
                      icon: Icons.timelapse_rounded,
                      theme: theme,
                      textScale: settings.textScale,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(
      String key, String label, dynamic theme, double textScale) {
    final isSelected = _selectedMode == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => _loadStats(key),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? theme.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13.0 * textScale,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
              color: isSelected ? theme.onPrimary : theme.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _HighlightColumn extends StatelessWidget {
  final String label;
  final String value;
  final dynamic theme;
  final double textScale;

  const _HighlightColumn({
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
            fontSize: 22.0 * textScale,
            fontWeight: FontWeight.w900,
            color: theme.accent,
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

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final dynamic theme;
  final double textScale;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.theme,
    required this.textScale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: theme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0 * textScale,
                  fontWeight: FontWeight.w600,
                  color: theme.textSecondary,
                ),
              ),
              Icon(icon, color: theme.primary, size: 20),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0 * textScale,
              fontWeight: FontWeight.w800,
              color: theme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
