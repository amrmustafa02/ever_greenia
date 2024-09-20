import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return const _OnboardingPageBody();
        },
      ),
    );
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
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
                  'R&S',
                  style: GoogleFonts.aBeeZee().copyWith(
                    color: Colors.white,
                    fontSize: 72,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'A simple way to plant your garden',
                  style: GoogleFonts.readexPro().copyWith(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: context.width * 0.40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.4),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Login',
                      style: GoogleFonts.readexPro().copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.02),
                SizedBox(
                  width: context.width * 0.40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      backgroundColor: AppColors.primColor.withOpacity(0.4),
                    ),
                    onPressed: () {
                      context.goToNamedReplace(RoutesName.home);
                    },
                    child: Text(
                      'Get Started',
                      style: GoogleFonts.readexPro().copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.height * 0.05),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
