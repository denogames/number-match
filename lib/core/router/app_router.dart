import 'package:go_router/go_router.dart';
import '../../domain/models/game_mode.dart';
import '../../presentation/screens/daily/daily_challenge_screen.dart';
import '../../presentation/screens/game/game_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/shop/shop_screen.dart';
import '../../presentation/screens/splash/splash_screen.dart';
import '../../presentation/screens/stats/stats_screen.dart';
import '../../presentation/screens/tutorial/tutorial_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/game/:mode',
      builder: (context, state) {
        final modeKey = state.pathParameters['mode'] ?? 'classic';
        final mode = GameModeExtension.fromStorageKey(modeKey);
        return GameScreen(mode: mode);
      },
    ),
    GoRoute(
      path: '/daily',
      builder: (context, state) => const DailyChallengeScreen(),
    ),
    GoRoute(
      path: '/stats',
      builder: (context, state) => const StatsScreen(),
    ),
    GoRoute(
      path: '/shop',
      builder: (context, state) => const ShopScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/tutorial',
      builder: (context, state) => const TutorialScreen(),
    ),
  ],
);
