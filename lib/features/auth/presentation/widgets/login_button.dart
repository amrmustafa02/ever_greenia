import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final Function() onTap;
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, c) =>
          c is LoginButtonChangeState || c is RegisterButtonChangeState,
      builder: (context, state) {
        log("AuthState: $state");
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGreen,
            padding: const EdgeInsets.symmetric(vertical: 12),
            disabledBackgroundColor: AppColors.darkGreen.withOpacity(0.2),
          ),
          onPressed:
              context.read<AuthCubit>().isAuthButtonEnabled ? onTap : null,
          child: Text(
            buttonText,
            style: AppFontStyles.readexProBold_16.copyWith(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
