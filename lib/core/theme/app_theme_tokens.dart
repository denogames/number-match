import 'package:flutter/material.dart';

class AppThemeTokens {
  final String id;
  final String name;
  final bool isDark;

  // Canvas & Surfaces
  final Color background;
  final Color surface;
  final Color surfaceSubtle;

  // Cell / Tile Tokens
  final Color cellBackground;
  final Color cellBorder;
  final Color cellText;
  final Color cellCleared;
  final Color cellSelectedBackground;
  final Color cellSelectedBorder;
  final Color cellSelectedText;
  final Color cellHintBackground;
  final Color cellHintBorder;
  final Color cellInvalidBackground;
  final Color cellInvalidBorder;

  // Action / Accent Tokens
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color accent;
  final Color textPrimary;
  final Color textSecondary;
  final Color divider;
  final Color appBarBackground;

  const AppThemeTokens({
    required this.id,
    required this.name,
    required this.isDark,
    required this.background,
    required this.surface,
    required this.surfaceSubtle,
    required this.cellBackground,
    required this.cellBorder,
    required this.cellText,
    required this.cellCleared,
    required this.cellSelectedBackground,
    required this.cellSelectedBorder,
    required this.cellSelectedText,
    required this.cellHintBackground,
    required this.cellHintBorder,
    required this.cellInvalidBackground,
    required this.cellInvalidBorder,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.accent,
    required this.textPrimary,
    required this.textSecondary,
    required this.divider,
    required this.appBarBackground,
  });

  ThemeData toThemeData({
    double textScale = 1.0,
    bool highContrastMode = false,
  }) {
    final colorScheme = ColorScheme(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      error: cellInvalidBorder,
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBackground,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20.0 * textScale,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: divider),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size(48, 48),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontSize: 16.0 * textScale,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28.0 * textScale,
          fontWeight: FontWeight.w800,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 22.0 * textScale,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18.0 * textScale,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0 * textScale,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0 * textScale,
          color: textSecondary,
        ),
      ),
    );
  }
}
