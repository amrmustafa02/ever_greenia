import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/widgets/header_bottom_sheet_line.dart';
import 'package:plants_app/features/cart/presentation/widgets/payment_button.dart';

import '../../../../core/theme/app_colors.dart';

class CartInfoSection extends StatelessWidget {
  const CartInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const Align(
          alignment: Alignment.topCenter,
          child: HeaderBottomSheetLine(),
        ),
        SizedBox(
          width: context.width,
          height: context.height * 0.27, 
          child: SvgPicture.asset(
            "assets/images/cart_rectancle.svg",
            fit: BoxFit.fill,
            colorFilter: const ColorFilter.mode(
              AppColors.lightGreen,
              BlendMode.srcIn,
            ),
          ),
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
                const PaymentButton()
              ],
            ),
          ),
        )
      ],
    );
  }
}
