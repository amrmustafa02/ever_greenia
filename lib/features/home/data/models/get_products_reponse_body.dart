import 'package:plants_app/core/models/product_model.dart';

class GetProductsResponseBody {
  GetProductsResponseBody({
    required this.message,
    required this.data,
  });

  final String? message;
  final List<ProductModel> data;

  factory GetProductsResponseBody.fromJson(Map<String, dynamic> json) {
    return GetProductsResponseBody(
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<ProductModel>.from(
              json["data"]!.map((x) => ProductModel.fromJson(x))),
    );
  }
}
