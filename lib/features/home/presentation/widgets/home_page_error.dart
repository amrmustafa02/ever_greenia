import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:plants_app/features/home/presentation/widgets/home_header.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePageError extends StatelessWidget {
  const HomePageError({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: Center(
        child: ListView(
          children: [
            HomeHeader(
              onTap: () {},
            ),
            LottieBuilder.asset("assets/lottie/error.json", width: 90.h),
            SizedBox(height: 5.h),
            Text(
              "Something went wrong",
              textAlign: TextAlign.center,
              style: AppFontStyles.readexProBold_16,
            ),
            SizedBox(height: 3.h),
            Text(
              "Pull down to refresh",
              textAlign: TextAlign.center,
              style: AppFontStyles.readexProBold_16,
            ),
          ],
        ),
      ),
    );
  }
}
