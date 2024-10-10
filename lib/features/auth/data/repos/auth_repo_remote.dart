import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:plants_app/features/auth/data/models/login_response_model.dart';
import 'package:plants_app/features/auth/domain/repos/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoRemote extends AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoRemote(this._authRemoteDataSource);

  @override
  Future<ApiResult<bool>> confirmEmail(String email, String code) async {
    try {
      await _authRemoteDataSource.confirmEmail(email, code);
      return const SuccessRequest<bool>(data: true);
    } on FailureRequest catch (e) {
      return FailureRequest(exception: e.exception);
    }
  }

  @override
  Future<ApiResult<LoginResponseModel>> login(
      String email, String password) async {
    try {
      var result = await _authRemoteDataSource.login(email, password);
      return SuccessRequest<LoginResponseModel>(
          data: LoginResponseModel.fromJson(result));
    } on FailureRequest catch (e) {
      return FailureRequest(exception: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> register(
      String name, String email, String password) async {
    try {
      await _authRemoteDataSource.register(name, email, password);
      return const SuccessRequest<bool>(data: true);
    } on FailureRequest catch (e) {
      return FailureRequest(exception: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> sendPasswordResetEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<bool>> resendCode(String email) async {
    try {
      await _authRemoteDataSource.resendCode(email);
      return ApiResult.success(data: true);
    } on FailureRequest catch (e) {
      return ApiResult.failure(error: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> resetPassword(
      String email, String code, String password) async {
    try {
      await _authRemoteDataSource.resetPassword(email, code, password);
      return ApiResult.success(data: true);
    } on FailureRequest catch (e) {
      return ApiResult.failure(error: e.exception);
    }
  }
}
