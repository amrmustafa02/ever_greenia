import 'package:animate_do/animate_do.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/extensions/widget_ext.dart';
import 'package:plants_app/core/widgets/default_button.dart';
import 'package:plants_app/core/widgets/default_header.dart';
import 'package:plants_app/core/widgets/my_scaffold.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_font_styles.dart';
import '../../../../core/utils/helper_methods.dart';
import '../cubit/profile_cubit.dart';
import '../../../../core/widgets/default_form_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(),
      child: const SafeArea(
        bottom: false,
        child: MyScaffold(
          child: Column(
            children: [
              DefaultHeader(title: "Profile"),
              Expanded(child: ProfilePageBody()),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is ProfileInitial || current is ProfileLoadedSuccess,
      builder: (context, state) {
        var cubit = context.read<ProfileCubit>();

        if (state is ProfileInitial) {
          return Skeletonizer(
            containersColor: Colors.grey,
            child: Column(
              children: [
                FadeInLeft(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                  child: DefaultFormField(
                    enabled: false,
                    validator: (_) => null,
                    controller: TextEditingController(text: "amr mustafa"),
                    label: "Email",
                    onChanged: (p0) => null,
                  ),
                ),
                const SizedBox(height: 32),
                FadeInLeft(
                  curve: Curves.easeInOut,
                  duration: const Duration(milliseconds: 500),
                  child: DefaultFormField(
                    enabled: false,
                    validator: (_) => null,
                    controller: TextEditingController(text: "amr mustafa"),
                    label: "Email",
                    onChanged: (p0) => null,
                  ),
                ),
              ],
            ).setHorizontalPadding(),
          );
        }
        if (state is ProfileLoadedSuccess) {
          return Column(
            children: [
              const SizedBox(height: 16),
              FadeInLeft(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 500),
                child: DefaultFormField(
                  enabled: false,
                  controller: cubit.emailController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Email can't be empty";
                    }
                    return null;
                  },
                  label: "Email",
                  onChanged: (text) {
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 32),
              FadeInLeft(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 750),
                child: DefaultFormField(
                  controller: cubit.nameController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Name can't be empty";
                    }
                    return null;
                  },
                  label: "Name",
                  onChanged: (_) => cubit.onFormChange(),
                ),
              ),
              const SizedBox(height: 32),
              FadeInLeft(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1000),
                child: DefaultFormField(
                  obscureText: true,
                  controller: cubit.oldPasswordController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Old Password can't be empty";
                    }

                    return null;
                  },
                  label: "Old Password",
                  onChanged: (_) => cubit.onFormChange(),
                ),
              ),
              const SizedBox(height: 32),
              FadeInLeft(
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1250),
                child: DefaultFormField(
                  obscureText: true,
                  controller: cubit.newPasswordController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "New Password can't be empty";
                    }
                    if (!text.isPasswordHardWithspace()) {
                      return "Password must be strong";
                    }
                    return null;
                  },
                  label: "New Password",
                  onChanged: (_) => cubit.onFormChange(),
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                duration: const Duration(seconds: 1),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return DefaultButton(
                      enableButton: cubit.enableSaveButton,
                      label: "Save",
                      onTap: cubit.updateProfile,
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              FadeInUp(
                child: Bounceable(
                  onTap: () {
                    HelperMethods.showDialogConfirm(
                      context: context,
                      title: "Delete Account",
                      message:
                          "We are sad to see you go. Do you want to delete your account?",
                      confirmText: "Delete",
                      onTapConfirm: () {
                        context.goBack();
                        cubit.deleteProfile();
                      },
                    );
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    title: Text("Delete Account",
                        style: AppFontStyles.readexPro400_16),
                    leading: const Icon(
                      EneftyIcons.profile_remove_bold,
                      color: Colors.red,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ).setHorizontalPadding();
        }

        return const SizedBox.shrink();
      },
      listener: (BuildContext context, ProfileState state) {
        if (state is UpdateProfileFailureState) {
          HelperMethods.showErrorNotificationToast(state.error);
          context.goBack();
        }
        if (state is DeleteProfileFailureState) {
          HelperMethods.showErrorNotificationToast(state.error);
          context.goBack();
        }

        if (state is DeleteProfileLoadingState) {
          HelperMethods.showLoadingDliaog(context);
        }

        if (state is UpdateProfileLoadingState) {
          HelperMethods.showLoadingDliaog(context);
        }

        if (state is UpdateProfileSuccessState) {
          HelperMethods.showSuccessNotificationToast(
            "Profile updated successfully",
          );
          context.goBack();
          context.goBack();
        }

        if (state is DeleteProfileSuccessState) {
          context.read<MainCubit>().logout().then((value) {
            HelperMethods.showSuccessNotificationToast(
              "Profile deleted successfully",
            );
            // ignore: use_build_context_synchronously
            context.removeAllAndPush(RoutesName.splash);
          });
        }
      },
    );
  }
}
