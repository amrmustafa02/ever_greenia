import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:enefty_icons/enefty_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:lottie/lottie.dart';
import 'package:plants_app/core/cubit/main_cubit/main_cubit.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';
import 'package:plants_app/core/utils/herlper_methods.dart';

import '../../../../core/routing/app_router.dart';
import '../../../auth/presentation/pages/login_page.dart';

class DrawerBody extends StatelessWidget {
  final AdvancedDrawerController advancedDrawerController;

  const DrawerBody({super.key, required this.advancedDrawerController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgColor.withOpacity(0.5),
      ),
      child: SafeArea(
        child: Column(
          children: [
            if (context.read<MainCubit>().isUserLogged) ...[
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(
                  EneftyIcons.profile_2user_bold,
                  color: AppColors.darkGreen,
                ),
                title: Text(
                  'My Profile',
                  style: AppFontStyles.readexPro400_16,
                ),
                onTap: () async {
                  context.goToNamed(RoutesName.profile);
                  advancedDrawerController.hideDrawer();
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(
                  EneftyIcons.shopping_cart_bold,
                  color: AppColors.darkGreen,
                ),
                title: Text(
                  'My Orders',
                  style: AppFontStyles.readexPro400_16,
                ),
                onTap: () async {
                  context.goToNamed(RoutesName.orders);
                  advancedDrawerController.hideDrawer();
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Bounceable(
                  onTap: () {
                    context.goToNamed(RoutesName.bot);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Hero(
                        tag: "bot",
                        child: Lottie.asset("assets/lottie/bot2.json"),
                      ),
                      const SizedBox(height: 16),
                      AnimatedTextKit(
                        // key: UniqueKey(),
                        pause: const Duration(milliseconds: 200),
                        repeatForever: true,
                        animatedTexts: [
                          ColorizeAnimatedText(
                            "Try Flora Bot!",
                            textStyle: AppFontStyles.readexPro400_16,
                            colors: [
                              AppColors.darkGreen,
                              AppColors.bgColor,
                              AppColors.darkGreen,
                            ],
                            speed: const Duration(milliseconds: 300),
                          ),
                          ColorizeAnimatedText(
                            "Try Flora Bot!",
                            textStyle: AppFontStyles.readexPro400_16,
                            colors: [
                              AppColors.darkGreen,
                              AppColors.bgColor,
                              AppColors.darkGreen,
                            ],
                            speed: const Duration(milliseconds: 300),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  EneftyIcons.logout_bold,
                  color: Colors.red,
                ),
                title: Text(
                  'Logout',
                  style: AppFontStyles.readexPro400_16,
                ),
                onTap: () async {
                  HelperMethods.showDialogConfirm(
                    context: context,
                    title: "Logout",
                    message: 'Are you sure you want to logout?',
                    confirmText: "Yes",
                    onTapConfirm: () {
                      context.read<MainCubit>().logout().then(
                        (value) {
                          // ignore: use_build_context_synchronously
                          context.removeAllAndPush(RoutesName.splash);
                        },
                      );
                    },
                  );
                },
              ),
            ],
            if (!context.read<MainCubit>().isUserLogged) ...[
              // const SizedBox(height: 16),
              const Spacer(),
              ListTile(
                leading: const Icon(
                  EneftyIcons.login_bold,
                  color: Colors.blue,
                ),
                title: const Text(
                  'Login',
                ),
                onTap: () {
                  advancedDrawerController.hideDrawer();
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: true,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const LoginPage(
                          showHeader: false,
                          useScaffold: false,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
            ListTile(
              leading: const Icon(
                EneftyIcons.close_circle_bold,
                color: Colors.red,
              ),
              title: Text(
                'Close',
                style: AppFontStyles.readexPro400_16,
              ),
              onTap: () {
                advancedDrawerController.hideDrawer();
              },
            ),
          ],
        ),
      ),
    );
  }
}
