import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/core/repos/cart_repo.dart';

import '../../../../core/api/api_result.dart';

part 'product_details_state.dart';

@injectable
class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this._cartRepo) : super(ProductDetailsInitial());

  late ProductData product;
  late String categoryName;

  final CartRepo _cartRepo;
  final switcherKey = const ValueKey<String>("switcher");

  int quantity = 1;
  bool curClickIsRight = true;

  void initProduct(
    ProductData product,
    String categoryName,
  ) {
    this.product = product;
    this.categoryName = categoryName;
  }

  Future<void> addProductToCart(CartCubit cartCubit) async {
    emit(AddProductToCartLoading());

    var result = await _cartRepo.addProduct(product.id, quantity);
    switch (result) {
      case SuccessRequest<bool>():
        cartCubit.getCart();
        emit(AddProductToCartSuccess());
        break;
      case FailureRequest():
        emit(AddProductToCartFailure(result.exception.errorMessage));
    }
  }

  void increaseQuantity() {
    quantity++;
    curClickIsRight = true;
    emit(UpdateQuantitySectionState(quantity));
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
      curClickIsRight = false;
      emit(UpdateQuantitySectionState(quantity));
    }
  }
}
