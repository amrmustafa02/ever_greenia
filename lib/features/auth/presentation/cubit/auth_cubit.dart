import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // TextEditingControllers
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  bool isLoginButtonEnabled = false;

  void onLoginFormChanged() {
    var isVaildEmail = emailLoginController.text.isEmail();
    var passwordVaild = passwordLoginController.text.isPasswordHard();

    var isEmptyField = emailLoginController.text.isEmpty ||
        passwordLoginController.text.isEmpty;
    var newLoginButtonEnabled = isVaildEmail && passwordVaild && !isEmptyField;

    if (isLoginButtonEnabled != newLoginButtonEnabled) {
      isLoginButtonEnabled = newLoginButtonEnabled;
      emit(LoginButtonChangeState());
    }
  }
}
