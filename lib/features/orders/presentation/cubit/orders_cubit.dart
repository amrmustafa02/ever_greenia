import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/orders/domain/entities/order_data.dart';
import 'package:plants_app/features/orders/domain/repo/orders_repo.dart';

part 'orders_state.dart';

@injectable
class OrdersCubit extends Cubit<OrdersState> {
  OrdersRepo ordersRepo;
  late GetOrdersData getOrdersData;
  List<OrderData> orders = <OrderData>[];

  OrdersCubit(this.ordersRepo) : super(OrdersInitial());

  Future<void> getOrders() async {
    final result = await ordersRepo.getOrders();
    Future.delayed(const Duration(milliseconds: 1500));

    switch (result) {
      case SuccessRequest<GetOrdersData>():
        getOrdersData = result.data;
        orders = getOrdersData.pendingOrders;
        emit(OrdersLoadedSuccess());
      case FailedRequest():
        emit(OrdersLoadedFailure(result.exception.errorMessage));
    }
  }

  void onTabBarPressed(int index) {
    switch (index) {
      case 0:
        orders = getOrdersData.pendingOrders;
        break;
      case 1:
        orders = getOrdersData.processingOrders;
        break;
      case 2:
        orders = getOrdersData.deliveredOrders;
        break;
      case 3:
        orders = getOrdersData.cancelledOrders;
        break;
      default:
        orders = [];
        break;
    }
    log("len of orders: ${orders.length}");
    emit(OrdersLoadedSuccess());
  }

  void refresh() {
    emit(OrdersInitial());
    getOrders();
  }
}
