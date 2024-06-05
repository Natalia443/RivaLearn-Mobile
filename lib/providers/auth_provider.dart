import 'package:flutter_application_1/core/data/users_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthState());

  Future<void> login(String username, String password) async {
    try {
      state = AuthState(isLoading: true);
      final tokens = await loginUser(username, password);
      state = AuthState(
        isAuthenticated: true,
        tokens: tokens,
        isLoading: false,
      );
    } catch (error) {
      throw Exception(error);
    }
  }

  void logout() {
    state = AuthState();
  }
}

class AuthState {
  final bool isAuthenticated;
  final Map<String, String>? tokens;
  final bool isLoading;

  AuthState({
    this.isAuthenticated = false,
    this.tokens,
    this.isLoading = false,
  });
}
