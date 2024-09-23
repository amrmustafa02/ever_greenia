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

final class LoginButtonChangeState extends AuthState {
  
}

final class RegisterButtonChangeState extends AuthState {
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return super == other;
  }

  @override
  int get hashCode => super.hashCode;
}

final class LoginSuccessState extends AuthState {}

final class RegisterSuccessState extends AuthState {}
