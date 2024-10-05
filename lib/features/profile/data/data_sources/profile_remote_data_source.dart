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

  Future<ProfileModel> getProfile(String token) async {
    try {
      final response = await dio.get(
        Endpoints.profile,
      );
      return ProfileModel.fromJson(response.data);
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<bool> updateProfile({
    required String token,
    String? name,
    String? oldPassword,
    String? newPassword,
  }) async {
    try {
      await dio.put(
        Endpoints.profile,
        data: {
          if (name != null) "name": name,
          if (oldPassword != null) "oldPassword": oldPassword,
          if (newPassword != null) "password": newPassword,
        },
      );
      return true;
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<bool> deleteProfile(String token) async {
    try {
      await dio.delete(
        Endpoints.profile,
      );
      return true;
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }
}
