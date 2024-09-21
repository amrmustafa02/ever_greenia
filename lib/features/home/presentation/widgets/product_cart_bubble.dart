import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_colors.dart';

class ProductCartBubble extends StatelessWidget {
  final double margin;
  const ProductCartBubble({
    super.key,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: margin),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.bgColor,
        border: Border.all(
          color: AppColors.lightGreen,
        ),
      ),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: AppColors.tertiaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/plant.png",
          ),
        ),
      ),
    );
  }
}
