import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/auth/data/models/login_response_model/login_response_model.dart';

abstract class AuthRepo {
  Future<ApiResult<LoginResponseModel>> login(String email, String password);

  Future<ApiResult<bool>> register(String email, String password);

  Future<ApiResult<bool>> confirmEmail(String email, String code);

  Future<ApiResult<bool>> sendPasswordResetEmail(String email);
}
