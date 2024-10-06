import 'package:flutter/material.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CirclePageHeader extends StatelessWidget {
  final String imageUrl;

  const CirclePageHeader({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/images/circle_1.png",
            height: 25.h,
            fit: BoxFit.fill,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            "assets/images/circle_2.png",
            width: 100.w,
            fit: BoxFit.fill,
            height: 30.h,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              // "assets/images/confirm_page_image.png",
              imageUrl,
              width: 60.w,
            ),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                context.goBack();
              },
              icon: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
