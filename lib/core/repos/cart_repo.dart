import 'package:plants_app/core/api/api_result.dart';

import '../entities/cart_product_data.dart';

abstract class CartRepo {
  Future<ApiResult<List<CartProductData>>> getCart();

  Future<ApiResult<bool>> addProduct(String productId, int quantity);

  Future<ApiResult<bool>> updateProduct(String productId, int quantity);

  Future<ApiResult<bool>> deleteProduct(String productId);
}
