import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/cubit/cart/cubit/cart_cubit.dart';
import 'package:plants_app/core/entities/cart_product_data.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/widgets/my_default_image.dart';

class CartProductWidget extends StatelessWidget {
  final CartProductData product;
  const CartProductWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(product.id),
      onDismissed: (direction) {},
      child: ListTile(
        title: Text(product.name),
        subtitle: Text("${product.price}\$"),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.bgColor,
                  AppColors.bgColor.withOpacity(0.5),
                  // Colors.white.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),

              shape: BoxShape.circle,
              // color: AppColors.primaryColor,
            ),
            child: MyDefaultImage(url: product.image),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (product.quantity > 1)
              IconButton(
                onPressed: () {
                  if (product.quantity > 1) {
                    context.read<CartCubit>().updateQuantity(
                          product.id.toString(),
                          product.quantity - 1 as int,
                        );
                  }
                },
                icon: const Icon(
                  EneftyIcons.minus_cirlce_bold,
                  color: AppColors.darkGreen,
                ),
              ),
            if (product.quantity == 1)
              IconButton(
                onPressed: () {
                  context.read<CartCubit>().deleteProductFromCart(
                        product.id.toString(),
                      );
                },
                icon: const Icon(
                  Icons.delete_rounded,
                  color: AppColors.darkGreen,
                ),
              ),
            Text(
              product.quantity.toString(),
              style: AppFontStyles.readexPro400_14,
            ),
            IconButton(
              onPressed: () {
                context.read<CartCubit>().updateQuantity(
                      product.id.toString(),
                      product.quantity + 1 as int,
                    );
              },
              icon: const Icon(
                EneftyIcons.add_circle_bold,
                color: AppColors.darkGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
