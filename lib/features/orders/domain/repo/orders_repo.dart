import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/orders/domain/entities/order_data.dart';

abstract class OrdersRepo {
  Future<ApiResult<GetOrdersData>> getOrders();

  Future<ApiResult<bool
  >> cancelOrder(String orderId);
}
