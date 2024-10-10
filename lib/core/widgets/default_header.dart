import 'package:flutter/material.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DefaultHeader extends StatelessWidget {
  final String title;
  final bool hasBackButton;

  const DefaultHeader({
    super.key,
    required this.title,
    this.hasBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          visible: hasBackButton,
          child: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () {
                context.goBack();
              },
              icon: const Icon(Icons.arrow_back_ios_rounded),
            ),
          ),
        ),
        Text(
          title,
          style: AppFontStyles.readexPro400_16.copyWith(
            color: Colors.black,
            fontSize: 20.sp,
          ),
        ),
      ],
    );
  }
}
