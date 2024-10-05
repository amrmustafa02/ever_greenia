import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

import '../theme/app_colors.dart';

class DefaultFormField extends StatefulWidget {
  final String label;
  final bool enabled;
  final int maxLines;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final String? Function(String?) onChanged;
  final bool obscureText;
  final TextInputType keyboardType;

  const DefaultFormField({
    super.key,
    required this.controller,
    required this.validator,
    required this.label,
    this.enabled = true,
    required this.onChanged,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<DefaultFormField> createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
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
                    showPassword
                        ? EneftyIcons.eye_bold
                        : EneftyIcons.eye_slash_bold,
                    size: 20),
                color: AppColors.darkGreen,
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              )
            : null,
        // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
      ),
      onChanged: widget.onChanged,
      validator: widget.validator,
      obscureText: showPassword,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
    );
  }

  OutlineInputBorder _buildBorder({Color color = Colors.grey}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color,
        width: 0.5,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
    );
  }
}
