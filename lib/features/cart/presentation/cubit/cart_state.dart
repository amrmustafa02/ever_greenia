part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoadedSuccess extends CartState {}

final class CartLoadedFailure extends CartState {
  final String error;

  CartLoadedFailure(this.error);
}
