import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:plants_app/features/home/domain/entities/category_data.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/features/home/presentation/widgets/cart_section.dart';
import 'package:plants_app/features/home/presentation/widgets/home_header.dart';
import 'package:plants_app/features/home/presentation/widgets/product_item.dart';
import 'package:plants_app/features/home/presentation/widgets/tab_bar_section.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../auth/presentation/pages/login_page.dart';
import 'cart_empty.dart';

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

  @override
  Widget build(BuildContext context) {
    log("user data: ${context.read<MainCubit>().isUserLogged}");
    return AdvancedDrawer(
      backdrop: _drawerBackgroundColor(),
      controller: _advancedDrawerController,
      openRatio: 0.50,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: true,
      disabledGestures: true,
      drawer: _drawerBody(),
      child: MyScaffold(
        child: Center(
          child: DefaultTabController(
            length: widget.categories.length,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Skeleton.keep(
                  child: HomeHeader(onTap: () {
                    _advancedDrawerController.showDrawer();
                  }),
                ),
                Skeleton.shade(
                  child: TabBarSection(
                    categories: widget.categories,
                  ),
                ),
                const SizedBox(height: 32),
                const Spacer(),
                SizedBox(
                  height: context.height * 0.50,
                  width: context.width * 0.85,
                  child: AppinioSwiper(
                    initialIndex: 0,
                    loop: false,
                    onEnd: () {
                      // log("onEnd");
                      setState(() {});
                    },
                    key: UniqueKey(),
                    allowUnlimitedUnSwipe: true,
                    backgroundCardScale: 0.95,
                    backgroundCardCount: 2,
                    duration: const Duration(milliseconds: 500),
                    // invertAngleOnBottomDrag: true,
                    backgroundCardOffset: const Offset(00, -40),
                    cardBuilder: (BuildContext context, int index) {
                      log("index: $index");
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
                const Spacer(),
                Visibility(
                  visible: context.read<MainCubit>().isUserLogged,
                  replacement: const CartEmpty(),
                  child: const CartSection(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _drawerBody() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor.withOpacity(0.5),
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (context.read<MainCubit>().isUserLogged) ...[
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(
                  EneftyIcons.logout_bold,
                  color: Colors.red,
                ),
                title: Text(
                  'Logout',
                  style: AppFontStyles.readexPro400_16,
                ),
                onTap: () async {
                  await context.read<MainCubit>().logout();
                  context.removeAllAndPush(RoutesName.splash);
                },
              ),
            ],
            if (!context.read<MainCubit>().isUserLogged) ...[
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(EneftyIcons.login_bold),
                title: const Text(
                  'Login',
                ),
                onTap: () {
                  _advancedDrawerController.hideDrawer();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const FractionallySizedBox(
                        heightFactor: 0.9,
                        child: LoginPage(),
                      );
                    },
                  );
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.close),
              title: const Text(
                'Close',
              ),
              onTap: () {
                _advancedDrawerController.hideDrawer();
              },
            ),
          ],
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
