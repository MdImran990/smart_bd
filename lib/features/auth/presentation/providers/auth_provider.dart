import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Auth State
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final UserModel? user;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(const AuthState()) {
    checkAuthStatus();
  }

  Future<void> checkAuthStatus() async {
    final user = await _repository.getCurrentUser();
    if (user != null) {
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      final user = await _repository.login(
        email: email,
        password: password,
      );
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
      return true;
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      final user = await _repository.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );
      state = AuthState(
        status: AuthStatus.authenticated,
        user: user,
      );
      return true;
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  Future<bool> forgotPassword({required String email}) async {
    state = const AuthState(status: AuthStatus.loading);
    try {
      await _repository.forgotPassword(email: email);
      state = const AuthState(status: AuthStatus.unauthenticated);
      return true;
    } catch (e) {
      state = AuthState(
        status: AuthStatus.error,
        errorMessage: e.toString().replaceAll('Exception: ', ''),
      );
      return false;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider));
});