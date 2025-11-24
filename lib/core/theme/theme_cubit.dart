import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Theme State
class ThemeState extends Equatable {
  final bool isDarkMode;
  final String colorScheme;

  const ThemeState({
    required this.isDarkMode,
    required this.colorScheme,
  });

  const ThemeState.initial()
      : isDarkMode = false,
        colorScheme = 'blue';

  ThemeState copyWith({
    bool? isDarkMode,
    String? colorScheme,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      colorScheme: colorScheme ?? this.colorScheme,
    );
  }

  @override
  List<Object?> get props => [isDarkMode, colorScheme];
}

// Theme Cubit
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState.initial()) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    final scheme = prefs.getString('colorScheme') ?? 'blue';
    
    emit(ThemeState(isDarkMode: isDark, colorScheme: scheme));
  }

  Future<void> toggleTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = !state.isDarkMode;
    await prefs.setBool('isDarkMode', newValue);
    
    emit(state.copyWith(isDarkMode: newValue));
  }

  Future<void> setColorScheme(String scheme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('colorScheme', scheme);
    
    emit(state.copyWith(colorScheme: scheme));
  }
}
