import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Payment Details", style: AppFontStyles.readexPro600_16),
        const SizedBox(height: 8),
        ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Text(
            "Delivery Fee",
            style: AppFontStyles.readexPro400_14,
          ),
          trailing: Text(
            "\$4.00",
            style: AppFontStyles.readexPro400_14,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: Text(
            "Total Amount",
            style: AppFontStyles.readexPro400_14,
          ),
          trailing: Text(
            "\$18.00",
            style: AppFontStyles.readexPro400_14,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
