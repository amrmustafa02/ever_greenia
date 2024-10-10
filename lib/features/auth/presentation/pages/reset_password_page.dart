import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/features/auth/presentation/widgets/reset_password_page_body.dart';

import '../../../../core/di/di.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/helper_methods.dart';
import '../cubit/auth_cubit.dart';

class ResetPasswordPage extends StatelessWidget {
  final String email;

  const ResetPasswordPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>()..initEmail(email),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is ResendCodeSuccessState) {
            HelperMethods.showSuccessNotificationToast(
              "Password Reset Successful",
            );
          }
          if (state is ResetPasswordSuccessState) {
            Navigator.pop(context);
            HelperMethods.showSuccessNotificationToast(
              "Password Reset Successful",
            );
            context.removeAllAndPush(
              RoutesName.login,
            );
          }
          if (state is ResetPasswordFailedState) {
            Navigator.pop(context);
            HelperMethods.showErrorNotificationToast(state.error);
          }

          if (state is AuthLoading) {
            HelperMethods.showLoadingDliaog(context);
          }
        },
        child: const ResetPasswordPageBody(),
      ),
    );
  }
}
