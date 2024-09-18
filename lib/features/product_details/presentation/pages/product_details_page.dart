import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/features/product_details/presentation/widgets/counter_section.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/product_details_cubit.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsCubit(),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          return const _ProductDetailsPageBody();
        },
      ),
    );
  }
}

class _ProductDetailsPageBody extends StatelessWidget {
  const _ProductDetailsPageBody();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.0,
            0.5,
            1.0,
          ],
          colors: [
            // AppColors.primaryColor,
            Colors.white,
            Colors.white,
            Colors.white,
            // AppColors.primaryColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.goBack();
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    const Spacer(),
                    Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(children: [
                        TextSpan(
                          text: "The Potted\n",
                          style: GoogleFonts.readexPro().copyWith(
                            color: Colors.black,
                            fontSize: 24,
                          ),
                        ),
                        TextSpan(
                          text: "Head",
                          style: GoogleFonts.readexPro().copyWith(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                    ),
                    const Spacer(),
                  ],
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.bottomCenter,
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
                    // Container(
                    //   height: context.height * 0.12,
                    //   width: context.height * 0.12,
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         AppColors.primaryColor.withOpacity(0.9),
                    //         AppColors.primaryColor.withOpacity(0.8),
                    //         AppColors.primaryColor.withOpacity(0.7),
                    //         AppColors.primaryColor.withOpacity(0.6),
                    //         Colors.white.withOpacity(0.3),
                    //       ],
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //     ),
                    //   ),
                    // ),
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor.withOpacity(0.7),
                              AppColors.primaryColor.withOpacity(0.6),
                              AppColors.primaryColor.withOpacity(0.5),
                              AppColors.primaryColor.withOpacity(0.4),
                              Colors.white.withOpacity(0.3),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Image.asset(
                        "assets/images/plant.png",
                        height: context.height * 0.24,
                        width: context.width * 0.24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "Perfect for beginners or anyone looking\nfor an easy-to-care-for plant",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.readexPro().copyWith(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                const CounterSection(),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.secondaryColor,
                        radius: 25,
                        child: SvgPicture.asset(
                          "assets/icons/bag.svg",
                          colorFilter: const ColorFilter.mode(
                            AppColors.darkBlueColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Add To Cart",
                        style: GoogleFonts.readexPro().copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "500 EGP",
                        style: GoogleFonts.readexPro().copyWith(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
