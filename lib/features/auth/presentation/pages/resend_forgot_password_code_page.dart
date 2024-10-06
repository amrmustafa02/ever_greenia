import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/herlper_methods.dart';
import '../widgets/resend_forgot_password_page_body.dart';

class ResendForgotPasswordCodePage extends StatelessWidget {
  const ResendForgotPasswordCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ResendCodeSuccessState) {
              HelperMethods.showSuccessNotificationToast(
                "Code Resend Successful",
              );
              context.goToNamed(
                RoutesName.resetPassword,
                arguments: context.read<AuthCubit>().emailController.text,
              );
            }
            if (state is ResendCodeFailedState) {
              HelperMethods.showErrorNotificationToast(state.error);
            }
          },
          child: const ResendForgotPasswordPageBody(),
        ),
      ),
    );
  }
}
