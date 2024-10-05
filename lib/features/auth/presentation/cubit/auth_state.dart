part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthLoadedSuccess extends AuthState {}

final class AuthLoadedFailure extends AuthState {
  final String error;

  AuthLoadedFailure(this.error);
}

final class ConfirmButtonChangeState extends AuthState {}

final class LoginSuccessState extends AuthState {}

final class RegisterSuccessState extends AuthState {}

final class ConfirmEmailSuccessState extends AuthState {}

final class ConfirmFailedState extends AuthState {
  final String error;

  ConfirmFailedState(this.error);
}

final class AuthButtonChangeState extends AuthState {}

final class EmailNorConfirmedState extends AuthState {}

final class ResendCodeSuccessState extends AuthState {}

final class ResendCodeFailedState extends AuthState {
  final String error;

  ResendCodeFailedState(this.error);
}
