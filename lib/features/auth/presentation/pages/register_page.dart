import 'dart:developer';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/utils/helper_methods.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:plants_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:plants_app/features/auth/presentation/widgets/login_button.dart';
import 'package:plants_app/features/auth/presentation/widgets/login_form_field.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            Navigator.pop(context);
            context.goToNamed(
              RoutesName.confirmEmail,
              arguments: context.read<AuthCubit>().emailController.text,
            );
          }
          if (state is AuthLoadedFailure) {
            log(state.error);
            Navigator.pop(context);
            HelperMethods.showErrorNotificationToast(state.error);
          }
          if (state is AuthLoading) {
            HelperMethods.showLoadingDliaog(context);
          }
        },
        child: const Scaffold(
          body: _RegisterPageBody(),
        ),
      ),
    );
  }
}

class _RegisterPageBody extends StatelessWidget {
  const _RegisterPageBody();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: AuthHeader(),
          ),
          Text(
            "Register",
            style: AppFontStyles.readexProBold_22.copyWith(
              color: AppColors.darkGreen,
            ),
          ),
          const SizedBox(height: 16),
          LoginFormField(
            hintText: 'Full Name',
            prefixIcon: EneftyIcons.profile_bold,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'This Field is Required';
              }
              if (text.trim().isEmpty) {
                return 'Name is not valid';
              }
              return null;
            },
            onChanged: (_) {
              cubit.onRegisterFormChanged();
            },
            controller: cubit.fullNameController,
          ).setHorizontalPadding(),
          SizedBox(height: 3.h),
          LoginFormField(
            hintText: 'Email',
            prefixIcon: Icons.alternate_email_rounded,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'This Field is Required';
              }
              if (!text.isEmail()) {
                return 'Email is not valid';
              }
              return null;
            },
            onChanged: (_) {
              cubit.onRegisterFormChanged();
            },
            controller: context.read<AuthCubit>().emailController,
          ).setHorizontalPadding(),
          SizedBox(height: 3.h),
          LoginFormField(
            hintText: 'Password',
            isPassword: true,
            prefixIcon: EneftyIcons.lock_2_bold,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'This Field is Required';
              }
              if (!text.isPasswordHardWithspace()) {
                return 'Password is not valid';
              }
              return null;
            },
            onChanged: (_) {
              cubit.onRegisterFormChanged();
            },
            controller: cubit.passwordController,
          ).setHorizontalPadding(),
          SizedBox(height: 3.h),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.darkGreen.withOpacity(0.2),
            ),
            child: Row(
              children: [
                const Icon(
                  EneftyIcons.info_circle_outline,
                  color: AppColors.darkGreen,
                ),
                const SizedBox(width: 16),
                Text(
                  "Use at least 1 uppercase, 1 lowecase, 1 number,\n1 special character and minimum 8 characters",
                  style: AppFontStyles.nunito400_14.copyWith(
                    color: AppColors.darkGreen,
                  ),
                ),
              ],
            ),
          ).setHorizontalPadding(),
          SizedBox(height: 3.h),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return SizedBox(
                width: 50.w,
                child: AuthButton(
                  buttonText: "Register",
                  onTap: context.read<AuthCubit>().register,
                  enabled: context.read<AuthCubit>().isAuthButtonEnabled,
                ),
              );
            },
          ).setHorizontalPadding(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: AppFontStyles.readexPro400_16.copyWith(
                  color: AppColors.darkGreen,
                ),
              ),
              TextButton(
                onPressed: () {
                  context.goToNamedReplace(RoutesName.login);
                },
                child: Text(
                  "Login",
                  style: AppFontStyles.readexProBold_16.copyWith(
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
