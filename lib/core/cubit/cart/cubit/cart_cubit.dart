import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/constants/app_constants.dart';
import 'package:plants_app/core/entities/cart_data.dart';
import 'package:plants_app/core/repos/cart_repo.dart';

import '../../../entities/cart_product_data.dart';

part 'cart_state.dart';

@singleton
class CartCubit extends Cubit<CartState> {
  final CartRepo _cartRepo;
  List<CartProductData> products = [];
  num totalPrice = 0;
  num productQuantity = 0;
  bool isLoading = false;

  CartCubit(this._cartRepo) : super(CartInitial());

  Future<void> getCart() async {
    isLoading = true;

    try {
      final result = await _cartRepo.getCart();
      switch (result) {
        case SuccessRequest<CartData>():
          products = result.data.products;
          totalPrice = result.data.totalPrice;
          productQuantity = result.data.quantity;
          isLoading = false;
          AppConstants.deliveryFee = result.data.deliveryFees;
          emit(CartLoaded());
          break;
        case FailureRequest():
          isLoading = false;
          emit(CartError(result.exception.errorMessage));
      }
    } catch (e) {
      isLoading = false;
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
        case FailureRequest():
          emit(CartError(result.exception.errorMessage));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }

    return false;
  }

  Future<void> deleteProductFromCart(String productId) async {
    isLoading = true;
    emit(CartLoading());
    try {
      var result = await _cartRepo.deleteProduct(productId.toString());
      switch (result) {
        case SuccessRequest<bool>():
          getCart();
          break;
        case FailureRequest():
          emit(CartError(result.exception.errorMessage));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    isLoading = true;
    emit(CartLoading());
    try {
      var result =
          await _cartRepo.updateProduct(productId.toString(), quantity);
      switch (result) {
        case SuccessRequest<bool>():
          getCart();
          break;
        case FailureRequest():
          isLoading = false;
          emit(CartError(result.exception.errorMessage));
      }
    } catch (e) {
      isLoading = false;
      emit(CartError(e.toString()));
    }
  }
}
