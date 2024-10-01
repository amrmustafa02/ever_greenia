import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

class PaymentDetailsSection extends StatelessWidget {
  const PaymentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Payment Details", style: AppFontStyles.readexPro600_16),
      ],
    );
  }
}
