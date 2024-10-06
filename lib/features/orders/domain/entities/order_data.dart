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

  factory OrderData.fromFakeData() {
    return OrderData(
      id: "id",
      userId: "userId",
      products: [
        OrderProductData.fromFakeData(),
        OrderProductData.fromFakeData(),
      ],
      lat: 0,
      lng: 0,
      address: "address",
      paymentMethod: "paymentMethod",
      amount: 0,
      totalPrice: 0,
      phone: "phone",
      status: "status",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      v: 0,
    );
  }
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

  factory OrderProductData.fromFakeData() {
    return OrderProductData(
      productId: ProductData.fakeDate("test"),
      quantity: 0,
      id: "id",
    );
  }
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
