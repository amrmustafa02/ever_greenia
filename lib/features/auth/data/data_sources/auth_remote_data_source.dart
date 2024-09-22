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

  Future<ApiResult<void>> register(String email, String password) {
    return Future.delayed(const Duration(seconds: 2));
  }

  Future<ApiResult<void>> confirmEmail() {
    return Future.delayed(const Duration(seconds: 2));
  }

  Future<ApiResult<void>> sendPasswordResetEmail(String email) {
    return Future.delayed(const Duration(seconds: 2));
  }
}
