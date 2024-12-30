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

      final expiry = DateTime.now().add(const Duration(days: 1));

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('userId', user['id']);
      await prefs.setString('expiry', expiry.toIso8601String());

      _userProfile = user;
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
      await prefs.setString('userId', user['id']);

      _userProfile = user;
      state = true;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  /// Mengambil data profil pengguna
  Future<void> fetchUserProfile(String userId) async {
    try {
      final user = await _authService.getUserProfile(userId);
      _userProfile = user;
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  /// Memperbarui data pengguna
  Future<void> updateUserProfile({
    required String userId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final updatedUser = await _authService.updateUser(
        userId: userId,
        updates: updates,
      );
      _userProfile = updatedUser;
      await fetchUserProfile(userId);
      state = true;
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  /// Menghapus akun pengguna
  Future<void> deleteAccount(String userId) async {
    try {
      await _authService.deleteUser(userId);
      await logout();
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  /// Fungsi logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userId');
    _userProfile = null;
    state = false;
  }
}
