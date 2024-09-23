import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
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
        listener: (context, state) {},
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
    return Center(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 35.h),
                Text(
                  "Register",
                  style: AppFontStyles.readexProBold_22.copyWith(
                    color: AppColors.darkGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Create your new account",
                  style: AppFontStyles.nunito400_16.copyWith(
                    color: Colors.grey.withOpacity(0.4),
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
                        "Use 8 characters or more & the first char Upper,\nuse lower case letters, numbers, & symbols",
                        style: AppFontStyles.nunito400_14.copyWith(
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ],
                  ),
                ).setHorizontalPadding(),
                SizedBox(height: 3.h),
                SizedBox(
                  width: 50.w,
                  child: AuthButton(
                    buttonText: "Register",
                    onTap: context.read<AuthCubit>().register,
                  ),
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
          ),
          const Align(
            alignment: Alignment.topCenter,
            child: AuthHeader(),
          ),
        ],
      ),
    );
  }
}
