
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/widgets/header_bottom_sheet_line.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../../../auth/presentation/pages/login_page.dart';

// Todo:refactor this part
class CartNotLoggedUser extends StatefulWidget {
  const CartNotLoggedUser({
    super.key,
  });

  @override
  State<CartNotLoggedUser> createState() => _CartNotLoggedUserState();
}

class _CartNotLoggedUserState extends State<CartNotLoggedUser> {
  double headerHeight = 12.h;
  final double _minHeight = 12.h;
  final double _maxHeight = 17.h;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (c) {
        setState(() {
          headerHeight = 12.h;
        });
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: const LoginPage(
                showHeader: false,
                useScaffold: false,
              ),
            );
          },
        );
      },
      onVerticalDragUpdate: (c) {
        setState(() {
          headerHeight = headerHeight - c.delta.dy;
          if (headerHeight > _maxHeight) {
            headerHeight = _maxHeight;
          }
          if (headerHeight < _minHeight) {
            headerHeight = _minHeight;
          }
        });
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 320),
            curve: Curves.easeInOut,
            height: headerHeight,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            width: 100.w,
            child: SizedBox(
              width: 100.w,
              height: headerHeight.h,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/base_item.svg",
                    fit: BoxFit.fill,
                    height: headerHeight.h,
                    width: 100.w,
                    colorFilter: const ColorFilter.mode(
                      AppColors.lightGreen,
                      BlendMode.srcIn,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Please login to continue",
                      style: AppFontStyles.nunito500_18,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: HeaderBottomSheetLine(),
          ),
        ],
      ),
    );
  }
}
