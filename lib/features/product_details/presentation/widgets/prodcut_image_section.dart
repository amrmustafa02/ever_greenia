import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';

import '../../../../core/theme/app_colors.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          bottom: context.height * 0.06,
          child: SizedBox(
            width: context.width,
            // height: context.height / 2,
            child: FittedBox(
              child: Text(
                "Plants",
                maxLines: 1,
                style: GoogleFonts.readexPro().copyWith(
                  color: AppColors.secondaryColor.withOpacity(0.2),
                  height: 1,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 0),
          child: Hero(
            tag: index,
            child: Image.asset(
              "assets/images/plant.png",
              height: context.height * 0.35,
              // width: context.width * 0.30,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
