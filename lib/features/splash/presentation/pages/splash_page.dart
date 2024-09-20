import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'dart:math' as math; // for rotation

import '../cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return const _SplashPageBody();
        },
      ),
    );
  }
}

class _SplashPageBody extends StatefulWidget {
  const _SplashPageBody();

  @override
  State<_SplashPageBody> createState() => __SplashPageBodyState();
}

class __SplashPageBodyState extends State<_SplashPageBody>
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

    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      context.goToNamedReplace(RoutesName.onboarding);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeInLeft(
              child: Image.asset(
                "assets/images/r_logo.png",
                width: context.width * 0.20,
                height: context.width * 0.20,
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
                      width: context.width * 0.20,
                      height: context.width * 0.20,
                    ),
                  ),
                );
              },
            ),

            // Expanded(
            //   child: FutureBuilder(
            //     future: Future.delayed(const Duration(seconds: 3)),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const SizedBox.shrink();
            //       } else {
            //         return const LogoAndS();
            //       }
            //     },
            //   ),
            // ),
            // Expanded(
            //   child: FutureBuilder(
            //     future: Future.delayed(const Duration(seconds: 5)),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const SizedBox.shrink();
            //       } else {
            //         return const LogoAndS();
            //       }
            //     },
            //   ),
            // )

            FadeInRight(
              child: Image.asset(
                "assets/images/s_logo.png",
                width: context.width * 0.20,
                height: context.width * 0.20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
