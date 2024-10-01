import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_colors.dart';

class AddressFormField extends StatelessWidget {
  final String labelText;
  // final Function(String)? onChange;
  final Function(String)? validator;
  const AddressFormField({
    super.key,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText ,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: _buildBorder(),
        focusedBorder: _buildBorder(color: AppColors.darkGreen),
        enabledBorder: _buildBorder(),
      ),
    );
  }
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
