import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/utils/herlper_methods.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:plants_app/features/auth/presentation/widgets/login_button.dart';
import 'package:plants_app/features/auth/presentation/widgets/resend_code_section.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/circle_page_header.dart';

class ConfirmEmailPage extends StatelessWidget {
  const ConfirmEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ConfirmFailedState) {
              log(state.error);
              Navigator.pop(context);
              HelperMethods.showErrorNotificationToast(state.error);
            }
            if (state is AuthLoading) {
              HelperMethods.showLoadingDliaog(context);
            }
            if (state is ConfirmEmailSuccessState) {
              Navigator.pop(context);
              HelperMethods.showSuccessNotificationToast(
                "Confirm Email Success",
              );
              context.removeAllAndPush(RoutesName.login);
            }
            if (state is ResendCodeSuccessState) {
              HelperMethods.showSuccessNotificationToast(
                "Resend Code Success",
              );
            }
            if (state is ResendCodeFailedState) {
              HelperMethods.showErrorNotificationToast(state.error);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CirclePageHeader(
                imageUrl: "assets/images/confirm_page_image.png",
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      Text(
                        "OTP Verification",
                        style: AppFontStyles.readexPro600_22,
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        "Please enter the code sent to your email",
                        style: AppFontStyles.nunito400_16.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        context.read<AuthCubit>().emailController.text,
                        style: AppFontStyles.nunitoBold_16,
                      ),
                      SizedBox(height: 2.h),
                      OtpTextField(
                        numberOfFields: 4,
                        borderRadius: BorderRadius.circular(15),
                        borderColor: AppColors.darkGreen,
                        disabledBorderColor: AppColors.darkGreen,
                        enabledBorderColor: const Color(0XFFDDDDDD),
                        focusedBorderColor: AppColors.darkGreen,
                        borderWidth: 1,
                        keyboardType: TextInputType.number,
                        alignment: Alignment.center,
                        fieldHeight: 60,
                        fieldWidth: context.width * 0.125,
                        showFieldAsBox: true,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: AppColors.tertiaryColor,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                        onCodeChanged: (String code) {
                          log("code: $code");
                          context.read<AuthCubit>().onConfirmFormChanged(code);
                        },
                        onSubmit: (String verificationCode) {
                          log("verificationCode: $verificationCode");
                          context
                              .read<AuthCubit>()
                              .onConfirmFormChanged(verificationCode);
                        },
                      ),
                      SizedBox(height: 2.h),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return SizedBox(
                            width: 50.w,
                            child: AuthButton(
                              buttonText: "Confirm",
                              onTap: context.read<AuthCubit>().confirmEmail,
                              enabled: context
                                  .read<AuthCubit>()
                                  .isConfirmButtonEnabled,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 2.h),
                      const ResendCodeSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
