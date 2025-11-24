import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/profile/screens/profile_screen.dart';
import '../core/constants/routes.dart';
import '../core/models/enums.dart';
import '../features/admin/screens/user_management_screen.dart';
import '../features/admin/screens/property_management_screen.dart';
import 'dashboard_router.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case AppRoutes.dashboard:
        return MaterialPageRoute(
          builder: (context) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthAuthenticated) {
                  final user = state.user;
                  UserRole role;
                  switch (user.role) {
                    case 'admin':
                      role = UserRole.admin;
                      break;
                    case 'owner':
                      role = UserRole.owner;
                      break;
                    case 'tenant':
                      role = UserRole.tenant;
                      break;
                    case 'buyer':
                      role = UserRole.buyer;
                      break;
                    default:
                      return const Scaffold(
                        body: Center(child: Text('Unknown user role')),
                      );
                  }
                  return DashboardRouter(userRole: role);
                } else if (state is AuthUnauthenticated) {
                  return const LoginScreen();
                }
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              },
            );
          },
          settings: settings,
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const SettingsScreen();
              } else if (state is AuthUnauthenticated) {
                return const LoginScreen();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          settings: settings,
        );

      case AppRoutes.profile:
        return MaterialPageRoute(
          builder: (_) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return const ProfileScreen();
              } else if (state is AuthUnauthenticated) {
                return const LoginScreen();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          settings: settings,
        );

      // Admin Routes
      case AppRoutes.adminUsers:
        return MaterialPageRoute(
          builder: (context) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                final database = context.read<AuthBloc>().database;
                return UserManagementScreen(database: database);
              } else if (state is AuthUnauthenticated) {
                return const LoginScreen();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          settings: settings,
        );

      case AppRoutes.adminProperties:
        return MaterialPageRoute(
          builder: (context) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                final database = context.read<AuthBloc>().database;
                return PropertyManagementScreen(database: database);
              } else if (state is AuthUnauthenticated) {
                return const LoginScreen();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          settings: settings,
        );

      // Owner Routes
      case AppRoutes.ownerProperties:
        return MaterialPageRoute(
          builder: (context) => BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                final database = context.read<AuthBloc>().database;
                return PropertyManagementScreen(
                  database: database,
                  ownerId: state.user.id,
                );
              } else if (state is AuthUnauthenticated) {
                return const LoginScreen();
              }
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            },
          ),
          settings: settings,
        );

      case AppRoutes.adminContracts:
      case AppRoutes.ownerContracts:
      // Tenant Routes
      case AppRoutes.tenantContracts:
      case AppRoutes.tenantPayments:
      // Buyer Routes
      case AppRoutes.buyerBrowse:
      case AppRoutes.buyerRequests:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: Text(settings.name ?? 'Page')),
            body: Center(
              child: Text('Coming Soon: ${settings.name}'),
            ),
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
