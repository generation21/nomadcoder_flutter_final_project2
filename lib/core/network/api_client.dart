import 'package:dio/dio.dart';
import 'package:nomadcoder_flutter_final_project2/core/config/env_config.dart';
import 'package:nomadcoder_flutter_final_project2/repositories/auth_repository.dart';

class ApiClient {
  late final Dio _dio;
  // final AuthRepository _authRepository;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.instance.apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // 인터셉터 추가 (토큰 주입, 로깅 등)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // if (_authRepository.currentUser != null) {
          //   options.headers['current-user-id'] =
          //       _authRepository.currentUser!.uid;
          // }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  // GET 요청
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio.get(path, queryParameters: queryParameters, options: options);
  }

  // POST 요청
  Future<Response> post(String path, {dynamic data, Options? options}) {
    return _dio.post(path, data: data, options: options);
  }

  // PUT 요청
  Future<Response> put(String path, {dynamic data, Options? options}) {
    return _dio.put(path, data: data, options: options);
  }

  // DELETE 요청
  Future<Response> delete(String path, {Options? options}) {
    return _dio.delete(path, options: options);
  }
}
