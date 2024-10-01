import 'package:plants_app/core/models/product_model.dart';

import '../entities/cart_product_data.dart';

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
  final List<CartProductModel> products;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["_id"],
      userId: json["userId"],
      products: json["products"] == null
          ? []
          : List<CartProductModel>.from(
              json["products"]!.map((x) => CartProductModel.fromJson(x))),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}

class CartProductModel {
  CartProductModel({
    required this.productDetails,
    required this.quantity,
    required this.id,
  });

  final ProductModel? productDetails;
  final num? quantity;
  final String? id;

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      productDetails: json["productId"] == null
          ? null
          : ProductModel.fromJson(json["productId"]),
      quantity: json["quantity"],
      id: json["_id"],
    );
  }

  CartProductData toEntity() {
    return CartProductData(
      id: productDetails?.id ?? "",
      description: productDetails?.description ?? "No Description",
      price: productDetails?.price ?? 0,
      image: productDetails?.image?.secureUrl ?? "",
      quantity: quantity ?? 0,
      name: productDetails?.name ?? "No Name",
    );
  }
}
