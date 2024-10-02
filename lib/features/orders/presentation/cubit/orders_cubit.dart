import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'orders_state.dart';


class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());
}
