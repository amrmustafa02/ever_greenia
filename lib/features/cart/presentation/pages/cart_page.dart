import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/features/cart/presentation/widgets/cart_info_section.dart';
import 'package:plants_app/features/cart/presentation/widgets/cart_header.dart';

import '../../../../core/theme/app_colors.dart';
import '../cubit/cart_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return const _CartPageBody();
        },
      ),
    );
  }
}

class _CartPageBody extends StatelessWidget {
  const _CartPageBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white,
            AppColors.primaryColor,
            AppColors.primaryColor,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.topCenter,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: context.height * 0.1,
                child: const SafeArea(
                  bottom: false,
                  child: CartHeader(),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(
                top: context.height * 0.11,
                // bottom: context.height * 0.3,
              ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                itemBuilder: (context, index) {
                  if (index == 10) {
                    return SizedBox(
                      height: context.height * 0.3,
                    );
                  }
                  return ListTile(
                    title: const Text("The Potted Head"),
                    subtitle: Text("$index Piece"),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Container(
                        height: 60,
                        width: 60,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.primaryColor.withOpacity(0.5),
                              // Colors.white.withOpacity(0.3),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),

                          shape: BoxShape.circle,
                          // color: AppColors.primaryColor,
                        ),
                        child: Image.asset(
                          "assets/images/plant.png",
                        ),
                      ),
                    ),
                  );
                  // return Row(
                  //   children: [
                  //     Text(" $index "),
                  //   ],
                  // );
                },
                separatorBuilder: (context, index) {
                  if (index == 9) {
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
                itemCount: 11,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.width,
                height: context.height * 0.30,
                child: const CartInfoSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
