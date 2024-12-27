import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/providers/api_client_provider.dart';
import 'package:main/data/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, bool>((ref) {
  final authService = ref.read(authServiceProvider);
  return AuthStateNotifier(authService);
});

final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return AuthService(apiClient);
});

class AuthStateNotifier extends StateNotifier<bool> {
  final AuthService _authService;
  Map<String, dynamic>? _userProfile;
  Map<String, dynamic>? get userProfile => _userProfile;

  AuthStateNotifier(this._authService) : super(false) {
    _checkLoginStatus();
  }

  /// Mengecek status login
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    
    state = token != null;
  }

  /// Fungsi login
  Future<void> login({required String email, required String password}) async {
    try {
      final result = await _authService.login(email: email, password: password);
      final token = result['token'];
      final user = result['user'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      _userProfile = user;

      log(_userProfile.toString());
      state = true;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  /// Fungsi register
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final result = await _authService.register(
        name: name,
        email: email,
        password: password,
      );
      final token = result['token'];
      final user = result['user'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      _userProfile = user;
      state = true;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  /// Fungsi logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    _userProfile = null;
    state = false;
  }
}
