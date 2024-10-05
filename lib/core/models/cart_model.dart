import 'package:plants_app/core/entities/cart_data.dart';
import 'package:plants_app/core/models/product_model.dart';

import '../entities/cart_product_data.dart';

class CartModel {
  CartModel({
    required this.products,
    required this.totalPrice,
    required this.totalQuantity,
  });

  final List<CartProductModel> products;
  final num? totalPrice;
  final num? totalQuantity;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      products: json["cart"]["products"] == null
          ? []
          : List<CartProductModel>.from(
              json["cart"]["products"]!.map((x) => CartProductModel.fromJson(x))),
      totalPrice: json["totalPrice"],
      totalQuantity: json["totalProducts"],
    );
  }

  CartData toEntity() {
    return CartData(
      products: products.map((e) => e.toEntity()).toList(),
      totalPrice: totalPrice ?? 0,
      quantity: totalQuantity ?? 0,
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
