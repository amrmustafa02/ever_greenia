import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'place_order_state.dart';


class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());
}
