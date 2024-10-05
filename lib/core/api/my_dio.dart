import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:plants_app/core/api/api_constants.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/entities/user_data.dart';

class MyDio {
  static MyDio? _myDio;

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );
  final Dio _authDio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    ),
  );

  MyDio._privateConstructor() {
    _dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (options.path.contains("cart") || options.path.contains("user")) {
            log("in cart");
            options.headers['auth'] = getIt<UserData>().token;
          } else if (options.path.contains("auth")) {
            options.headers = {};
            _dio.options.baseUrl = ApiConstants.authBaseUrl;
          } else {
            options.headers['get_key'] = 'AARS';
          }
          log("------------------ Api request -----------------------");
          log('send request to url: (${options.baseUrl}) and  path: (${options.path})');
          log('Headers: ${options.headers}');
          log('Query parameters: ${options.queryParameters}');
          log('data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log("------------------ Api response  -----------------------");
          log("response from: ${response.realUri.host}${response.realUri.path}");
          log("status code: ${response.statusCode}");
          log("data: ${response.data.toString()}");

          return handler.next(response); // continue
        },
        onError: (DioException e, handler) {
          log('statusCode: ${e.response?.statusCode}');
          log('path: ${e.requestOptions.path}');
          log('response: ${e.response}');
          log('data: ${e.response?.data}');
          log("error ${e.error}");
          log("message ${e.message}");
          log("type ${e.type}");
          return handler.next(e);
        },
      ),
    ]);
  }

  factory MyDio.getInstance() {
    _myDio ??= MyDio._privateConstructor();
    return _myDio!;
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
    );
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    required Map data,
    Options? options,
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> put(
    String path, {
    required dynamic data,
  }) async {
    return await _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }

  Future<Response> patch({required String path, required Map data}) async {
    return await _dio.patch(path, data: data);
  }

  Future<Response> head(String path) async {
    return await _dio.head(path);
  }

  Future<Response> download(String url, String savePath) async {
    return await _dio.download(url, savePath);
  }

  Future<Response> upload(String url, FormData formData) async {
    return await _dio.post(url, data: formData);
  }

  Future<Response> uploadFile(String url, String filePath) async {
    return await _dio.post(url, data: filePath);
  }

  Future<Response> downloadFile(String url, String savePath) async {
    return await _dio.download(url, savePath);
  }

  Future<Response> putFile(String url, String filePath) async {
    return await _dio.put(url, data: filePath);
  }

  Future<Response> patchFile(String url, String filePath) async {
    return await _dio.patch(url, data: filePath);
  }

  Future<Response> postFile(String url, String filePath) async {
    return await _dio.post(url, data: filePath);
  }

  Future<Response> postFormData(String url, FormData formData) async {
    return await _dio.post(url, data: formData);
  }

  Future<Response> putFormData(String url, FormData formData) async {
    return await _dio.put(url, data: formData);
  }

  Future<Response> patchFormData(String url, FormData formData) async {
    return await _dio.patch(url, data: formData);
  }

  Future<Response> deleteFormData(String url, FormData formData) async {
    return await _dio.delete(url, data: formData);
  }
}
