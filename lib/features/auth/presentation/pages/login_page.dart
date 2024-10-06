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
import 'package:plants_app/core/utils/herlper_methods.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:plants_app/features/auth/presentation/widgets/login_button.dart';
import 'package:plants_app/features/auth/presentation/widgets/login_form_field.dart';
import 'package:plants_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatelessWidget {
  final bool showHeader;
  final bool useScaffold;

  const LoginPage({
    super.key,
    this.showHeader = true,
    this.useScaffold = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            Navigator.pop(context);
            context.goToNamedReplace(RoutesName.splash);
          }
          if (state is AuthLoadedFailure) {
            log(state.error);
            Navigator.pop(context);
            HelperMethods.showErrorNotificationToast(state.error);
          }

          if (state is AuthLoading) {
            HelperMethods.showLoadingDliaog(context);
          }

          if (state is EmailNorConfirmedState) {
            context.goToNamed(
              RoutesName.confirmEmail,
              arguments: context.read<AuthCubit>().emailController.text,
            );
          }
        },
        child: Visibility(
          visible: useScaffold,
          replacement: LoginPageBody(
            showHeader: showHeader,
          ),
          child: Scaffold(
            body: LoginPageBody(
              showHeader: showHeader,
            ),
          ),
        ),
      ),
    );
  }
}

class LoginPageBody extends StatelessWidget {
  final bool showHeader;

  const LoginPageBody({
    super.key,
    required this.showHeader,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: showHeader,
            child: const AuthHeader(),
          ),
          Text(
            "Welcome Back",
            style: AppFontStyles.readexProBold_22.copyWith(
              color: AppColors.darkGreen,
            ),
          ),
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
              context.read<AuthCubit>().onLoginFormChanged();
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
              return null;
            },
            onChanged: (_) {
              context.read<AuthCubit>().onLoginFormChanged();
            },
            controller: context.read<AuthCubit>().passwordController,
          ).setHorizontalPadding(),
          SizedBox(height: 3.h),
          BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              return SizedBox(
                width: 50.w,
                child: AuthButton(
                  buttonText: 'Login',
                  onTap: context.read<AuthCubit>().login,
                  enabled: context.read<AuthCubit>().isAuthButtonEnabled,
                ),
              );
            },
          ).setHorizontalPadding(),
          SizedBox(height: 2.h),
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
                onPressed: () {
                  context.goToNamedReplace(RoutesName.register);
                },
                child: Text(
                  "Sign Up",
                  style: AppFontStyles.readexProBold_16.copyWith(
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              context.goToNamed(RoutesName.resendCode);
            },
            child: Text(
              "Forgot Password?",
              style: AppFontStyles.readexPro600_16.copyWith(
                color: AppColors.darkGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
