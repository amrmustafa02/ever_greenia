import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
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
                  color: AppColors.lightGreen.withOpacity(0.2),
                  height: 1,
                ),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: ModelViewer(
            src: 'assets/lottie/p4.glb',
            // iosSrc: "assets/lottie/preview.usdz",
            // disableZoom: false,
            autoRotate: true,
            autoPlay: true,
            loading: Loading.lazy,
            autoRotateDelay: 1,
          ),
        ),
      ],
    );

    // return SizedBox(
    //   height: context.height * 0.35,
    //   width: context.width,
    //   child: const ModelViewer(
    //     src: 'assets/lottie/preview.glb',
    //     // iosSrc: "assets/lottie/preview.usdz",
    //     disableZoom: true,
    //     autoRotate: true,
    //     autoPlay: true,
    //     autoRotateDelay: 1,
    //   ),

    // );
  }
}
