import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/place_order/data/data_sources/place_order_remote_data_source.dart';
import 'package:plants_app/features/place_order/domain/repo/place_order_repo.dart';

@LazySingleton(as: PlaceOrderRepo)
class PlaceOrderRepoImpl extends PlaceOrderRepo {
  final PlaceOrderRemoteDataSource _remoteDataSource;

  PlaceOrderRepoImpl(this._remoteDataSource);

  @override
  Future<ApiResult<bool>> placeOrder(
      {required LatLng curLocation,
      required String address,
      required String phone,
      required String token,
      required String note,
      required String paymentMethod}) async {
    try {
      await _remoteDataSource.placeOrder(
        curLocation: curLocation,
        address: address,
        phone: phone,
        token: token,
        note: note,
        paymentMethod: paymentMethod,
      );
      return ApiResult.success(data: true);
    } on FailedRequest catch (e) {
      return ApiResult.failure(error: e.exception);
    }
  }
}
