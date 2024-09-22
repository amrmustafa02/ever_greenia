import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/features/auth/domain/repos/auth_repo.dart';
import 'package:regexpattern/regexpattern.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  late AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());

  // TextEditingControllers
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  bool isLoginButtonEnabled = false;

  void onLoginFormChanged() {
    var isVaildEmail = emailLoginController.text.isEmail();

    var isEmptyField = emailLoginController.text.isEmpty ||
        passwordLoginController.text.isEmpty;
    var newLoginButtonEnabled = isVaildEmail && !isEmptyField;

    if (isLoginButtonEnabled != newLoginButtonEnabled) {
      isLoginButtonEnabled = newLoginButtonEnabled;
      emit(LoginButtonChangeState());
    }
  }

  Future<void> login() async {
    emit(AuthLoading());

    var email = emailLoginController.text;
    var password = passwordLoginController.text;

    var result = await authRepo.login(email, password);
    switch (result) {
      case SuccessRequest():
        emit(LoginSuccessState());
        break;
      case FailedRequest<String>():
        emit(AuthLoadedFailure(result.exception.errorMessage));
    }
  }
}
