import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final Function() onTap;
  final bool enabled;

  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkGreen,
        padding: const EdgeInsets.symmetric(vertical: 12),
        disabledBackgroundColor: AppColors.darkGreen.withOpacity(0.2),
      ),
      onPressed: enabled ? onTap : null,
      child: Text(
        buttonText,
        style: AppFontStyles.readexProBold_16.copyWith(color: Colors.white),
      ),
    );
  }
}
