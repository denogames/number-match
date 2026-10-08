import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'application/providers.dart';
import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_themes.dart';
import 'data/local/database/app_database.dart';
import 'data/local/preferences/app_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await AppPreferences.init();
  final database = AppDatabase();

  runApp(
    ProviderScope(
      overrides: [
        preferencesProvider.overrideWithValue(preferences),
        databaseProvider.overrideWithValue(database),
      ],
      child: const NumberMatchApp(),
    ),
  );
}

class NumberMatchApp extends ConsumerWidget {
  const NumberMatchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final themeTokens = settings.currentTheme;

    // Handle system dark mode synchronization if enabled
    var effectiveTheme = themeTokens;
    if (settings.systemThemeSync) {
      final brightness = MediaQuery.platformBrightnessOf(context);
      if (brightness == Brightness.dark && !effectiveTheme.isDark) {
        effectiveTheme = AppThemes.midnight;
      } else if (brightness == Brightness.light && effectiveTheme.isDark) {
        effectiveTheme = AppThemes.classicPaper;
      }
    }

    final themeData = effectiveTheme.toThemeData(
      textScale: settings.textScale,
      highContrastMode: effectiveTheme.id == 'high_contrast',
    );

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: themeData,
      routerConfig: appRouter,
    );
  }
}
