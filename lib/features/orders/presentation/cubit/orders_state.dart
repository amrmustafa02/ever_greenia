part of 'orders_cubit.dart';

@immutable
sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersLoadedSuccess extends OrdersState {}

final class OrdersLoadedFailure extends OrdersState {
  final String error;

  OrdersLoadedFailure(this.error);
}
