import 'package:plants_app/core/models/product_model.dart';

import '../../domain/entities/order_data.dart';

class GetOrdersModel {
  GetOrdersModel({
    required this.message,
    required this.pendingOrders,
    required this.processingOrders,
    required this.deliveredOrders,
    required this.cancelledOrders,
  });

  final String? message;
  final List<OrderModel> pendingOrders;
  final List<OrderModel> processingOrders;
  final List<OrderModel> deliveredOrders;
  final List<OrderModel> cancelledOrders;

  factory GetOrdersModel.fromJson(Map<String, dynamic> json) {
    return GetOrdersModel(
      message: json["message"],
      pendingOrders: json["PendingOrders"] == null
          ? []
          : List<OrderModel>.from(
              json["PendingOrders"]!.map((x) => OrderModel.fromJson(x))),
      processingOrders: json["ProcessingOrders"] == null
          ? []
          : List<OrderModel>.from(
              json["ProcessingOrders"]!.map((x) => OrderModel.fromJson(x))),
      deliveredOrders: json["DeliveredOrders"] == null
          ? []
          : List<OrderModel>.from(
              json["DeliveredOrders"]!.map((x) => OrderModel.fromJson(x))),
      cancelledOrders: json["CancelledOrders"] == null
          ? []
          : List<OrderModel>.from(
              json["CancelledOrders"]!.map((x) => OrderModel.fromJson(x))),
    );
  }

  GetOrdersData toEntity() {
    return GetOrdersData(
      pendingOrders: pendingOrders.map((e) => e.toEntity()).toList(),
      processingOrders: processingOrders.map((e) => e.toEntity()).toList(),
      deliveredOrders: deliveredOrders.map((e) => e.toEntity()).toList(),
      cancelledOrders: cancelledOrders.map((e) => e.toEntity()).toList(),
      message: message,
    );
  }
}

class OrderModel {
  OrderModel({
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

  final String? id;
  final String? userId;
  final List<OrderProductModel> products;
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

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["_id"],
      userId: json["userId"],
      products: json["products"] == null
          ? []
          : List<OrderProductModel>.from(
              json["products"]!.map((x) => OrderProductModel.fromJson(x))),
      lat: json["lat"],
      lng: json["lng"],
      address: json["address"],
      paymentMethod: json["paymentMethod"],
      amount: json["amount"],
      totalPrice: json["totalPrice"],
      phone: json["phone"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  OrderData toEntity() {
    return OrderData(
      id: id ?? "",
      userId: userId ?? "",
      products: products.map((e) => e.toEntity()).toList(),
      lat: lat ?? 0,
      lng: lng ?? 0,
      address: address ?? "",
      paymentMethod: paymentMethod ?? "",
      amount: amount ?? 0,
      totalPrice: totalPrice ?? 0,
      phone: phone ?? "",
      status: status ?? "",
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      v: v ?? 0,
    );
  }
}

class OrderProductModel {
  OrderProductModel({
    required this.productId,
    required this.quantity,
    required this.id,
  });

  final ProductModel? productId;
  final num? quantity;
  final String? id;

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      productId: json["productId"] == null
          ? null
          : ProductModel.fromJson(json["productId"]),
      quantity: json["quantity"],
      id: json["_id"],
    );
  }

  OrderProductData toEntity() {
    return OrderProductData(
      id: id ?? "",
      productId: productId?.toEntity(),
      quantity: quantity ?? 0,
    );
  }
}
