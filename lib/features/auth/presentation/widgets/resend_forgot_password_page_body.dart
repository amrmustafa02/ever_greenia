import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/app_font_styles.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_form_field.dart';
import '../widgets/circle_page_header.dart';

class ResendForgotPasswordPageBody extends StatelessWidget {
  const ResendForgotPasswordPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CirclePageHeader(imageUrl: 'assets/images/enter_email.png'),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Email Verification",
                  style: AppFontStyles.readexPro600_22,
                ),
                SizedBox(height: 2.h),
                Text(
                  "Please enter your email address.\nWe will send you a code to reset your password",
                  textAlign: TextAlign.center,
                  style:
                      AppFontStyles.nunito400_16.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 2.h),
                DefaultFormField(
                  controller: context.read<AuthCubit>().emailController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'This Field is Required';
                    }
                    if (!text.isEmail()) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  label: 'Email',
                  onChanged: (text) {
                    context.read<AuthCubit>().onResendCodeFormChanged();
                    return null;
                  },
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 50.w,
                  height: 5.h,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      var cubit = context.read<AuthCubit>();
                      return DefaultButton(
                        enableButton: cubit.isResetPasswordButtonEnabled,
                        onTap: cubit.resendCode,
                        label: 'Send',
                      );
                    },
                  ),
                ),
              ],
            ).setHorizontalPadding(),
          ),
        ),
      ],
    );
  }
}
