import 'package:flutter_application_1/core/data/users_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider();
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider() : super(AuthState());

  //implementar dartz para Either
  Future<void> login(String username, String password) async {
    try {
      final tokens = await loginUser(username, password);
      state = AuthState(isAuthenticated: true, tokens: tokens);
    } catch (error) {
      throw Exception(error);
    }
  }
}

class AuthState {
  final bool isAuthenticated;
  final Map<String, String>? tokens;

  AuthState({this.isAuthenticated = false, this.tokens});
}
