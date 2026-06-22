import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://backendcleango.gyaanplant.co.in',
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
          final isPublicEndpoint = options.path.contains('/api/auth/customer/send-otp') ||
              options.path.contains('/api/auth/customer/verify-otp');
          
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString("auth_token");
          
          print("DEBUG: Loading token from storage: $token");
          
          if (!isPublicEndpoint && token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            print("DEBUG: Attached Authorization header (Bearer token) to request");
          } else {
            print("DEBUG: No Authorization header attached (isPublic: $isPublicEndpoint)");
          }
          
          print("DEBUG: API REQUEST -> ${options.method} ${options.uri}");
          print("DEBUG: Request Headers: ${options.headers}");
          print("DEBUG: Request Body: ${options.data}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("DEBUG: API RESPONSE -> Success Status: ${response.statusCode}");
          print("DEBUG: Response Body: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          print("DEBUG: API ERROR -> Status: ${e.response?.statusCode}");
          print("DEBUG: Error Response Body: ${e.response?.data}");
          
          if (e.response?.statusCode == 401) {
            print("DEBUG: 401 Unauthorized - Token might be expired.");
          } else if (e.response?.statusCode == 500) {
            print("DEBUG: 500 Internal Server Error.");
          }
          
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> put(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.put(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> patch(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.patch(path, data: data, queryParameters: queryParameters);
  }

  Future<Response> delete(String path, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    return await _dio.delete(path, data: data, queryParameters: queryParameters);
  }
}
