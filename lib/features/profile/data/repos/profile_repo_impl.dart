import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:plants_app/features/profile/domain/entities/profile_data.dart';
import 'package:plants_app/features/profile/domain/repos/profile_repo.dart';

@LazySingleton(as: ProfileRepo)
class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<ProfileData>> getProfile(String token) async {
    try {
      var result = await _remoteDataSource.getProfile(token);

      return ApiResult.success(data: result.toEntity());
    } on FailedRequest catch (e) {
      return ApiResult.failure(error: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> updateProfile({
    required String token,
    String? name,
    String? oldPassword,
    String? newPassword,
  }) async {
    try {
      await _remoteDataSource.updateProfile(
        token: token,
        name: name,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      return ApiResult.success(data: true);
    } on FailedRequest catch (e) {
      return ApiResult.failure(error: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> deleteProfile(String token) async {
    try {
      await _remoteDataSource.deleteProfile(token);
      return ApiResult.success(data: true);
    } on FailedRequest catch (e) {
      return ApiResult.failure(error: e.exception);
    }
  }
}
