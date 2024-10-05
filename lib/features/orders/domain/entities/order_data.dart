// order_entity.dart
import 'package:plants_app/core/entities/product_data.dart';

class OrderData {
  final String? id;
  final String? userId;
  final List<OrderProductData> products;
  final num? lat;
  final num? lng;
  final String? address;
  final String? paymentMethod;
  final num? amount;
  final num? totalPrice;
  final String? phone;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  OrderData({
    required this.id,
    required this.userId,
    required this.products,
    required this.lat,
    required this.lng,
    required this.address,
    required this.paymentMethod,
    required this.amount,
    required this.totalPrice,
    required this.phone,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}

class OrderProductData {
  final ProductData? productId;
  final num? quantity;
  final String? id;

  OrderProductData({
    required this.productId,
    required this.quantity,
    required this.id,
  });
}

// get_orders_entity.dart
class GetOrdersData {
  final String? message;
  final List<OrderData> pendingOrders;
  final List<OrderData> processingOrders;
  final List<OrderData> deliveredOrders;
  final List<OrderData> cancelledOrders;

  GetOrdersData({
    required this.message,
    required this.pendingOrders,
    required this.processingOrders,
    required this.deliveredOrders,
    required this.cancelledOrders,
  });
}
