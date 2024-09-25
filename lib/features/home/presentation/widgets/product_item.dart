import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/extensions/string_ext.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/widgets/my_default_image.dart';
import 'package:plants_app/features/home/domain/entities/product_data.dart';
import 'package:plants_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:plants_app/features/home/presentation/widgets/tab_item.dart';

class ProductItem extends StatelessWidget {
  final ProductData product;

  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goToProductDetails(
          product: product,
          categoryName: context.read<HomeCubit>().curCategotName,
        );
      },
      child: SizedBox(
        height: context.height * 0.50,
        width: context.width * 0.80,
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            elevation: 0,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: context.height * 0.20,
                    width: context.width * 0.80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: AppColors.tertiaryColor,
                    ),
                    child: Hero(
                      tag: product.id,
                      child: MyDefaultImage(
                        url: product.image,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    product.name.toTitleCase(),
                    style: GoogleFonts.readexPro().copyWith(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: GoogleFonts.readexPro().copyWith(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.black,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/bag.svg"),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Add to cart",
                          style: GoogleFonts.readexPro().copyWith(
                            color: Colors.white,
                            fontSize: 16,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
