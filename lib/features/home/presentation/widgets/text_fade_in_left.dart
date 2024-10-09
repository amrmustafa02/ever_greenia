import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FadeInLeftText extends StatefulWidget {
  const FadeInLeftText({super.key});

  @override
  State<FadeInLeftText> createState() => _FadeInLeftTextState();
}

class _FadeInLeftTextState extends State<FadeInLeftText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().textFadeLeftAnimationController =
        AnimationController(
          duration: const Duration(milliseconds: 2500),
          vsync: this,
        );

    _controller = context.read<HomeCubit>().textFadeLeftAnimationController;
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-2, 0), // Starts from left outside the screen
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "Let's, Make Our\nlives ",
                style: GoogleFonts.readexPro().copyWith(
                  color: Colors.black,
                  fontSize: 20.sp,
                ),
              ),
              TextSpan(
                text: "Greener",
                style: GoogleFonts.readexPro().copyWith(
                  color: Colors.black,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
