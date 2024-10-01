import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/repos/cart_repo.dart';

import '../../../entities/cart_product_data.dart';

part 'cart_state.dart';

@singleton
class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;
  List<CartProductData> products = [];
  bool isLoadig = false;

  CartCubit(this._cartRepo) : super(CartInitial());

  Future<void> getCart() async {
    isLoadig = true;

    try {
      final result = await _cartRepo.getCart();
      switch (result) {
        case SuccessRequest<List<CartProductData>>():
          products = result.data;
          isLoadig = false;
          emit(CartLoaded());
          break;
        case FailedRequest():
          isLoadig = false;
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

  Future<void> deleteProductFromCart(String productId) async {
    isLoadig = true;
    emit(CartLoading());
    try {
      var result = await _cartRepo.deleteProduct(productId.toString());
      switch (result) {
        case SuccessRequest<bool>():
          getCart();
          break;
        case FailedRequest():
          emit(CartError(result.exception.errorMessage));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    isLoadig = true;
    emit(CartLoading());
    try {
      var result =
          await _cartRepo.updateProduct(productId.toString(), quantity);
      switch (result) {
        case SuccessRequest<bool>():
          getCart();
          break;
        case FailedRequest():
          emit(CartError(result.exception.errorMessage));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
