import 'package:plants_app/core/entities/product_data.dart';

import 'image_model.dart';

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.image,
    required this.image3D,
    required this.quantity,
    required this.is3D,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? name;
  final String? slug;
  final String? description;
  final num? price;
  final String? categoryId;
  final Image? image;
  final Image? image3D;
  final num? quantity;
  final bool? is3D;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? v;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["_id"],
      name: json["name"],
      slug: json["slug"],
      description: json["description"],
      price: json["price"],
      categoryId: json["categoryId"],
      image: json["image"] == null ? null : Image.fromJson(json["image"]),
      image3D: json["image3D"] == null ? null : Image.fromJson(json["image3D"]),
      quantity: json["quantity"],
      is3D: json["is3D"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
  ProductData toEntity() {
    return ProductData(
      id: id ?? "",
      originalName: name ?? "No Name",
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
      description: description ?? "No Description",
      price: price ?? 0,
      categoryId: categoryId ?? "",
      image: image?.secureUrl ?? "",
      image3D: image3D?.secureUrl ?? "",
      quantity: quantity ?? 0,
      is3D: is3D ?? false,
      slug: slug ?? "",
    );
  }
}
