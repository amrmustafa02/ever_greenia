import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/entities/user_data.dart';
import 'package:plants_app/core/utils/helper_methods.dart';
import 'package:plants_app/features/product_details/presentation/cubit/product_details_cubit.dart';

import '../../../../core/di/di.dart';
import '../../../../core/theme/app_colors.dart';

class AddToCartSection extends StatelessWidget {
  const AddToCartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () {
        if (!getIt<UserData>().isLogin) {
          HelperMethods.showInfoNotificationToast("Please login first");
          return;
        }

        context
            .read<ProductDetailsCubit>()
            .addProductToCart(context.read<CartCubit>());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.lightGreen,
              radius: 25,
              child: SvgPicture.asset(
                "assets/icons/bag.svg",
                colorFilter: const ColorFilter.mode(
                  AppColors.darkBlueColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Add To Cart",
              style: GoogleFonts.readexPro().copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              "\$${context.read<ProductDetailsCubit>().product.price}",
              style: GoogleFonts.readexPro().copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
