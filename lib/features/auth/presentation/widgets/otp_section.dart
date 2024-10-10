
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:plants_app/core/extensions/context_extension.dart';

import '../../../../core/theme/app_colors.dart';

class OtpSection extends StatelessWidget {
  final Function(String) onCodeChanged;
  final Function(String) onSubmit;

  const OtpSection({
    super.key,
    required this.onCodeChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      numberOfFields: 4,
      borderRadius: BorderRadius.circular(15),
      borderColor: AppColors.darkGreen,
      disabledBorderColor: AppColors.darkGreen,
      enabledBorderColor: const Color(0XFFDDDDDD),
      focusedBorderColor: AppColors.darkGreen,
      borderWidth: 1,
      keyboardType: TextInputType.number,
      alignment: Alignment.center,
      fieldHeight: 60,
      fieldWidth: context.width * 0.125,
      showFieldAsBox: true,
      decoration: const InputDecoration(
        filled: true,
        fillColor: AppColors.tertiaryColor,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
      onCodeChanged: onCodeChanged,
      onSubmit: onSubmit,
    );
  }
}
