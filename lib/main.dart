import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studio_core_sdk/studio_core_sdk.dart';
import 'application/providers.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/game_constants.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_themes.dart';
import 'data/local/database/app_database.dart';
import 'data/local/preferences/app_preferences.dart';
import 'data/local/vault/game_state_vault.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Resolve persistent application support directory
  final appSupportDir = await getApplicationSupportDirectory();

  // 2. Initialize Studio Core SDK in offline-first mode (zero network packets)
  await StudioSdk.initialize(
    gameId: 'number_match',
    storageDirectoryPath: appSupportDir.path,
    config: StudioConfig(
      gameId: 'number_match',
      gameVersion: AppConstants.appVersion,
      archetype: StudioGameArchetype.puzzleDriven,
      enableCloudSync: false,
      enableDebugOverlay: false,
      storageDirectoryPath: appSupportDir.path,
      initialCurrencies: const {
        StudioCurrencyIds.gold: GameConstants.startingCoins,
      },
      regeneratingResources: const [],
    ),
  );

  // 3. Initialize crash-safe persistent game vault
  await GameStateVault.instance.initialize(
    storageDirectoryPath: appSupportDir.path,
  );

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
