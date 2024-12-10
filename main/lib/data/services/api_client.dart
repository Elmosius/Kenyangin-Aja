import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'http://localhost:5000',
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 5000),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

  Future<Response> post(String path, Map<String, dynamic> data) async {
    try {
      final response = await dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Request failed';
    }
  }
}
