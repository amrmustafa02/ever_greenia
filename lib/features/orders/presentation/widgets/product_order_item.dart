import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../../../../core/widgets/my_default_image.dart';
import '../../domain/entities/order_data.dart';

class ProductOrderItem extends StatelessWidget {
  final OrderProductData product;

  const ProductOrderItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      leading: SizedBox(
        width: 10.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: MyDefaultImage(
            url: product.productId?.image,
          ),
        ),
      ),
      title: Text(
        product.productId?.name.toString() ?? "",
        style: AppFontStyles.readexPro400_14.copyWith(
          color: AppColors.darkBlueColor,
        ),
      ),
      subtitle: Text(
        "\$${product.productId?.price}",
        style: AppFontStyles.readexPro400_14.copyWith(
          color: AppColors.darkGreen,
        ),
      ),
      trailing: Text(
        "X${product.quantity}",
        style: AppFontStyles.readexPro600_14.copyWith(
          color: AppColors.darkGreen,
        ),
      ),
    );
  }
}
