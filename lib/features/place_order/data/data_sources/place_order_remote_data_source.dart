import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/api/endpoints.dart';
import 'package:plants_app/core/errors/rest_api_error_handler.dart';

import '../../../../core/api/my_dio.dart';

@lazySingleton
class PlaceOrderRemoteDataSource {
  final MyDio _dio;

  PlaceOrderRemoteDataSource(this._dio);

  Future<bool> placeOrder({
    required LatLng curLocation,
    required String address,
    required String phone,
    required String token,
    required String note,
    required String paymentMethod,
  }) async {
    try {
      await _dio.post(
        Endpoints.order,
        data: {
          "lat": curLocation.latitude,
          "lng": curLocation.longitude,
          "address": address,
          "phone": phone,
          if (note.isNotEmpty) "note": note,
          "paymentMethod": paymentMethod,
        },
      );

      return true;
    } on DioException catch (e) {
      throw FailureRequest(exception: RestApiErrorHandler.handleError(e));
    }
  }
}
