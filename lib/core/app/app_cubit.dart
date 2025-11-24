import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Unified App State
/// Combines theme and language preferences into a single state
class AppState extends Equatable {
  final bool isDarkMode;
  final String colorScheme;
  final Locale locale;

  const AppState({
    required this.isDarkMode,
    required this.colorScheme,
    required this.locale,
  });

  /// Initial state with default values
  const AppState.initial()
      : isDarkMode = false,
        colorScheme = 'blue',
        locale = const Locale('ar');

  /// Create a copy of the state with optional new values
  AppState copyWith({
    bool? isDarkMode,
    String? colorScheme,
    Locale? locale,
  }) {
    return AppState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      colorScheme: colorScheme ?? this.colorScheme,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, colorScheme, locale];
}

/// Unified App Cubit
/// Manages both theme and language preferences
class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState.initial()) {
    _loadPreferences();
  }

  /// Load saved preferences from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final isDark = prefs.getBool('isDarkMode') ?? false;
    final scheme = prefs.getString('colorScheme') ?? 'blue';
    final languageCode = prefs.getString('language') ?? 'ar';

    emit(AppState(
      isDarkMode: isDark,
      colorScheme: scheme,
      locale: Locale(languageCode),
    ));
  }

  /// Toggle between light and dark theme
  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state.isDarkMode;
    await prefs.setBool('isDarkMode', newValue);

    emit(state.copyWith(isDarkMode: newValue));
  }

  /// Set the color scheme
  Future<void> setColorScheme(String scheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('colorScheme', scheme);

    emit(state.copyWith(colorScheme: scheme));
  }

  /// Change the app language
  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);

    emit(state.copyWith(locale: Locale(languageCode)));
  }

  /// Get current theme mode
  ThemeMode get themeMode =>
      state.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// Get current locale
  Locale get locale => state.locale;

  /// Get current color scheme
  String get colorScheme => state.colorScheme;

  /// Check if dark mode is enabled
  bool get isDarkMode => state.isDarkMode;
}
