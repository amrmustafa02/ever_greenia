import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:plants_app/core/extensions/context_extension.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:toastification/toastification.dart';

class HelperMethods {
  static void showLoadingDliaog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 25.w,
          child: Lottie.asset("assets/lottie/plants_loading.json"),
        );
      },
    );
  }

  static void showSuccessNotificationToast(
    String message, {
    int seconds = 2,
  }) {
    _baseNotificationToast(
      message,
      seconds,
      AppColors.darkGreen,
      ToastificationType.success,
    );
  }

  static void showInfoNotificationToast(
    String message, {
    int seconds = 2,
  }) {
    _baseNotificationToast(
      message,
      seconds,
      Colors.blue,
      ToastificationType.info,
    );
  }

  static void showErrorNotificationToast(
    String message, {
    int seconds = 2,
  }) {
    _baseNotificationToast(
      message,
      seconds,
      Colors.red,
      ToastificationType.error,
    );
  }

  static void _baseNotificationToast(
    String message,
    int seconds,
    Color color,
    ToastificationType type,
  ) {
    toastification.show(
      title: Text(
        message,
      ),
      type: type,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topCenter,
      autoCloseDuration: Duration(seconds: seconds),
      backgroundColor: color,
      foregroundColor: Colors.white,
      applyBlurEffect: true,
      borderRadius: BorderRadius.circular(15),
      closeOnClick: true,
      progressBarTheme: ProgressIndicatorThemeData(
        color: color,
        linearTrackColor: Colors.white,
      ),
    );
  }

  static showDialogConfirm({
    required BuildContext context,
    required String title,
    required String message,
    required String confirmText,
    required Function() onTapConfirm,
  }) {
    PanaraConfirmDialog.show(
      context,
      title: title,
      message: message,
      panaraDialogType: PanaraDialogType.custom,
      imagePath: "assets/images/sad_face.png",
      barrierDismissible: true,
      confirmButtonText: confirmText,
      cancelButtonText: 'Cancel',
      onTapConfirm: onTapConfirm,
      color: Colors.red,
      onTapCancel: () {
        context.goBack();
      }, // optional parameter (default is true)
    );
  }
}
