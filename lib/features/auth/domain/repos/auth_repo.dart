import 'package:plants_app/core/api/api_result.dart';

abstract class AuthRepo {
  Future<ApiResult<String>> login(String email, String password);

  Future<ApiResult<bool>> register(String email, String password);

  Future<ApiResult<bool>> confirmEmail(String email, String code);

  Future<ApiResult<bool>> sendPasswordResetEmail(String email);
}
