import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/features/cart/presentation/widgets/cart_info_section.dart';
import 'package:plants_app/features/cart/presentation/widgets/cart_header.dart';
import 'package:plants_app/features/cart/presentation/widgets/cart_product.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/cart_empty_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
        if(cubit.products.isEmpty) {
          return const CartEmptyWidget();
        }
        return IgnorePointer(
          ignoring: cubit.isLoading,
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  AppColors.bgColor,
                  AppColors.bgColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: context.height * 0.11,
                      child: const SafeArea(
                        bottom: false,
                        child: DefaultHeader(title: "Cart"),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(
                      top: context.height * 0.11,
                    ),
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      itemBuilder: (context, index) {
                        if (index == cubit.products.length) {
                          return SizedBox(
                            height: context.height * 0.28,
                          );
                        }
                        return CartProductWidget(
                          product: cubit.products[index],
                        );
                      },
                      separatorBuilder: (context, index) {
                        if (index == cubit.products.length - 1) {
                          return const SizedBox.shrink();
                        }
                        return const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: 16,
                            child: Divider(
                              color: AppColors.darkBlueColor,
                              thickness: 0.3,
                            ),
                          ),
                        );
                      },
                      itemCount: cubit.products.length + 1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: context.width,
                      height: context.height * 0.27,
                      child: const CartInfoSection(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, CartState state) {},
    );
  }
}
