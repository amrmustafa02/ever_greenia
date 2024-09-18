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
