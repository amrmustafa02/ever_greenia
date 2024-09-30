import 'package:plants_app/core/models/product_model.dart';

class CartModel {
  CartModel({
    required this.id,
    required this.userId,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? userId;
  final List<CartProduct> products;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["_id"],
      userId: json["userId"],
      products: json["products"] == null
          ? []
          : List<CartProduct>.from(
              json["products"]!.map((x) => CartProduct.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class CartProduct {
  CartProduct({
    required this.productDetails,
    required this.quantity,
    required this.id,
  });

  final ProductModel? productDetails;
  final num? quantity;
  final String? id;

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productDetails: json["productId"] == null
          ? null
          : ProductModel.fromJson(json["productId"]),
      quantity: json["quantity"],
      id: json["_id"],
    );
  }
}
