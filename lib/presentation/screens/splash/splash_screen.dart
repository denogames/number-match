import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../application/analytics/analytics_event.dart';
import '../../../application/providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    );
    _animController.forward();
    _bootstrapApp();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Future<void> _bootstrapApp() async {
    final reward = ref.read(rewardServiceProvider);
    final iap = ref.read(iapServiceProvider);
    final ads = ref.read(adServiceProvider);
    final analytics = ref.read(analyticsServiceProvider);
    final prefs = ref.read(preferencesProvider);

    await Future.wait([
      reward.initialize(),
      iap.initialize(),
      ads.initialize(),
    ]);

    // Check first open
    if (!prefs.isTutorialCompleted()) {
      await analytics.logEvent(AnalyticsEventType.firstOpen);
    }

    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    if (!prefs.isTutorialCompleted()) {
      context.go('/tutorial');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final theme = settings.currentTheme;

    return Scaffold(
      backgroundColor: theme.background,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [theme.primary, theme.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: theme.primary.withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '10',
                    style: TextStyle(
                      fontSize: 42.0 * settings.textScale,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'NUMBER MATCH',
                style: TextStyle(
                  fontSize: 22.0 * settings.textScale,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  color: theme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Classic Logic Puzzle',
                style: TextStyle(
                  fontSize: 14.0 * settings.textScale,
                  color: theme.textSecondary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
