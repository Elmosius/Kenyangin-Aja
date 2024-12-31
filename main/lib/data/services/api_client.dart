import 'dart:developer';

import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(
          BaseOptions(
            // baseUrl: 'http://172.16.173.84:5000',
            baseUrl: 'http://192.168.0.4:5000',
            connectTimeout: const Duration(milliseconds: 5000),
            receiveTimeout: const Duration(milliseconds: 5000),
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

  Future<Response> post(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Request failed';
    }
  }

  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(path, queryParameters: params);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Request failed';
    }
  }

  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Request failed';
    }
  }

  Future<Response> put(String path, Map<String, dynamic> data) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Request failed';
    }
  }
}
