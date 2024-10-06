import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    log("HomeHeader: build: $key");
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
}
