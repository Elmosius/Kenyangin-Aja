import 'package:main/data/services/api_client.dart';

class AuthService {
  final ApiClient _apiClient;

  AuthService(this._apiClient);

  Future<Map<String, dynamic>> login(
      {required String email, required String password}) async {
    try {
      final response = await _apiClient.post('/auth/login', {
        'email': email,
        'password': password,
      });
      return {
        'token': response.data['token'],
        'user': response.data['user'],
      };
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiClient.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
      });
      return {
        'token': response.data['token'],
        'user': response.data['user'],
      };
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  /// Fungsi Mendapatkan Profil Pengguna
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await _apiClient.get('/users/$userId');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch user profile: $e');
    }
  }

  /// Fungsi Memperbarui Profil Pengguna
  Future<Map<String, dynamic>> updateUser({
    required String userId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      final response = await _apiClient.put('/users/$userId', updates);
      return response.data;
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  /// Fungsi Menghapus Akun Pengguna
  Future<void> deleteUser(String userId) async {
    try {
      await _apiClient.delete('/users/$userId');
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }

  Future<Map<String, dynamic>> verifyToken(String token) async {
    try {
      final response = await _apiClient.post('/auth/verify-token', {
        'token': token,
      });
      return response.data['user'];
    } catch (e) {
      throw Exception('Token verification failed: $e');
    }
  }
}
