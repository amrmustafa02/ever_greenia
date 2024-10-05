import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/orders/domain/entities/order_data.dart';
import 'package:plants_app/features/orders/domain/repo/orders_repo.dart';

part 'orders_state.dart';

@lazySingleton
class OrdersCubit extends Cubit<OrdersState> {
  OrdersRepo ordersRepo;
  late GetOrdersData getOrdersData;

  OrdersCubit(this.ordersRepo) : super(OrdersInitial());

  Future<void> getOrders() async {
    emit(OrdersLoading());
    final result = await ordersRepo.getOrders();

    switch (result) {
      case SuccessRequest<GetOrdersData>():
        getOrdersData = result.data;
        emit(OrdersLoadedSuccess());
      case FailedRequest():
        emit(OrdersLoadedFailure(result.exception.errorMessage));
    }
  }
}
