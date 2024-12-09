import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

final authProvider = Provider((ref) => AuthProvider());

class AuthProvider {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://your-backend-api.com'));

  Future<bool> login({required String email, required String password}) async {
    final response = await _dio.post('/login', data: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception(response.data['message']);
    }
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await _dio.post('/register', data: {
      'name': name,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception(response.data['message']);
    }
  }
}
