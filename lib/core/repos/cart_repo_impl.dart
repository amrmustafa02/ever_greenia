import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/data_sources/cart_remote_data_source.dart';
import 'package:plants_app/core/entities/cart_data.dart';
import 'package:plants_app/core/repos/cart_repo.dart';

@LazySingleton(as: CartRepo)
class CartRepoImpl extends CartRepo {
  final CartRemoteDataSource _cartRemoteDataSource;

  CartRepoImpl(this._cartRemoteDataSource);

  @override
  Future<ApiResult<bool>> addProduct(String productId, int quantity) async {
    try {
      await _cartRemoteDataSource.addProductToCart(productId, quantity);
      return const SuccessRequest<bool>(data: true);
    } on FailureRequest catch (e) {
      return FailureRequest(exception: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> deleteProduct(String productId) async {
    try {
      await _cartRemoteDataSource.deleteProductFromCart(productId);
      return const SuccessRequest<bool>(data: true);
    } on FailureRequest catch (e) {
      return FailureRequest(exception: e.exception);
    }
  }

  @override
  Future<ApiResult<CartData>> getCart() async {
    try {
      var response = await _cartRemoteDataSource.getCart();

      return ApiResult.success(data: response.toEntity());
    } on FailureRequest catch (e) {
      return FailureRequest(exception: e.exception);
    }
  }

  @override
  Future<ApiResult<bool>> updateProduct(String productId, int quantity) async {
    try {
      await _cartRemoteDataSource.updateQuantity(productId, quantity);
      return const SuccessRequest<bool>(data: true);
    } on FailureRequest catch (e) {
      return FailureRequest(exception: e.exception);
    }
  }
}
