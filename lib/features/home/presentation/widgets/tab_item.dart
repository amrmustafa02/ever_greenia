import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
      height: 7.h,
      child: Tab(
        icon: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            border: Border.all(
              color: AppColors.darkGreen,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: isActive ? AppColors.darkGreen : Colors.white,
            ),
            child: Text(
              text,
              style: GoogleFonts.readexPro().copyWith(
                color: isActive ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
