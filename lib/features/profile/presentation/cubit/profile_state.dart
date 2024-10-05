part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoadedSuccess extends ProfileState {}

final class ProfileLoadedFailure extends ProfileState {
  final String error;

  ProfileLoadedFailure(this.error);
}

final class UpdateSaveButtonState extends ProfileState {}

final class UpdateProfileLoadingState extends ProfileState {}

final class UpdateProfileFailureState extends ProfileState {
  final String error;

  UpdateProfileFailureState(this.error);
}

final class UpdateProfileSuccessState extends ProfileState {}

final class DeleteProfileLoadingState extends ProfileState {}

final class DeleteProfileFailureState extends ProfileState {
  final String error;

  DeleteProfileFailureState(this.error);
}

final class DeleteProfileSuccessState extends ProfileState {}