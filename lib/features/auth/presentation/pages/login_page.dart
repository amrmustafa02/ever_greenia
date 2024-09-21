import 'dart:developer';

import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:plants_app/features/auth/presentation/widgets/login_form_field.dart';
import 'package:plants_app/features/auth/presentation/widgets/login_header.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {},
        child: const LoginPageBody(),
      ),
    );
  }
}

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 35.h),
                  Text(
                    "Welcome Back",
                    style: AppFontStyles.readexProBold_22.copyWith(
                      color: AppColors.darkGreen,
                    ),
                  ),
                  SizedBox(height: 4.h),
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
                      context.read<AuthCubit>().onLoginFormChanged();
                    },
                    controller: context.read<AuthCubit>().emailLoginController,
                  ).setHorizontalPadding(),
                  SizedBox(height: 3.h),
                  LoginFormField(
                    hintText: 'Password',
                    isPassword: true,
                    prefixIcon: EneftyIcons.lock_circle_bold,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'This Field is Required';
                      }
                      if (!text.isPasswordHard()) {
                        return 'Password is not valid';
                      }
                      return null;
                    },
                    onChanged: (_) {
                      context.read<AuthCubit>().onLoginFormChanged();
                    },
                    controller:
                        context.read<AuthCubit>().passwordLoginController,
                  ).setHorizontalPadding(),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Checkbox.adaptive(
                        value: true,
                        activeColor: AppColors.darkGreen,
                        onChanged: (value) {},
                        shape: const CircleBorder(),
                      ),
                      Text(
                        "Remember me",
                        style: AppFontStyles.readexPro400_16.copyWith(
                          color: AppColors.darkGreen,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: AppFontStyles.readexPro600_16.copyWith(
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ),
                    ],
                  ).setHorizontalPadding(),
                  SizedBox(height: 5.h),
                  SizedBox(
                    width: 50.w,
                    child: const LoginButton(),
                  ).setHorizontalPadding(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: AppFontStyles.readexPro400_16.copyWith(
                          color: AppColors.darkGreen,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Sign Up",
                          style: AppFontStyles.readexProBold_16.copyWith(
                            color: AppColors.darkGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: LoginHeader(),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        log("isLoginButtonEnabled: ${context.read<AuthCubit>().isLoginButtonEnabled}");
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGreen,
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          onPressed: context.read<AuthCubit>().isLoginButtonEnabled
              ? () {
                  context.goBack();
                }
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
