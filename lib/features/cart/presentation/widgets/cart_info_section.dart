import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/widgets/header_bottom_sheet_line.dart';

import '../../../../core/theme/app_colors.dart';
import 'arrow_animation.dart';

class CartInfoSection extends StatelessWidget {
  const CartInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.topCenter,
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: HeaderBottomSheetLine(),
        ),
        SizedBox(
          width: context.width,
          height: context.height * 0.30,
          child: SvgPicture.asset("assets/images/cart_rectancle.svg",
              fit: BoxFit.fill,
              colorFilter: const ColorFilter.mode(
                AppColors.lightGreen,
                BlendMode.srcIn,
              )),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: context.height * 0.00),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text(
                    "Delivery",
                    style: GoogleFonts.readexPro().copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    "\$ 18.00",
                    style: GoogleFonts.readexPro().copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    color: AppColors.darkBlueColor,
                    thickness: 0.5,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Total",
                    style: GoogleFonts.readexPro().copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Text(
                    "\$ 18.00",
                    style: GoogleFonts.readexPro().copyWith(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.darkBlueColor,
                    ),
                    color: AppColors.tertiaryColor.withOpacity(0.3),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Make Payment",
                        style: GoogleFonts.readexPro().copyWith(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.black.withOpacity(0.7),
                          ),
                          child: Row(
                            children: [
                              ArrowAnimation(
                                seconds: 1,
                                color: Colors.white.withOpacity(0.3),
                              ),
                              ArrowAnimation(
                                seconds: 1,
                                color: Colors.white.withOpacity(0.7),
                              ),
                              const ArrowAnimation(
                                seconds: 1,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
