import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/api/my_dio.dart';
import 'package:plants_app/core/errors/rest_api_error_handler.dart';
import 'package:plants_app/features/profile/data/models/profile_model.dart';

import '../../../../core/api/endpoints.dart';

@lazySingleton
class ProfileRemoteDataSource {
  final MyDio dio;

  ProfileRemoteDataSource(this.dio);

  Future<ApiResult<ProfileModel>> getProfile(String token) async {
    try {
      final response = await dio.get(
        Endpoints.profile,
      );
      return ApiResult.success(
        data: ProfileModel.fromJson(response.data),
      );
    } on DioException catch (e) {
      return ApiResult.failure(error: RestApiErrorHandler.handleError(e));
    }
  }
}
