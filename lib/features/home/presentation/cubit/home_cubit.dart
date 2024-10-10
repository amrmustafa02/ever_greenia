import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/features/home/domain/entities/category_data.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/features/home/domain/repos/home_repo.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  late AnimationController controllerSearchAnimation;
  late AnimationController textFadeLeftAnimationController;

  HomeRepo homeRepo;

  List<CategoryData> categories = List.generate(
    10,
    (_) => CategoryData.fakeDate(),
  );

  List<ProductData> curProducts = List.generate(
    10,
    (e) => ProductData.fakeDate(e.toString()),
  );

  var listKey = UniqueKey();

  int curTabIndex = 0;

  String curCategoryName = "";

  bool isLoading = true;
  TextEditingController controllerSearch = TextEditingController();
  ValueNotifier<bool> isSearchOpen = ValueNotifier(false);

  void loadProductsAndCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    List<ProductData> products = [];

    try {
      var response = await Future.wait(
        [
          homeRepo.getCategories(),
          homeRepo.getProducts(),
        ],
      );

      var categoriesResponse = response[0];
      var productsResponse = response[1];

      switch (categoriesResponse) {
        case SuccessRequest():
          categories = categoriesResponse.data as List<CategoryData>;
          isLoading = false;
          break;
        case FailureRequest():
          emit(HomeLoadedFailure(categoriesResponse.exception.errorMessage));
          isLoading = false;
          return;
      }
      switch (productsResponse) {
        case SuccessRequest():
          products = productsResponse.data as List<ProductData>;
          isLoading = false;

          break;
        case FailureRequest():
          isLoading = false;

          emit(HomeLoadedFailure(productsResponse.exception.errorMessage));
          return;
      }

      for (var category in categories) {
        category.products = products
            .where((element) => element.categoryId == category.id)
            .toList();
      }

      curProducts = categories[curTabIndex].products;
      curCategoryName = categories[curTabIndex].name;

      isLoading = false;

      emit(HomeInitial());
    } catch (e) {
      emit(HomeLoadedFailure(e.toString()));
    }
  }

  void changeTab(int index) {
    if (index == curTabIndex) return;

    curTabIndex = index;
    curProducts = categories[curTabIndex].products;
    curCategoryName = categories[curTabIndex].name;
    listKey = UniqueKey();

    emit(HomeLoadedSuccess());
  }

  void changeCardsKey() {
    listKey = UniqueKey();
    emit(HomeLoadedSuccess());
  }

  void refresh() {
    emit(HomeInitial());
    loadProductsAndCategories();
  }

  void onSearchOpen() {
    isSearchOpen.value = true;
    controllerSearchAnimation.forward();
    textFadeLeftAnimationController.reverse();
    controllerSearch.text = "";
    emit(SearchEmptyState());
  }

  void onCloseSearch() async {

    await controllerSearchAnimation.reverse();
    // await Future.delayed(const Duration(milliseconds: 300));
    textFadeLeftAnimationController.forward();
    isSearchOpen.value = false;

  }

  Future<void> search() async {
    emit(SearchLoadingState());

    var result = await homeRepo.search(controllerSearch.text);
    switch (result) {
      case SuccessRequest<List<ProductData>>():
        if (result.data.isEmpty) {
          emit(SearchEmptyState());
          return;
        }
        emit(SearchLoadedState(result.data));
      case FailureRequest():
        emit((SearchFailureState()));
    }
  }

  String getCategoryName(String categoryId) {
    for (var category in categories) {
      if (category.id == categoryId) {
        return category.name;
      }
    }
    return "";
  }

  Future<void> addProductToCart(String productId, CartCubit cartCubit) async {
    emit(AddToCartLoadingState());
    var result = await cartCubit.addProductToCart(productId, 1);

    if (result) {
      emit(AddToCartSuccessState());
    } else {
      emit(AddToCartFailureState("Quantity not available"));
    }
  }
}
