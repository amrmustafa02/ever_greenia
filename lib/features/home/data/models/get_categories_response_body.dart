import 'category_model.dart';

class GetCategoriesResponseBody {
  GetCategoriesResponseBody({
    required this.message,
    required this.data,
  });

  final String? message;
  final List<CategoryModel>? data;

  factory GetCategoriesResponseBody.fromJson(Map<String, dynamic> json) {
    return GetCategoriesResponseBody(
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<CategoryModel>.from(
              json["data"]?.map(
                (x) => CategoryModel.fromJson(x),
              ),
            ),
    );
  }
}
