part of 'place_order_cubit.dart';

@immutable
sealed class PlaceOrderState {}

final class PlaceOrderInitial extends PlaceOrderState {}

final class PlaceOrderLoading extends PlaceOrderState {}

final class PlaceOrderLoadedSuccess extends PlaceOrderState {}

final class LocationLoading extends PlaceOrderState {}

final class LocationLoadedSuccess extends PlaceOrderState {}

final class PlaceOrderLoadedFailure extends PlaceOrderState {
  final String error;

  PlaceOrderLoadedFailure(this.error);
}
