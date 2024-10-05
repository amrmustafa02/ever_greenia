import 'package:plants_app/features/profile/domain/entities/profile_data.dart';

import '../../../../core/api/api_result.dart';

abstract class ProfileRepo {
  Future<ApiResult<ProfileData>> getProfile(String token);

  Future<ApiResult<bool>> updateProfile({
    required String token,
    String? name,
    String? oldPassword,
    String? newPassword,
  });

  Future<ApiResult<bool>> deleteProfile(String token);
}
