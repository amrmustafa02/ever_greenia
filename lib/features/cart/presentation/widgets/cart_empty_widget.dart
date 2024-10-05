import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/widgets/default_button.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/app_font_styles.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: SafeArea(
        child: Column(
          children: [
            const DefaultHeader(title: "Cart"),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/lottie/cart_empty.json", width: 50.w),
                  Text(
                    "Your cart is empty!",
                    style: AppFontStyles.readexPro400_18,
                  ),
                  SizedBox(height: 3.h),
                  SizedBox(
                    width: 50.w,
                    height: 5.h,
                    child: DefaultButton(
                      onTap: () => context.goBack(),
                      label: "Continue Shopping",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
