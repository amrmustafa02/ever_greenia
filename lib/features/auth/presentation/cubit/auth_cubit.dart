import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/models/user_data.dart';
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
    var isVaildEmail = emailController.text.isEmail();
    var isVaildPassword = passwordController.text.isPasswordHardWithspace();

    var isEmptyField =
        emailController.text.isEmpty || passwordController.text.isEmpty;

    var newRegisterButtonEnabled =
        isVaildEmail && isVaildPassword && !isEmptyField;

    if (isAuthButtonEnabled != newRegisterButtonEnabled) {
      isAuthButtonEnabled = newRegisterButtonEnabled;
      log(" isRegisterButtonEnabled: $isAuthButtonEnabled");
      emit(AuthButtonChangeState());
    }
  }

  void onConfirmFormChanged(String code) {
    confirmCode = code;
    var isVaildCode = code.isNumeric();
    var isEmptyField = code.isEmpty;

    var newConfirmButtonEnabled =
        isVaildCode && !isEmptyField && confirmCode.length == 4;

    if (isConfirmButtonEnabled != newConfirmButtonEnabled) {
      isConfirmButtonEnabled = newConfirmButtonEnabled;
      emit(AuthButtonChangeState());
    }
  }

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
            secureStorage.write(key: 'token', value: result.data.token),
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
        emit(ConfirmButtonChangeState());
        break;
      case FailedRequest():
        emit(ConfirmFailedState(result.exception.errorMessage));
    }
  }
}
