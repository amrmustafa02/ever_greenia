import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_styles.dart';

class SuccessOrderPage extends StatelessWidget {
  const SuccessOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/onbaording_image.png',
            width: 100.w,
            height: 100.h,
            fit: BoxFit.fill,
          ).blurred(
            colorOpacity: 0.3,
            blur: 10,
            blurColor: Colors.black,
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            height: 50.h,
            width: 90.w,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/lottie/success.json",
                      height: 15.h,
                      repeat: false,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Order Successfully\nPlaced',
                      textAlign: TextAlign.center,
                      style: AppFontStyles.readexPro600_18,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Your order has been successfully placed.\nWe will deliver your order soon.',
                      textAlign: TextAlign.center,
                      style: AppFontStyles.readexPro400_14.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.darkGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        context.goBack();
                      },
                      child: Text(
                        'Back to Home',
                        style: AppFontStyles.readexPro600_16
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                      },
                      child: Text(
                        'Go to Orders',
                        style: AppFontStyles.readexPro600_16.copyWith(
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
