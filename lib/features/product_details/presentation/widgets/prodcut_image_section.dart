import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/widgets/my_default_image.dart';
import 'package:plants_app/features/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:plants_app/features/product_details/presentation/widgets/model_3d_image.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../../core/theme/app_colors.dart';

class ProductImageSection extends StatefulWidget {
  const ProductImageSection({
    super.key,
    required this.tagId,
  });

  final String tagId;

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ProductDetailsCubit>();
    log("tagId :${widget.tagId}");

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
                context.read<ProductDetailsCubit>().categoryName,
                maxLines: 2,
                style: GoogleFonts.readexPro().copyWith(
                  color: AppColors.lightGreen.withOpacity(0.2),
                  height: 1,
                ),
              ),
            ),
          ),
        ),
        if (cubit.product.is3D) ...[
          Column(
            children: [
              ToggleSwitch(
                cornerRadius: 20.0,
                activeFgColor: Colors.black,
                activeBgColor: const [
                  AppColors.lightGreen,
                ],
                inactiveBgColor: Colors.grey.withOpacity(0.5),
                inactiveFgColor: Colors.white,
                initialLabelIndex: 0,
                totalSwitches: 2,
                labels: const ['Image', '3D'],
                radiusStyle: true,
                onToggle: (index) {
                  pageController.animateToPage(
                    index ?? 0,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.linear,
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    Hero(
                      tag: widget.tagId,
                      child: MyDefaultImage(
                        url: cubit.product.image,
                      ),
                    ),
                    Model3DImage(
                      url: context.read<ProductDetailsCubit>().product.image3D,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ] else ...[
          Hero(
            tag: widget.tagId,
            child: MyDefaultImage(url: cubit.product.image),
          ),
        ]
      ],
    );
  }
}
