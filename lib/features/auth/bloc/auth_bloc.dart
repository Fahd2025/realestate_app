import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/database/database.dart';
import '../../../core/models/enums.dart';

// Auth Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;

  const LoginRequested({
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [username, password];
}

class LogoutRequested extends AuthEvent {}

class CheckAuthStatus extends AuthEvent {}

// Auth States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  final String? message;

  const AuthUnauthenticated({this.message});

  @override
  List<Object?> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Auth Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AppDatabase database;
  final SharedPreferences sharedPreferences;
  User? _currentUser;

  User? get currentUser => _currentUser;

  AuthBloc({
    required this.database,
    required this.sharedPreferences,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Hash the password
      final passwordHash =
          sha256.convert(utf8.encode(event.password)).toString();

      // Query the database for the user
      final user = await (database.select(database.users)
            ..where((tbl) => tbl.username.equals(event.username))
            ..where((tbl) => tbl.passwordHash.equals(passwordHash))
            ..where((tbl) => tbl.isActive.equals(true)))
          .getSingleOrNull();

      if (user != null) {
        _currentUser = user;
        await sharedPreferences.setString('userId', user.id);
        emit(AuthAuthenticated(user));
      } else {
        emit(const AuthUnauthenticated(
          message: 'Invalid username or password',
        ));
      }
    } catch (e) {
      emit(AuthError('Login failed: ${e.toString()}'));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    _currentUser = null;
    await sharedPreferences.remove('userId');
    emit(const AuthUnauthenticated());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final userId = sharedPreferences.getString('userId');
      if (userId != null) {
        final user = await (database.select(database.users)
              ..where((tbl) => tbl.id.equals(userId))
              ..where((tbl) => tbl.isActive.equals(true)))
            .getSingleOrNull();

        if (user != null) {
          _currentUser = user;
          emit(AuthAuthenticated(user));
        } else {
          await sharedPreferences.remove('userId');
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  UserRole getUserRole() {
    if (_currentUser == null) {
      // Return a default role or handle gracefully if needed,
      // but for now we expect the UI to guard against this.
      // Throwing here causes the crash if UI builds before auth check completes.
      // Let's return a safe default or re-throw if we want to enforce protection.
      // Given the crash, let's throw but ensure we catch it in UI or wait for auth.
      throw Exception('No authenticated user');
    }

    switch (_currentUser!.role) {
      case 'admin':
        return UserRole.admin;
      case 'owner':
        return UserRole.owner;
      case 'tenant':
        return UserRole.tenant;
      case 'buyer':
        return UserRole.buyer;
      default:
        throw Exception('Unknown user role: ${_currentUser!.role}');
    }
  }
}
