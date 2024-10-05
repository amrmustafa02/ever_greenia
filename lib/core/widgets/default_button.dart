import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../theme/app_colors.dart';
import '../theme/app_font_styles.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.enableButton = true,
    required this.onTap,
    required this.label,
  });

  final bool enableButton;
  final Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 6.h,
      child: Bounceable(
        onTap: enableButton ? onTap : null,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: enableButton
                ? AppColors.darkGreen
                : AppColors.darkGreen.withOpacity(0.3),
          ),
          child: Text(
            label,
            style: AppFontStyles.readexPro600_16.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
