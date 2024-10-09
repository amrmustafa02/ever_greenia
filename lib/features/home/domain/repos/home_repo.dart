import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/home/domain/entities/category_data.dart';
import 'package:plants_app/core/entities/product_data.dart';

abstract class HomeRepo {
  Future<ApiResult<List<CategoryData>>> getCategories();

  Future<ApiResult<List<ProductData>>> getProducts();

  Future<ApiResult<List<ProductData>>> search(String query);
}
