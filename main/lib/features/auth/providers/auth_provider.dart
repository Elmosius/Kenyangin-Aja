import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:main/data/services/api_client.dart';

final authProvider = Provider((ref) => AuthProvider());

class AuthProvider {
  final ApiClient _apiClient = ApiClient();

  Future<bool> login({required String email, required String password}) async {
    log('Login attempt: $email, $password');
    try {
      final response = await _apiClient.post('/auth/login', {
        'email': email,
        'password': password,
      });
      // Simpan token atau lakukan sesuatu
      log('Login successful: ${response.data}');
      return true;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<bool> register({
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
      log('Register successful: ${response.data}');
      return true;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }
}
