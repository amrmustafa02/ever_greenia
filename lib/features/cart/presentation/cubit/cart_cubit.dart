import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cart_state.dart';


class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
}
