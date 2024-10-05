import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/api/endpoints.dart';
import 'package:plants_app/core/api/my_dio.dart';
import 'package:plants_app/core/errors/rest_api_error_handler.dart';
import 'package:plants_app/core/models/cart_model.dart';

@lazySingleton
class CartRemoteDataSource {
  final MyDio _myDio;

  CartRemoteDataSource(this._myDio);

  Future<CartModel> getCart() async {
    try {
      final response = await _myDio.get(
        Endpoints.cart,
      );
      return CartModel.fromJson(response.data);
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<void> addProductToCart(String productId, int quantity) async {
    try {
      await _myDio.post(
        Endpoints.cart + productId,
        data: {
          "quantity": quantity,
        },
      );
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<void> deleteProductFromCart(String productId) async {
    try {
      await _myDio.delete(
        Endpoints.cart + productId,
      );
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    try {
      await _myDio.put(
        Endpoints.cart + productId,
        data: {
          "quantity": quantity,
        },
      );
    } on DioException catch (e) {
      throw FailedRequest(
        exception: RestApiErrorHandler.handleError(e),
      );
    }
  }
}
