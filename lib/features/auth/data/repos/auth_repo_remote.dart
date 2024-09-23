import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:plants_app/features/auth/data/models/login_response_model/login_response_model.dart';
import 'package:plants_app/features/auth/domain/repos/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoRemote extends AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepoRemote(this._authRemoteDataSource);

  @override
  Future<ApiResult<bool>> confirmEmail(String email, String code) {
    // TODO: implement confirmEmail
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<LoginResponseModel>> login(
      String email, String password) async {
    try {
      var result = await _authRemoteDataSource.login(email, password);
      return SuccessRequest<LoginResponseModel>(
          data: LoginResponseModel.fromJson(result));
    } on FailedRequest catch (e) {
      return FailedRequest(exception: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<ApiResult<bool>> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }
}
