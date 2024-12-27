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
}
