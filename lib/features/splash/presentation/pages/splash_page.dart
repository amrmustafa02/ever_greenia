import 'package:animate_do/animate_do.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// for rotation

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().checkUserLogged();
  }
  @override
  Widget build(BuildContext context) {
    var imageSize = 50.w;
    return BlocListener<MainCubit, MainState>(
      listener: (context, state) {
        if (state is ConfigLoaded) {
          Future.delayed(
            const Duration(seconds: 3),
            () {
              // ignore: use_build_context_synchronously
              context.goToNamedReplace(
                state.isUserLogged ? RoutesName.home : RoutesName.onboarding,
              );
            },
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ZoomIn(
                animate: true,
                key: UniqueKey(),
                duration: const Duration(milliseconds: 3000),
                child: Image.asset(
                  "assets/images/logo_tr.png",
                  width: imageSize,
                  height: imageSize,
                ),
              ),
              SizedBox(height: 3.h),
              ZoomIn(
                duration: const Duration(milliseconds: 3000),
                child: Text(
                  'GrowGreen',
                  style: AppFontStyles.readexPro500_20.copyWith(
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              AnimatedTextKit(
                key: UniqueKey(),
                animatedTexts: [
                  // RotateAnimatedText(
                  //   'Quality Herbs',
                  //   textStyle: AppFontStyles.readexPro400_16.copyWith(
                  //     color: AppColors.darkGreen,
                  //   ),
                  // ),
                  ColorizeAnimatedText(
                    'Grow Your World with Our Plants!',
                    textStyle: AppFontStyles.readexPro400_16.copyWith(
                      color: AppColors.darkGreen,
                    ),
                    colors: [
                      AppColors.darkGreen,
                      AppColors.lightGreen,
                    ],
                    speed: const Duration(milliseconds: 60),
                  ),
                ],
                totalRepeatCount: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
