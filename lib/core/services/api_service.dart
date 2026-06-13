import 'package:dio/dio.dart';

class ApiService {
  late final Dio _dio;
  ApiService({required String baseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }
      ),
    );
  }

  // GET
  Future<dynamic> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } catch(e) {
      throw Exception('Failed to GET data: $e');
    }
  }

  // POST
  Future<dynamic> post(String path, {required Map<String, dynamic> data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } catch(e) {
      throw Exception('Failed to POST data: $e');
    }
  }

  // PUT
  Future<void> put(String path, {required Map<String, dynamic> data}) async {
    try {
      await _dio.put(path, data: data);
    } catch(e) {
      throw Exception('Failed to PUT data: $e');
    }
  }

  // DELETE
  Future<void> delete(String path) async {
    try {
      await _dio.put(path);
    } catch(e) {
      throw Exception('Failed to PUT data: $e');
    }
  }
}
