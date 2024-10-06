import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/entities/user_data.dart';
import 'package:plants_app/features/auth/domain/repos/auth_repo.dart';
import 'package:regexpattern/regexpattern.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  final FlutterSecureStorage secureStorage;

  AuthCubit(this.authRepo, this.secureStorage) : super(AuthInitial());

  // TextEditingControllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  String confirmCode = "";

  bool isAuthButtonEnabled = false;
  bool isConfirmButtonEnabled = false;
  bool isResetPasswordButtonEnabled = false;

  void initEmail(String email) {
    emailController.text = email;
  }

  Future<void> login() async {
    emit(AuthLoading());

    var email = emailController.text;
    var password = passwordController.text;

    var result = await authRepo.login(email, password);

    switch (result) {
      case SuccessRequest():
        await Future.wait(
          [
            secureStorage.write(key: 'token', value: "E_${result.data.token}"),
            secureStorage.write(key: 'name', value: result.data.user?.name),
            secureStorage.write(key: 'email', value: result.data.user?.email),
          ],
        );

        getIt<UserData>().init(
          name: result.data.user?.name,
          email: result.data.user?.email,
          token: result.data.token,
        );

        emit(LoginSuccessState());
        break;
      case FailedRequest():
        emit(AuthLoadedFailure(result.exception.errorMessage));
        var statusCode = result.exception.statusCode;
        if (statusCode == 409) {
          emit(EmailNorConfirmedState());
          resendCode();
        }
    }
  }

  Future<void> register() async {
    emit(AuthLoading());

    var name = fullNameController.text;
    var email = emailController.text;
    var password = passwordController.text;

    var result = await authRepo.register(name, email, password);

    switch (result) {
      case SuccessRequest():
        emit(RegisterSuccessState());
        break;
      case FailedRequest():
        emit(AuthLoadedFailure(result.exception.errorMessage));
    }
  }

  Future<void> confirmEmail() async {
    emit(AuthLoading());

    var result = await authRepo.confirmEmail(emailController.text, confirmCode);

    switch (result) {
      case SuccessRequest():
        emit(ConfirmEmailSuccessState());
        break;
      case FailedRequest():
        emit(ConfirmFailedState(result.exception.errorMessage));
    }
  }

  Future<void> resendCode() async {
    var result = await authRepo.resendCode(emailController.text);

    switch (result) {
      case SuccessRequest():
        emit(ResendCodeSuccessState());
        break;
      case FailedRequest():
        emit(ResendCodeFailedState(result.exception.errorMessage));
    }
  }

  Future<void> resetPassword() async {
    emit(AuthLoading());
    var email = emailController.text;
    var code = confirmCode;
    var password = passwordController.text;

    var result = await authRepo.resetPassword(email, code, password);

    switch (result) {
      case SuccessRequest():
        emit(ResetPasswordSuccessState());
        break;
      case FailedRequest():
        emit(ResetPasswordFailedState(result.exception.errorMessage));
    }
  }

  void onLoginFormChanged() {
    var isVaildEmail = emailController.text.isEmail();

    var isEmptyField =
        emailController.text.isEmpty || passwordController.text.isEmpty;
    var newLoginButtonEnabled = isVaildEmail && !isEmptyField;

    if (isAuthButtonEnabled != newLoginButtonEnabled) {
      isAuthButtonEnabled = newLoginButtonEnabled;
      emit(AuthButtonChangeState());
    }
  }

  void onRegisterFormChanged() {
    var isValidEmail = emailController.text.isEmail();
    var isValidPassword = passwordController.text.isPasswordHardWithspace();

    var isEmptyField =
        emailController.text.isEmpty || passwordController.text.isEmpty;

    var newRegisterButtonEnabled =
        isValidEmail && isValidPassword && !isEmptyField;

    if (isAuthButtonEnabled != newRegisterButtonEnabled) {
      isAuthButtonEnabled = newRegisterButtonEnabled;
      log(" isRegisterButtonEnabled: $isAuthButtonEnabled");
      emit(AuthButtonChangeState());
    }
  }

  void onConfirmFormChanged(String code) {
    confirmCode = code;
    var isValidCode = code.isNumeric();
    var isEmptyField = code.isEmpty;

    var newConfirmButtonEnabled =
        isValidCode && !isEmptyField && confirmCode.length == 4;

    if (isConfirmButtonEnabled != newConfirmButtonEnabled) {
      isConfirmButtonEnabled = newConfirmButtonEnabled;
      emit(AuthButtonChangeState());
    }
  }

  void onResendCodeFormChanged() {
    var newResetPasswordButtonEnabled = emailController.text.isEmail();

    if (isResetPasswordButtonEnabled != newResetPasswordButtonEnabled) {
      isResetPasswordButtonEnabled = newResetPasswordButtonEnabled;
      emit(AuthButtonChangeState());
    }
  }

  void onNewPasswordFormChanged() {
    var isValidPassword = passwordController.text.isPasswordHardWithspace();
    var isEmptyField = passwordController.text.isEmpty;

    var newResetPasswordButtonEnabled =
        isValidPassword && !isEmptyField && confirmCode.length == 4;

    if (isResetPasswordButtonEnabled != newResetPasswordButtonEnabled) {
      isResetPasswordButtonEnabled = newResetPasswordButtonEnabled;
      emit(AuthButtonChangeState());
    }
  }

  void onResetPasswordCodeFormChanged(String code) {
    confirmCode = code;
    var isValidCode = code.isNumeric();
    var isEmptyField = code.isEmpty;

    var newResetPasswordButtonEnabled =
        passwordController.text.isPasswordHardWithspace();

    newResetPasswordButtonEnabled =
        (isValidCode && !isEmptyField && confirmCode.length == 4) &&
            newResetPasswordButtonEnabled;

    if (isResetPasswordButtonEnabled != newResetPasswordButtonEnabled) {
      isResetPasswordButtonEnabled = newResetPasswordButtonEnabled;
      emit(AuthButtonChangeState());
    }
  }
}
