import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppFontStyles {
  AppFontStyles._();

  // Font sizes
  static double size12 = 12.0.sp;
  static double size14 = 14.0.sp;
  static double size16 = 16.0.sp;
  static double size18 = 18.0.sp;
  static double size20 = 20.0.sp;
  static double size22 = 22.0.sp;

  // Base style for ReadexPro
  static TextStyle readexPro({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.readexPro(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  // Base style for Nunito
  static TextStyle nunito({
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.nunito(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  // All ReadexPro combinations
  static final TextStyle readexPro400_12 = readexPro(
    fontSize: size12,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle readexPro400_14 = readexPro(
    fontSize: size14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle readexPro400_16 = readexPro(
    fontSize: size16,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle readexPro400_18 = readexPro(
    fontSize: size18,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle readexPro400_20 = readexPro(
    fontSize: size20,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle readexPro400_22 = readexPro(
    fontSize: size22,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle readexPro500_12 = readexPro(
    fontSize: size12,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle readexPro500_14 = readexPro(
    fontSize: size14,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle readexPro500_16 = readexPro(
    fontSize: size16,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle readexPro500_18 = readexPro(
    fontSize: size18,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle readexPro500_20 = readexPro(
    fontSize: size20,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle readexPro500_22 = readexPro(
    fontSize: size22,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle readexPro600_12 = readexPro(
    fontSize: size12,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle readexPro600_14 = readexPro(
    fontSize: size14,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle readexPro600_16 = readexPro(
    fontSize: size16,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle readexPro600_18 = readexPro(
    fontSize: size18,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle readexPro600_20 = readexPro(
    fontSize: size20,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle readexPro600_22 = readexPro(
    fontSize: size22,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle readexPro700_12 = readexPro(
    fontSize: size12,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle readexPro700_14 = readexPro(
    fontSize: size14,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle readexPro700_16 = readexPro(
    fontSize: size16,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle readexPro700_18 = readexPro(
    fontSize: size18,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle readexPro700_20 = readexPro(
    fontSize: size20,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle readexPro700_22 = readexPro(
    fontSize: size22,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle readexProBold_12 = readexPro(
    fontSize: size12,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle readexProBold_14 = readexPro(
    fontSize: size14,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle readexProBold_16 = readexPro(
    fontSize: size16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle readexProBold_18 = readexPro(
    fontSize: size18,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle readexProBold_20 = readexPro(
    fontSize: size20,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle readexProBold_22 = readexPro(
    fontSize: size22,
    fontWeight: FontWeight.bold,
  );

  // All Nunito combinations
  static final TextStyle nunito400_12 = nunito(
    fontSize: size12,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle nunito400_14 = nunito(
    fontSize: size14,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle nunito400_16 = nunito(
    fontSize: size16,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle nunito400_18 = nunito(
    fontSize: size18,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle nunito400_20 = nunito(
    fontSize: size20,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle nunito400_22 = nunito(
    fontSize: size22,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle nunito500_12 = nunito(
    fontSize: size12,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle nunito500_14 = nunito(
    fontSize: size14,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle nunito500_16 = nunito(
    fontSize: size16,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle nunito500_18 = nunito(
    fontSize: size18,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle nunito500_20 = nunito(
    fontSize: size20,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle nunito500_22 = nunito(
    fontSize: size22,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle nunito600_12 = nunito(
    fontSize: size12,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle nunito600_14 = nunito(
    fontSize: size14,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle nunito600_16 = nunito(
    fontSize: size16,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle nunito600_18 = nunito(
    fontSize: size18,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle nunito600_20 = nunito(
    fontSize: size20,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle nunito600_22 = nunito(
    fontSize: size22,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle nunito700_12 = nunito(
    fontSize: size12,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle nunito700_14 = nunito(
    fontSize: size14,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle nunito700_16 = nunito(
    fontSize: size16,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle nunito700_18 = nunito(
    fontSize: size18,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle nunito700_20 = nunito(
    fontSize: size20,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle nunito700_22 = nunito(
    fontSize: size22,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle nunitoBold_12 = nunito(
    fontSize: size12,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle nunitoBold_14 = nunito(
    fontSize: size14,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle nunitoBold_16 = nunito(
    fontSize: size16,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle nunitoBold_18 = nunito(
    fontSize: size18,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle nunitoBold_20 = nunito(
    fontSize: size20,
    fontWeight: FontWeight.bold,
  );
  static final TextStyle nunitoBold_22 = nunito(
    fontSize: size22,
    fontWeight: FontWeight.bold,
  );
}
