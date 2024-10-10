import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/features/auth/presentation/widgets/resend_code_section.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../core/theme/app_font_styles.dart';
import '../../../../core/widgets/default_button.dart';
import '../../../../core/widgets/default_form_field.dart';
import '../widgets/circle_page_header.dart';
import '../widgets/otp_section.dart';
import '../cubit/auth_cubit.dart';

class ResetPasswordPageBody extends StatelessWidget {
  const ResetPasswordPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CirclePageHeader(imageUrl: 'assets/images/enter_email.png'),
            Column(
              children: [
                Text(
                  "Reset Password",
                  style: AppFontStyles.readexPro600_20,
                ),
                SizedBox(height: 0.5.h),
                Text(
                  "Please enter the code sent to your email address",
                  textAlign: TextAlign.center,
                  style:
                      AppFontStyles.nunito400_16.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  context.read<AuthCubit>().emailController.text,
                  textAlign: TextAlign.center,
                  style: AppFontStyles.nunito600_16,
                ),
                SizedBox(height: 0.5.h),
                OtpSection(
                  onCodeChanged:
                      context.read<AuthCubit>().onResetPasswordCodeFormChanged,
                  onSubmit:
                      context.read<AuthCubit>().onResetPasswordCodeFormChanged,
                ),
                SizedBox(height: 2.h),
                DefaultFormField(
                  controller: context.read<AuthCubit>().passwordController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'This Field is Required';
                    }

                    if (!text.isPasswordHardWithspace()) {
                      return 'Please enter a strong password';
                    }
                    return null;
                  },
                  label: 'New Password',
                  onChanged: (text) {
                    context.read<AuthCubit>().onNewPasswordFieldChanged();
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
                        onTap: cubit.resetPassword,
                        label: 'Change Password',
                      );
                    },
                  ),
                ),
                SizedBox(height: 2.h),
                const ResendCodeSection()
              ],
            ).setHorizontalPadding(),
          ],
        ),
      ),
    );
  }
}
