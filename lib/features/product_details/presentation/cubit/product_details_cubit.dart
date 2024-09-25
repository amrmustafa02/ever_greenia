import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/features/home/domain/entities/product_data.dart';
part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  late ProductData product;
  ProductDetailsCubit() : super(ProductDetailsInitial());

  initProduct(ProductData product) {
    this.product = product;
  }
}
