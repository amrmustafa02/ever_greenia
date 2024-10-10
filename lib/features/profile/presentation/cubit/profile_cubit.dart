import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:plants_app/core/api/api_result.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/entities/user_data.dart';
import 'package:plants_app/features/profile/domain/entities/profile_data.dart';
import 'package:regexpattern/regexpattern.dart';

import '../../domain/repos/profile_repo.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepo) : super(ProfileInitial());

  final ProfileRepo _profileRepo;

  late ProfileData profileData;

  bool enableSaveButton = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  Future<void> loadProfile() async {
    var response = await _profileRepo.getProfile(getIt<UserData>().token);

    switch (response) {
      case SuccessRequest<ProfileData>():
        profileData = response.data;
        nameController.text = profileData.name;
        emailController.text = profileData.email;
        emit(ProfileLoadedSuccess());
      case FailureRequest():
        emit(ProfileLoadedFailure(response.exception.errorMessage));
    }
  }

  Future updateProfile() async {
    emit(UpdateProfileLoadingState());
    var name =
        nameController.text == profileData.name ? null : nameController.text;
    var newPassword = !newPasswordController.text.isPasswordHardWithspace()
        ? null
        : newPasswordController.text;
    var oldPassword = oldPasswordController.text.isNotEmpty
        ? oldPasswordController.text
        : null;
    var result = await _profileRepo.updateProfile(
      token: getIt<UserData>().token,
      name: name,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );

    switch (result) {
      case SuccessRequest<bool>():
        enableSaveButton = false;
        newPasswordController.clear();
        oldPasswordController.clear();
        emit(UpdateProfileSuccessState());
        emit(UpdateSaveButtonState());
      case FailureRequest<bool>():
        newPasswordController.clear();
        oldPasswordController.clear();
        emit(UpdateProfileFailureState(result.exception.errorMessage));
    }
  }

  onFormChange() {
    log("old name ${profileData.name}");
    log("new name ${nameController.text}");
    var newEnableSaveButton = (profileData.name != nameController.text);
    log("newEnableSaveButton: $newEnableSaveButton");
    newEnableSaveButton = newEnableSaveButton ||
        (newPasswordController.text.isNotEmpty &&
            oldPasswordController.text.isNotEmpty &&
            newPasswordController.text.isPasswordHardWithspace());
    log("newEnableSaveButton: $newEnableSaveButton");

    log("newEnableSaveButton: $newEnableSaveButton");

    if (newEnableSaveButton != enableSaveButton) {
      enableSaveButton = newEnableSaveButton;
      emit(UpdateSaveButtonState());
    }
  }

  deleteProfile() async {
    emit(DeleteProfileLoadingState());

    var result = await _profileRepo.deleteProfile(getIt<UserData>().token);

    switch (result) {
      case SuccessRequest<bool>():
        emit(DeleteProfileSuccessState());
      case FailureRequest<bool>():
        emit(DeleteProfileFailureState(result.exception.errorMessage));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    emailController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    return super.close();
  }
}
