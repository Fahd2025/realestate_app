import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:realestate_app/l10n/app_localizations.dart';
import 'core/database/database.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/language/language_cubit.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'router/app_router.dart';

import 'package:flutter_web_plugins/url_strategy.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  final sharedPreferences = await SharedPreferences.getInstance();
  final database = AppDatabase();

  runApp(MyApp(
    database: database,
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  final SharedPreferences sharedPreferences;

  const MyApp({
    super.key,
    required this.database,
    required this.sharedPreferences,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        BlocProvider(
          create: (context) => LanguageCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            database: database,
            sharedPreferences: sharedPreferences,
          )..add(CheckAuthStatus()),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, languageState) {
              return MaterialApp(
                title: 'Real Estate App',
                debugShowCheckedModeBanner: false,

                // Theme
                theme: AppTheme.lightTheme(themeState.colorScheme),
                darkTheme: AppTheme.darkTheme(themeState.colorScheme),
                themeMode:
                    themeState.isDarkMode ? ThemeMode.dark : ThemeMode.light,

                // Localization
                locale: languageState.locale,
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
                onGenerateRoute: AppRouter.generateRoute,
                onGenerateInitialRoutes: (String initialRoute) {
                  // Handle deep linking on web
                  return [
                    AppRouter.generateRoute(RouteSettings(name: initialRoute)),
                  ];
                },
              );
            },
          );
        },
      ),
    );
  }
}
