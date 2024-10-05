import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/constants/app_constants.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

import '../cubit/place_order_cubit.dart';

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Details", style: AppFontStyles.readexPro600_16),
        const SizedBox(height: 16),
        const Divider(),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Text(
            "Delivery Fee",
            style: AppFontStyles.readexPro400_14,
          ),
          trailing: Text(
            "\$${AppConstants.deliveryFee}",
            style: AppFontStyles.readexPro400_14,
          ),
        ),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Text(
            "Items Total Price",
            style: AppFontStyles.readexPro400_14,
          ),
          trailing: Text(
            "\$${context.read<PlaceOrderCubit>().itemsPrice}",
            style: AppFontStyles.readexPro400_14,
          ),
        ),
        const Divider(),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Text(
            "Total Amount",
            style: AppFontStyles.readexPro400_14,
          ),
          trailing: Text(
            "\$${context.read<PlaceOrderCubit>().totalPrice}",
            style: AppFontStyles.readexPro400_14,
          ),
        ),
      ],
    );
  }
}
