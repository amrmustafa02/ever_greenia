import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

class LoginFormField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;
  final Function(String?) validator;
  final Function(String?) onChanged;
  final TextEditingController controller;
  final bool isPassword;

  const LoginFormField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.onChanged,
    required this.controller,
    this.isPassword = false,
  });

  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: AppFontStyles.readexPro400_16.copyWith(
        color: AppColors.darkGreen,
      ),
      controller: widget.controller,
      obscureText: _obscureText,
      validator: (text) => widget.validator(text),
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  // context.goBack();
                  // Navigator.pop(context);

                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText
                      ? EneftyIcons.eye_bold
                      : EneftyIcons.eye_slash_bold,
                  color: AppColors.darkGreen,
                ),
              )
            : null,
        // suffix: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
        prefixIcon: Icon(
          widget.prefixIcon,
          color: AppColors.darkGreen,
        ),
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        fillColor: AppColors.darkGreen.withOpacity(0.3),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        hintStyle: AppFontStyles.readexPro400_16.copyWith(
          color: AppColors.darkGreen,
        ),
      ),
    );
  }
}
