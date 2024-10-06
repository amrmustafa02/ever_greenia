import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

class PaymentMethodsSection extends StatefulWidget {
  const PaymentMethodsSection({super.key});

  @override
  State<PaymentMethodsSection> createState() => _PaymentMethodsSectionState();
}

class _PaymentMethodsSectionState extends State<PaymentMethodsSection> {
  int selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Bounceable(
        //   onTap: () {
        //     if (selectedIndex == 0) return;
        //
        //     setState(() {
        //       HapticFeedback.heavyImpact();
        //       selectedIndex = 0;
        //     });
        //   },
        //   child: PaymentMethodItem(
        //     isSelected: selectedIndex == 0,
        //     label: 'Credit Card',
        //     icon: EneftyIcons.cards_bold,
        //   ),
        // ),
        // const SizedBox(
        //   height: 16,
        // ),
        Bounceable(
          onTap: () {
            if (selectedIndex == 1) return;
            setState(() {
              HapticFeedback.heavyImpact();
              selectedIndex = 1;
            });
          },
          child: PaymentMethodItem(
            isSelected: selectedIndex == 1,
            label: 'Cash On Delivery',
            icon: EneftyIcons.money_bold,
          ),
        ),
      ],
    );
  }
}

class PaymentMethodItem extends StatelessWidget {
  final bool isSelected;
  final String label;
  final IconData icon;

  const PaymentMethodItem({
    super.key,
    required this.isSelected,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.darkGreen.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
        border: Border.all(
          color: isSelected
              ? AppColors.darkGreen
              : AppColors.darkGreen.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.darkGreen,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            label,
            style: AppFontStyles.readexPro400_16,
          ),
        ],
      ),
    );
  }
}
