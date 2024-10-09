import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:plants_app/features/home/presentation/widgets/search_list_item.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/app_font_styles.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchBodyState();
  }
}

class _SearchBodyState extends State<SearchBody> with TickerProviderStateMixin {
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().controllerSearchAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _heightAnimation = Tween<double>(begin: 0, end: 300).animate(
      CurvedAnimation(
        parent: context.read<HomeCubit>().controllerSearchAnimation,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    context.read<HomeCubit>().controllerSearchAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("build body");
    return AnimatedBuilder(
      animation: context.read<HomeCubit>().controllerSearchAnimation,
      builder: (context, child) {
        return AnimatedContainer(
          alignment: Alignment.topCenter,
          decoration: _buildBoxDecoration(),
          height: _heightAnimation.value,
          width: context.width * 0.9,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOut,
          child: BlocBuilder<HomeCubit, HomeState>(
            buildWhen: (previous, current) {
              var buildWhen = current is SearchEmptyState ||
                  current is SearchFailureState ||
                  current is SearchLoadingState ||
                  current is SearchEmptyState ||
                  current is SearchLoadedState;
              return buildWhen;
            },
            builder: (context, state) {
              if (state is SearchEmptyState ||
                  state is HomeInitial ||
                  state is HomeLoading) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 15.h,
                          child: Image.asset("assets/images/no_data.png"),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No Results Found",
                          style: AppFontStyles.readexProBold_16,
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state is SearchLoadingState) {
                return Center(
                  child: Lottie.asset(
                    "assets/lottie/plants_loading.json",
                    width: 50.w,
                  ),
                );
              }
              if (state is SearchFailureState) {
                return Center(
                  child: Lottie.asset(
                    "assets/lottie/error.json",
                    width: 50.w,
                  ),
                );
              }
              if (state is SearchLoadedState) {
                log("Search Loaded State: ${state.products.length}");
                var products = state.products;
                return ListView.separated(
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    var product = products[index];
                    return SearchListItem(product: product);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider().setHorizontalPadding();
                  },
                  itemCount: products.length,
                );
              }
              return const SizedBox(
                child: Text("Something went wrong"),
              );
            },
          ),
        );
      },
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Colors.white,
          AppColors.bgColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: Border.all(color: AppColors.darkBlueColor),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }
}
