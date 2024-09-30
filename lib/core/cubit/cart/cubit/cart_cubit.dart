import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/core/repos/cart_repo.dart';

part 'cart_state.dart';

@singleton
class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;
  List<ProductData> products = [];

  CartCubit(this._cartRepo) : super(CartInitial());

  Future<void> getCart() async {
    try {
      final result = await _cartRepo.getCart();
      switch (result) {
        case SuccessRequest<List<ProductData>>():
          products = result.data;
          emit(CartLoaded(result.data));
          break;
        case FailedRequest():
          emit(CartError(result.exception.errorMessage));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<bool> addProductToCart(String productId, int quantity) async {
    try {
      var result = await _cartRepo.addProduct(productId, quantity);
      switch (result) {
        case SuccessRequest<bool>():
          getCart();
          return true;
        case FailedRequest():
          emit(CartError(result.exception.errorMessage));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }

    return false;
  }

  Future<void> deleteProductFromCart(int productId) async {}

  Future<void> updateQuantity(int productId, int quantity) async {}
}
