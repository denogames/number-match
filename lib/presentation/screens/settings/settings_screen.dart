import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/providers.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme_tokens.dart';
import '../../../core/theme/app_themes.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
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
          'Settings',
          style: TextStyle(
            fontSize: 18.0 * settings.textScale,
            fontWeight: FontWeight.w700,
            color: theme.textPrimary,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            // 1. Theme Engine Section
            Text(
              'THEME & APPEARANCE',
              style: TextStyle(
                fontSize: 12.0 * settings.textScale,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: theme.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.divider),
              ),
              child: Column(
                children: [
                  ...AppThemes.allThemes.map((t) {
                    final isSelected = t.id == theme.id;
                    return _ThemeChoiceTile(
                      themeTokens: t,
                      isSelected: isSelected,
                      textScale: settings.textScale,
                      onSelect: () => controller.setTheme(t.id),
                    );
                  }),
                  const Divider(height: 24),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'System Light/Dark Sync',
                      style: TextStyle(
                        fontSize: 15.0 * settings.textScale,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Match operating system dark mode automatically',
                      style: TextStyle(
                        fontSize: 13.0 * settings.textScale,
                        color: theme.textSecondary,
                      ),
                    ),
                    value: settings.systemThemeSync,
                    onChanged: (val) => controller.setSystemThemeSync(val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 2. Accessibility & Controls
            Text(
              'ACCESSIBILITY & CONTROLS',
              style: TextStyle(
                fontSize: 12.0 * settings.textScale,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: theme.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.divider),
              ),
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Haptic Feedback',
                      style: TextStyle(
                        fontSize: 15.0 * settings.textScale,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Tactile vibrations on taps and matches',
                      style: TextStyle(
                        fontSize: 13.0 * settings.textScale,
                        color: theme.textSecondary,
                      ),
                    ),
                    value: settings.hapticsEnabled,
                    onChanged: (val) => controller.setHapticsEnabled(val),
                  ),
                  const Divider(height: 16),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Sound Effects',
                      style: TextStyle(
                        fontSize: 15.0 * settings.textScale,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Audio feedback for matches and combos',
                      style: TextStyle(
                        fontSize: 13.0 * settings.textScale,
                        color: theme.textSecondary,
                      ),
                    ),
                    value: settings.soundEnabled,
                    onChanged: (val) => controller.setSoundEnabled(val),
                  ),
                  const Divider(height: 16),
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'Reduced Motion',
                      style: TextStyle(
                        fontSize: 15.0 * settings.textScale,
                        fontWeight: FontWeight.w600,
                        color: theme.textPrimary,
                      ),
                    ),
                    subtitle: Text(
                      'Minimize screen transitions and tile shaking',
                      style: TextStyle(
                        fontSize: 13.0 * settings.textScale,
                        color: theme.textSecondary,
                      ),
                    ),
                    value: settings.reducedMotion,
                    onChanged: (val) => controller.setReducedMotion(val),
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Text Size Scaling',
                        style: TextStyle(
                          fontSize: 15.0 * settings.textScale,
                          fontWeight: FontWeight.w600,
                          color: theme.textPrimary,
                        ),
                      ),
                      Text(
                        '${(settings.textScale * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 14.0 * settings.textScale,
                          fontWeight: FontWeight.w700,
                          color: theme.primary,
                        ),
                      ),
                    ],
                  ),
                  Slider.adaptive(
                    value: settings.textScale,
                    min: 0.85,
                    max: 1.30,
                    divisions: 9,
                    onChanged: (val) => controller.setTextScale(val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Privacy & Telemetry
            Text(
              'PRIVACY & DIAGNOSTICS',
              style: TextStyle(
                fontSize: 12.0 * settings.textScale,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
                color: theme.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: theme.divider),
              ),
              child: SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Anonymous Game Telemetry',
                  style: TextStyle(
                    fontSize: 15.0 * settings.textScale,
                    fontWeight: FontWeight.w600,
                    color: theme.textPrimary,
                  ),
                ),
                subtitle: Text(
                  'Helps improve game balance. No personal data collected.',
                  style: TextStyle(
                    fontSize: 13.0 * settings.textScale,
                    color: theme.textSecondary,
                  ),
                ),
                value: settings.analyticsEnabled,
                onChanged: (val) => controller.setAnalyticsEnabled(val),
              ),
            ),
            const SizedBox(height: 30),

            // App Version Footer
            Center(
              child: Text(
                'Number Match v${AppConstants.appVersion}',
                style: TextStyle(
                  fontSize: 13.0 * settings.textScale,
                  color: theme.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _ThemeChoiceTile extends StatelessWidget {
  final AppThemeTokens themeTokens;
  final bool isSelected;
  final double textScale;
  final VoidCallback onSelect;

  const _ThemeChoiceTile({
    required this.themeTokens,
    required this.isSelected,
    required this.textScale,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            // Color palette preview circles
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: themeTokens.background,
                shape: BoxShape.circle,
                border: Border.all(color: themeTokens.cellBorder, width: 2),
              ),
              child: Center(
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: themeTokens.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                themeTokens.name,
                style: TextStyle(
                  fontSize: 15.0 * textScale,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: Theme.of(context).colorScheme.primary,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}
