import 'dart:async';
import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/features/home/presentation/widgets/search_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.onTap,
    this.showDrawer = true,
  });

  final Function() onTap;
  final bool showDrawer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FadeInLeft(
              key: const ValueKey("HomeHeader"),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Let's, Make Our\nlives ",
                      style: GoogleFonts.readexPro().copyWith(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: "Greener",
                      style: GoogleFonts.readexPro().copyWith(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // AnimSearchBar(
            //   width: 80.w,
            //   textController: TextEditingController(),
            //   onSuffixTap: null,
            //   onSubmitted: (value) {},
            // ),
            Visibility(
              visible: showDrawer,
              child: FadeInRight(
                child: IconButton(
                  onPressed: onTap,
                  icon: const Icon(
                    Icons.menu,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      log("timer");
    });
  }
}
