import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_font_styles.dart';

class OrderEmpty extends StatelessWidget {
  const OrderEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return ZoomIn(
      key: UniqueKey(),
      curve: Curves.easeInOut,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/no_data.png"),
          const SizedBox(height: 16),
          Text('No orders found', style: AppFontStyles.readexPro600_16),
        ],
      ),
    );
  }
}
