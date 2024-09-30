import 'package:plants_app/core/extensions/string_ext.dart';
import 'package:plants_app/core/entities/product_data.dart';

class CategoryData {
  final String id;
  final String originalName;
  final DateTime createdAt;
  final DateTime updatedAt;
  List<ProductData> products;

  CategoryData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.originalName,
    this.products = const [],
  });

  String get name => originalName.toTitleCase();
  factory CategoryData.fakeDate() {
    return CategoryData(
      id: "1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      originalName: "Category",
    );
  }
}
