import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Language State
class LanguageState extends Equatable {
  final Locale locale;

  const LanguageState({
    required this.locale,
  });

  const LanguageState.initial() : locale = const Locale('ar');

  LanguageState copyWith({
    Locale? locale,
  }) {
    return LanguageState(
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [locale];
}

// Language Cubit
class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState.initial()) {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language') ?? 'ar';

    emit(LanguageState(locale: Locale(languageCode)));
  }

  Future<void> changeLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', languageCode);

    emit(state.copyWith(locale: Locale(languageCode)));
  }
}
