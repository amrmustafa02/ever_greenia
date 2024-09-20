part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashLoading extends SplashState {}

final class SplashLoadedSuccess extends SplashState {}

final class SplashLoadedFailure extends SplashState {
  final String error;

  SplashLoadedFailure(this.error);
}
