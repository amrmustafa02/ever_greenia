
import 'package:animate_do/animate_do.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:plants_app/features/home/domain/entities/category_data.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:plants_app/features/home/presentation/widgets/cart_section.dart';
import 'package:plants_app/features/home/presentation/widgets/home_header.dart';
import 'package:plants_app/features/home/presentation/widgets/product_item.dart';
import 'package:plants_app/features/home/presentation/widgets/tab_bar_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'cart_empty.dart';
import 'drawer_body.dart';

class HomePageBody extends StatefulWidget {
  final List<CategoryData> categories;
  final List<ProductData> curProducts;

  const HomePageBody({
    super.key,
    required this.categories,
    required this.curProducts,
  });

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final _advancedDrawerController = AdvancedDrawerController();
  int curIndex = 0;
  var listKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: _drawerBackgroundColor(),
      controller: _advancedDrawerController,
      openRatio: 0.50,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: true,
      disabledGestures: true,
      drawer: DrawerBody(
        advancedDrawerController: _advancedDrawerController,
      ),
      child: MyScaffold(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HomeHeader(
                onTap: () {
                  _advancedDrawerController.showDrawer();
                },
              ),
              Skeletonizer(
                enabled: context.read<HomeCubit>().isLoading,
                child: Skeleton.shade(
                  child: TabBarSection(
                    categories: widget.categories,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Spacer(),
              Skeletonizer(
                enabled: context.read<HomeCubit>().isLoading,
                child: SizedBox(
                  height: context.height * 0.50,
                  width: context.width * 0.85,
                  child: AppinioSwiper(
                    initialIndex: 0,
                    loop: false,
                    onEnd: context.read<HomeCubit>().refreshItems,
                    key: context.read<HomeCubit>().listKey,
                    allowUnlimitedUnSwipe: true,
                    backgroundCardScale: 0.95,
                    backgroundCardCount: 2,
                    duration: const Duration(milliseconds: 500),
                    backgroundCardOffset: const Offset(00, -40),
                    cardBuilder: (BuildContext context, int index) {
                      return ZoomIn(
                        duration: Duration(milliseconds: 500 * index),
                        child: ProductItem(
                          product: widget.curProducts[index],
                        ),
                      );
                    },
                    cardCount: widget.curProducts.length,
                  ),
                ),
              ),
              const Spacer(),
              Visibility(
                visible: context.read<MainCubit>().isUserLogged,
                replacement: const CartNotLoggedUser(),
                child: const Skeleton.keep(child: CartSection()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _drawerBackgroundColor() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            AppColors.bgColor,
          ],
        ),
      ),
    );
  }
}
