import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.cleango.com/v1',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Token Injection
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString("auth_token");
          
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          
          print("DEBUG: API ${options.method} ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // You can globally handle success responses or log them
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          // Global Error Handling
          if (e.response?.statusCode == 401) {
            print("DEBUG: 401 Unauthorized - Token might be expired.");
            // Handle refresh token logic or emit a logout event here
          } else if (e.response?.statusCode == 500) {
            print("DEBUG: 500 Internal Server Error.");
            // Handle server crashes logic globally
          }
          
          return handler.next(e);
        },
      ),
    );
  }

  // --- Wrapper Methods for future usage ---
  
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.delete(path, data: data, queryParameters: queryParameters);
  }
}
