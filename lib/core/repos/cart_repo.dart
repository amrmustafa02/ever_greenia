import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/entities/cart_data.dart';


abstract class CartRepo {
  Future<ApiResult<CartData>> getCart();

  Future<ApiResult<bool>> addProduct(String productId, int quantity);

  Future<ApiResult<bool>> updateProduct(String productId, int quantity);

  Future<ApiResult<bool>> deleteProduct(String productId);
}
