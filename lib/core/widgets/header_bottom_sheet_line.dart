import 'package:flutter/material.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/theme/app_colors.dart';

class HeaderBottomSheetLine extends StatelessWidget {
  const HeaderBottomSheetLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: context.width * 0.2,
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
    );
  }
}
