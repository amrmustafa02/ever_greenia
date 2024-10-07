import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plants_app/core/extensions/string_ext.dart';
import 'package:plants_app/features/orders/domain/entities/order_data.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_font_styles.dart';

class OrderInfoDialog extends StatelessWidget {
  final OrderData order;

  const OrderInfoDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              order.id,
              style: AppFontStyles.readexPro600_14,
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: order.id));
                Fluttertoast.showToast(
                  msg: "Copied",
                );
              },
              icon: const Icon(
                EneftyIcons.copy_bold,
                color: AppColors.darkGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Phone: ',
              style: AppFontStyles.readexPro600_14,
            ),
            const SizedBox(width: 8),
            Text(
              order.phone,
              style: AppFontStyles.readexPro400_14,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Address: ',
              style: AppFontStyles.readexPro600_14,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                order.address,
                maxLines: 2,
                style: AppFontStyles.readexPro400_14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Note: ',
              style: AppFontStyles.readexPro600_14,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                order.note,
                maxLines: 2,
                style: AppFontStyles.readexPro400_14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Text(
              'Payment Method: ',
              style: AppFontStyles.readexPro600_14,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                order.paymentMethod.capitalize(),
                maxLines: 1,
                style: AppFontStyles.readexPro400_14,
              ),
            ),
          ],
        )
      ],
    );
  }
}
