import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';

class ProductItem extends StatelessWidget {
  final String text;
  final int index;

  const ProductItem({super.key, required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goToNamed(RoutesName.productDetails, arguments: index + 1);
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
                      tag: index + 1,
                      child: Image.asset(
                        "assets/images/plant.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    text,
                    style: GoogleFonts.readexPro().copyWith(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Perfect for beginners or anyone looking for an easy-to-care-for plant",
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
