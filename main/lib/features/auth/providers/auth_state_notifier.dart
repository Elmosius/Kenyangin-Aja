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

  AuthStateNotifier(this._authService) : super(false) {
    _checkLoginStatus();
  }

  /// Mengecek apakah pengguna sudah login berdasarkan token di SharedPreferences
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    state = token != null; // Ubah state berdasarkan keberadaan token
  }

  /// Fungsi login
  Future<void> login({required String email, required String password}) async {
    try {
      final token = await _authService.login(email: email, password: password);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token); // Simpan token setelah login
      state = true; // Ubah state login menjadi true
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
      final token = await _authService.register(
        name: name,
        email: email,
        password: password,
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token); // Simpan token setelah register
      state = true; // Ubah state login menjadi true
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  /// Fungsi logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    state = false;
  }
}
