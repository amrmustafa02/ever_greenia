import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/header_bottom_sheet_line.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 12.h,
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: HeaderBottomSheetLine(),
          ),
          SvgPicture.asset(
            "assets/images/base_item.svg",
            fit: BoxFit.fill,
            colorFilter: const ColorFilter.mode(
              AppColors.lightGreen,
              BlendMode.srcIn,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  "assets/lottie/plant_grow.json",
                  height: 8.h,
                  repeat: false,
                ),
                Text(
                  "Your cart is empty",
                  style: AppFontStyles.readexPro700_16,
                ),
                Transform.flip(
                  flipX: true,
                  child: Lottie.asset("assets/lottie/plant_grow.json",
                      height: 8.h, repeat: false),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
