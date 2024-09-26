import 'package:plants_app/core/extensions/string_ext.dart';

class ProductData {
  final String id;
  final String orginalName;
  final String slug;
  final String description;
  final num price;
  final String categoryId;
  final String image;
  final String image3D;
  final num quantity;
  final bool is3D;
  String heroId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductData({
    required this.id,
    required this.orginalName,
    required this.slug,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.image,
    required this.image3D,
    required this.quantity,
    required this.is3D,
    this.createdAt,
    this.updatedAt,
    this.heroId = "",
  });
  String get name => orginalName.toTitleCase();
  factory ProductData.fakeDate(String id) {
    return ProductData(
      id: id,
      orginalName: "Product",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      description: "No Description",
      price: 0,
      categoryId: "1",
      image: "https://picsum.photos/200",
      image3D: "https://picsum.photos/200",
      quantity: 0,
      is3D: false,
      slug: "product",
    );
  }
}
