import 'package:plants_app/core/models/product_model.dart';

class SearchRequestBody {
  SearchRequestBody({
    required this.currentPage,
    required this.nextPage,
    required this.totalPages,
    required this.productsCount,
    required this.products,
  });

  final num? currentPage;
  final num? nextPage;
  final num? totalPages;
  final num? productsCount;
  final List<ProductModel> products;

  factory SearchRequestBody.fromJson(Map<String, dynamic> json) {
    return SearchRequestBody(
      currentPage: json["Current_Page"],
      nextPage: json["Next_Page"],
      totalPages: json["Total_Pages"],
      productsCount: json["Products_Count"],
      products: json["products"] == null
          ? []
          : List<ProductModel>.from(
              json["products"]!.map((x) => ProductModel.fromJson(x))),
    );
  }
}
