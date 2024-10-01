import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/widgets/header_bottom_sheet_line.dart';
import 'package:plants_app/core/widgets/my_default_image.dart';
import 'package:plants_app/features/home/presentation/widgets/product_cart_bubble.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/routing/app_router.dart';

// Todo:refactor this part
class CartSection extends StatelessWidget {
  const CartSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) => current is CartLoaded,
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
        return Bounceable(
          onTap: () {
            context.goToNamed(RoutesName.cart);
          },
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: HeaderBottomSheetLine(),
              ),
              SizedBox(
                width: 100.w,
                height: 12.h,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/images/base_item.svg",
                      fit: BoxFit.fill,
                      colorFilter: const ColorFilter.mode(
                        AppColors.lightGreen,
                        BlendMode.srcIn,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Skeleton.shade(
                            child: FadeInLeft(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.black,
                                child: Text(
                                  cubit.products.length.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FadeInUp(
                                key: const ValueKey("CartUp"),
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                child: Text(
                                  "Cart",
                                  style: GoogleFonts.readexPro().copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              FadeInUp(
                                key: const ValueKey("numItemsCart"),
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.easeInOut,
                                child: Text(
                                  "${cubit.products.length.toString()} items",
                                  style: GoogleFonts.inter().copyWith(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          if (cubit.products.length <= 3)
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: List.generate(
                                  cubit.products.length,
                                  (index) {
                                    return FadeInRight(
                                      curve: Curves.easeInOut,
                                      key: ValueKey("itemsCart $index"),
                                      duration: Duration(
                                          milliseconds: 750 + index * 100),
                                      child: ProductCartBubble(
                                        margin: (27 * index).toDouble(),
                                        child: MyDefaultImage(
                                          url: cubit.products[index].image,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          if (cubit.products.length > 3) ...[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Stack(
                                alignment: Alignment.centerRight,
                                children: List.generate(
                                  4,
                                  (index) {
                                    if (index == 3) {
                                      return FadeInRight(
                                        curve: Curves.easeInOut,
                                        key: ValueKey("itemsCart $index"),
                                        duration: Duration(
                                          milliseconds: 750 + index * 100,
                                        ),
                                        child: ProductCartBubble(
                                          margin: (27 * index).toDouble(),
                                          child: Text(
                                            "+${cubit.products.length - 3} ",
                                            style: GoogleFonts.readexPro()
                                                .copyWith(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return FadeInRight(
                                      curve: Curves.easeInOut,
                                      key: ValueKey("itemsCart $index"),
                                      duration: Duration(
                                        milliseconds: 750 + index * 100,
                                      ),
                                      child: ProductCartBubble(
                                        margin: (27 * index).toDouble(),
                                        child: MyDefaultImage(
                                            url: cubit.products[index].image),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
