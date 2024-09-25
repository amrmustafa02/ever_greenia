import 'package:plants_app/features/home/domain/entities/product_data.dart';

class CategoryData {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  List<ProductData> products;
  CategoryData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.products = const [],
  });

  factory CategoryData.fakeDate() {
    return CategoryData(
      id: "1",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      name: "Category",
    );
  }
}
