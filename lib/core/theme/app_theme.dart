import 'package:flutter/material.dart';

class AppTheme {
  // Color schemes
  static const Map<String, ColorScheme> colorSchemes = {
    'blue': ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1976D2),
      onPrimary: Colors.white,
      secondary: Color(0xFF42A5F5),
      onSecondary: Colors.white,
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      surface: Color(0xFFF5F5F5),
      onSurface: Color(0xFF212121),
    ),
    'green': ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF388E3C),
      onPrimary: Colors.white,
      secondary: Color(0xFF66BB6A),
      onSecondary: Colors.white,
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      surface: Color(0xFFF5F5F5),
      onSurface: Color(0xFF212121),
    ),
    'purple': ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF7B1FA2),
      onPrimary: Colors.white,
      secondary: Color(0xFFAB47BC),
      onSecondary: Colors.white,
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      surface: Color(0xFFF5F5F5),
      onSurface: Color(0xFF212121),
    ),
  };

  static const Map<String, ColorScheme> darkColorSchemes = {
    'blue': ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF42A5F5),
      onPrimary: Color(0xFF212121),
      secondary: Color(0xFF1976D2),
      onSecondary: Colors.white,
      error: Color(0xFFEF5350),
      onError: Color(0xFF212121),
      surface: Color(0xFF1E1E1E),
      onSurface: Color(0xFFE0E0E0),
    ),
    'green': ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF66BB6A),
      onPrimary: Color(0xFF212121),
      secondary: Color(0xFF388E3C),
      onSecondary: Colors.white,
      error: Color(0xFFEF5350),
      onError: Color(0xFF212121),
      surface: Color(0xFF1E1E1E),
      onSurface: Color(0xFFE0E0E0),
    ),
    'purple': ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFAB47BC),
      onPrimary: Color(0xFF212121),
      secondary: Color(0xFF7B1FA2),
      onSecondary: Colors.white,
      error: Color(0xFFEF5350),
      onError: Color(0xFF212121),
      surface: Color(0xFF1E1E1E),
      onSurface: Color(0xFFE0E0E0),
    ),
  };

  static ThemeData lightTheme(String colorScheme) {
    final scheme = colorSchemes[colorScheme] ?? colorSchemes['blue']!;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'DINNextLTArabic',
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: scheme.surface,
      ),
    );
  }

  static ThemeData darkTheme(String colorScheme) {
    final scheme = darkColorSchemes[colorScheme] ?? darkColorSchemes['blue']!;

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      fontFamily: 'DINNextLTArabic',
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 2,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: scheme.surface,
      ),
    );
  }
}
