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
}
