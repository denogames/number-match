import 'package:flutter/material.dart';
import 'app_theme_tokens.dart';

class AppThemes {
  // 1. Classic Paper
  static const classicPaper = AppThemeTokens(
    id: 'classic_paper',
    name: 'Classic Paper',
    isDark: false,
    background: Color(0xFFF7F5F0),
    surface: Color(0xFFFFFFFF),
    surfaceSubtle: Color(0xFFEFECE4),
    cellBackground: Color(0xFFFFFFFF),
    cellBorder: Color(0xFFDED8CE),
    cellText: Color(0xFF232D3F),
    cellCleared: Color(0x14000000),
    cellSelectedBackground: Color(0xFFFEF3C7),
    cellSelectedBorder: Color(0xFFD97706),
    cellSelectedText: Color(0xFF92400E),
    cellHintBackground: Color(0xFFD1FAE5),
    cellHintBorder: Color(0xFF059669),
    cellInvalidBackground: Color(0xFFFEE2E2),
    cellInvalidBorder: Color(0xFFDC2626),
    primary: Color(0xFF2563EB),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF475569),
    onSecondary: Color(0xFFFFFFFF),
    accent: Color(0xFFD97706),
    textPrimary: Color(0xFF1E293B),
    textSecondary: Color(0xFF64748B),
    divider: Color(0xFFE2DCD2),
    appBarBackground: Color(0xFFF7F5F0),
  );

  // 2. Midnight
  static const midnight = AppThemeTokens(
    id: 'midnight',
    name: 'Midnight',
    isDark: true,
    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    surfaceSubtle: Color(0xFF162032),
    cellBackground: Color(0xFF1E293B),
    cellBorder: Color(0xFF334155),
    cellText: Color(0xFFF8FAFC),
    cellCleared: Color(0x14FFFFFF),
    cellSelectedBackground: Color(0xFF3B2F17),
    cellSelectedBorder: Color(0xFFFBBF24),
    cellSelectedText: Color(0xFFFDE68A),
    cellHintBackground: Color(0xFF064E3B),
    cellHintBorder: Color(0xFF34D399),
    cellInvalidBackground: Color(0xFF450A0A),
    cellInvalidBorder: Color(0xFFF87171),
    primary: Color(0xFF38BDF8),
    onPrimary: Color(0xFF0F172A),
    secondary: Color(0xFF94A3B8),
    onSecondary: Color(0xFF0F172A),
    accent: Color(0xFFF59E0B),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    divider: Color(0xFF334155),
    appBarBackground: Color(0xFF0F172A),
  );

  // 3. Ocean
  static const ocean = AppThemeTokens(
    id: 'ocean',
    name: 'Ocean',
    isDark: true,
    background: Color(0xFF071E26),
    surface: Color(0xFF0F313D),
    surfaceSubtle: Color(0xFF0A2630),
    cellBackground: Color(0xFF123D4D),
    cellBorder: Color(0xFF1E566B),
    cellText: Color(0xFFE0F2FE),
    cellCleared: Color(0x1400FFFF),
    cellSelectedBackground: Color(0xFF1F464D),
    cellSelectedBorder: Color(0xFF2DD4BF),
    cellSelectedText: Color(0xFF99F6E4),
    cellHintBackground: Color(0xFF0E4F42),
    cellHintBorder: Color(0xFF2DD4BF),
    cellInvalidBackground: Color(0xFF4C1D24),
    cellInvalidBorder: Color(0xFFF43F5E),
    primary: Color(0xFF14B8A6),
    onPrimary: Color(0xFF042F2E),
    secondary: Color(0xFF38BDF8),
    onSecondary: Color(0xFF082F49),
    accent: Color(0xFFF59E0B),
    textPrimary: Color(0xFFF0FDFA),
    textSecondary: Color(0xFF99F6E4),
    divider: Color(0xFF164E63),
    appBarBackground: Color(0xFF071E26),
  );

  // 4. High Contrast
  static const highContrast = AppThemeTokens(
    id: 'high_contrast',
    name: 'High Contrast',
    isDark: true,
    background: Color(0xFF000000),
    surface: Color(0xFF111111),
    surfaceSubtle: Color(0xFF1C1C1C),
    cellBackground: Color(0xFF000000),
    cellBorder: Color(0xFFFFFFFF),
    cellText: Color(0xFFFFFFFF),
    cellCleared: Color(0x22FFFFFF),
    cellSelectedBackground: Color(0xFFFFFF00),
    cellSelectedBorder: Color(0xFFFFFFFF),
    cellSelectedText: Color(0xFF000000),
    cellHintBackground: Color(0xFF00FF66),
    cellHintBorder: Color(0xFFFFFFFF),
    cellInvalidBackground: Color(0xFFFF0055),
    cellInvalidBorder: Color(0xFFFFFFFF),
    primary: Color(0xFFFFFF00),
    onPrimary: Color(0xFF000000),
    secondary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    accent: Color(0xFFFFFF00),
    textPrimary: Color(0xFFFFFFFF),
    textSecondary: Color(0xFFDDDDDD),
    divider: Color(0xFFFFFFFF),
    appBarBackground: Color(0xFF000000),
  );

  static const List<AppThemeTokens> allThemes = [
    classicPaper,
    midnight,
    ocean,
    highContrast,
  ];

  static AppThemeTokens fromId(String id) {
    return allThemes.firstWhere(
      (t) => t.id == id,
      orElse: () => classicPaper,
    );
  }
}
