part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoadedSuccess extends ProductDetailsState {}

final class ProductDetailsLoadedFailure extends ProductDetailsState {
  final String error;

  ProductDetailsLoadedFailure(this.error);
}

final class AddProductToCartSuccess extends ProductDetailsState {}

final class AddProductToCartLoading extends ProductDetailsState {}

final class AddProductToCartFailure extends ProductDetailsState {
  final String error;

  AddProductToCartFailure(this.error);
}

final class UpdateQuantitySectionState extends ProductDetailsState {
  final int quantity;

  UpdateQuantitySectionState(this.quantity);
}
