import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:math' as math; // for rotation

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.6, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    context.read<MainCubit>().checkUserLogged();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var imageSize = 20.w;
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
        backgroundColor: AppColors.darkGreen,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInLeft(
                duration: const Duration(milliseconds: 2500),
                child: Image.asset(
                  "assets/images/r_logo.png",
                  width: imageSize,
                  height: imageSize,
                ),
              ),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value, // Rotate animation
                    child: Transform.scale(
                      scale: _scaleAnimation.value, // Zoom in animation
                      child: Image.asset(
                        "assets/images/and_logo.png",
                        width: imageSize,
                        height: imageSize,
                      ),
                    ),
                  );
                },
              ),
              FadeInRight(
                duration: const Duration(milliseconds: 2500),
                child: Image.asset(
                  "assets/images/s_logo.png",
                  width: imageSize,
                  height: imageSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
