import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plants_app/core/api/api_result.dart';

abstract class PlaceOrderRepo {
  Future<ApiResult<bool>> placeOrder({
    required LatLng curLocation,
    required String address,
    required String phone,
    required String token,
    required String note,
    required String paymentMethod,
  });
}
