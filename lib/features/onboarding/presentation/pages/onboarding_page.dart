import 'package:flutter/material.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/constants/app_constants.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _OnboardingPageBody();
  }
}

class _OnboardingPageBody extends StatefulWidget {
  const _OnboardingPageBody();

  @override
  State<_OnboardingPageBody> createState() => _OnboardingPageBodyState();
}

class _OnboardingPageBodyState extends State<_OnboardingPageBody> {
  late AssetImage _image;

  @override
  void initState() {
    super.initState();
    _image = const AssetImage('assets/images/onbaording_image.png');
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await precacheImage(_image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: _image,
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                Text(
                  AppConstants.appName,
                  style: AppFontStyles.readexPro600_12.copyWith(
                    color: Colors.white,
                    fontSize: 28.sp,
                  ),
                ),
                Text(
                  'A simple way to plant your garden',
                  textAlign: TextAlign.center,
                  style: AppFontStyles.readexPro400_18.copyWith(
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 40.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.6),
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      context.goToNamedReplace(RoutesName.login);
                    },
                    child: Text(
                      'Login',
                      style: AppFontStyles.nunito600_16,
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 40.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      backgroundColor: AppColors.darkGreen.withOpacity(0.6),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      context.goToNamedReplace(RoutesName.home);
                    },
                    child: Text(
                      'Explore Our App',
                      style: AppFontStyles.nunito600_16,
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
