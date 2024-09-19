import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FadeInLeft(
              key: UniqueKey(),
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
            FadeInRight(
              key: UniqueKey(),
              child: IconButton(
                onPressed: onTap,
                icon: const Icon(
                  Icons.menu,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
