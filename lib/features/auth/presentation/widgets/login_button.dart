import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGreen,
            padding: const EdgeInsets.symmetric(vertical: 12),
            disabledBackgroundColor: AppColors.darkGreen.withOpacity(0.2),
          ),
          onPressed: context.read<AuthCubit>().isLoginButtonEnabled
              ? context.read<AuthCubit>().login
              : null,
          child: Text(
            "Login",
            style: AppFontStyles.readexProBold_16.copyWith(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
