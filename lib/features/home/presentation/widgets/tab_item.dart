import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/theme/app_colors.dart';

class TabItem extends StatelessWidget {
  final String text;
  final bool isActive;
  const TabItem({
    super.key,
    required this.isActive,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Tab(
        icon: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isActive ? AppColors.primColor : Colors.white,
            ),
            child: Text(
              text,
              style: GoogleFonts.readexPro().copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
