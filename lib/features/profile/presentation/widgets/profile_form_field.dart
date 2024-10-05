import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileFormField extends StatefulWidget {
  // final String initialValue;
  final String label;
  final bool enabled;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? Function(String?) onChanged;
  final bool obscureText;

  const ProfileFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.label,
    this.enabled = true,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  State<ProfileFormField> createState() => _ProfileFormFieldState();
}

class _ProfileFormFieldState extends State<ProfileFormField> {
  late bool showPassword;

  @override
  void initState() {
    super.initState();
    showPassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppFontStyles.nunito400_16,
        enabled: widget.enabled,
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                    showPassword ? EneftyIcons.eye_bold : EneftyIcons.eye_slash_bold,
                    size: 20),
                color: AppColors.darkGreen,
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: showPassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      // initialValue: widget.initialValue,
      controller: widget.controller,
    );
  }
}
