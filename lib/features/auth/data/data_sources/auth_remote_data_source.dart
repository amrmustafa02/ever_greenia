import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/api/endpoints.dart';
import 'package:plants_app/core/api/my_dio.dart';
import 'package:plants_app/core/errors/rest_api_error_handler.dart';

@lazySingleton
class AuthRemoteDataSource {
  final MyDio _dio;
  AuthRemoteDataSource(this._dio);

  Future<Map> login(String email, String password) async {
    try {
      var response = await _dio.post(
        Endpoints.login,
        data: {"email": email, "password": password},
      );
      return response.data;
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<dynamic> register(String name, String email, String password) async {
    try {
      var response = await _dio.post(
        Endpoints.register,
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<dynamic> confirmEmail(String email, String code) async {
    try {
      var response = await _dio.put(
        Endpoints.confirmEmail,
        data: {
          "email": email,
          "code": code,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<ApiResult<void>> sendPasswordResetEmail(String email) {
    return Future.delayed(const Duration(seconds: 2));
  }
}
