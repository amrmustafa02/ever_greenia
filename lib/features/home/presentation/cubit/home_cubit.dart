import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/home/domain/entities/category_data.dart';
import 'package:plants_app/features/home/domain/entities/product_data.dart';
import 'package:plants_app/features/home/domain/repos/home_repo.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  HomeRepo homeRepo;

  List<CategoryData> categories = List.generate(
    10,
    (_) => CategoryData.fakeDate(),
  );

  List<ProductData> curProducts = List.generate(
    10,
    (e) => ProductData.fakeDate(e.toString()),
  );

  int curTabIndex = 0;
  String curCategotName = "";

  HomeCubit(this.homeRepo) : super(HomeInitial());

  void loadProductsAndCategories() async {
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
          break;
        case FailedRequest():
          emit(HomeLoadedFailure(categoriesResponse.exception.errorMessage));
          return;
      }
      switch (productsResponse) {
        case SuccessRequest():
          products = productsResponse.data as List<ProductData>;
          break;
        case FailedRequest():
          emit(HomeLoadedFailure(productsResponse.exception.errorMessage));
          return;
      }

      for (var category in categories) {
        category.products = products
            .where((element) => element.categoryId == category.id)
            .toList();
      }

      curProducts = categories[curTabIndex].products;
      curCategotName = categories[curTabIndex].name;

      emit(HomeLoadedSuccess());
    } on Exception catch (e) {
      emit(HomeLoadedFailure(e.toString()));
    }
  }

  changeTab(int index) {
    curTabIndex = index;
    curProducts = categories[curTabIndex].products;
    curCategotName = categories[curTabIndex].name;

    emit(HomeLoadedSuccess());
  }
}
