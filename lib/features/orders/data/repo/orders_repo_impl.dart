import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/orders/data/data_source/orders_remote_data_source.dart';
import 'package:plants_app/features/orders/domain/entities/order_data.dart';
import 'package:plants_app/features/orders/domain/repo/orders_repo.dart';

@LazySingleton(as: OrdersRepo)
class OrderRepoImpl extends OrdersRepo {
  final OrdersRemoteDataSource _dataSource;

  OrderRepoImpl(this._dataSource);

  @override
  Future<ApiResult<GetOrdersData>> getOrders() async {
    try {
      var response = await _dataSource.getOrders();
      return ApiResult.success(data: response.toEntity());
    } on FailureRequest catch (e) {
      return ApiResult.failure(error: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> cancelOrder(String orderId) async {
    try {
       await _dataSource.cancelOrder(orderId);
      return ApiResult.success(data: true);
    } on FailureRequest catch (e) {
      return ApiResult.failure(error: e.exception);
    }
  }
}
