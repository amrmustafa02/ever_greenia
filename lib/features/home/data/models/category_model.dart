import 'package:plants_app/features/home/domain/entities/category_data.dart';

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json["_id"],
      name: json["name"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
  CategoryData toEntity() {
    return CategoryData(
      id: id ?? "",
      originalName: name ?? "No Name",
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
