part of 'main_cubit.dart';

@immutable
sealed class MainState {}

final class MainInitial extends MainState {}

final class ConfigLoaded extends MainState {
  bool isUserLogged;

  ConfigLoaded(this.isUserLogged);
}
