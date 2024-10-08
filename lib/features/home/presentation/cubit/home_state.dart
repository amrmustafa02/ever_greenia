part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoadedSuccess extends HomeState {}

final class HomeLoadedFailure extends HomeState {
  final String error;

  HomeLoadedFailure(this.error);
}

final class AddToCartLoadingState extends HomeState {}

final class AddToCartSuccessState extends HomeState {}

final class AddToCartFailureState extends HomeState {
  final String error;

  AddToCartFailureState(this.error);
}

final class SearchEmptyState extends HomeState {}

final class SearchLoadingState extends HomeState {}

final class SearchLoadedState extends HomeState {
  final List<ProductData> products;

  SearchLoadedState(this.products);
}

final class SearchFailureState extends HomeState {}
