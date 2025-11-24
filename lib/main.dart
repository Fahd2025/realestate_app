import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import 'core/database/database.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize database
    final database = AppDatabase();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(database: database),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Real Estate App',
            debugShowCheckedModeBanner: false,
            
            // Theme
            theme: AppTheme.lightTheme(themeState.colorScheme),
            darkTheme: AppTheme.darkTheme(themeState.colorScheme),
            themeMode: themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            
            // Localization
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            
            // Routing
            initialRoute: '/',
            onGenerateRoute: AppRouter.generateRoute,
          );
        },
      ),
    );
  }
}
