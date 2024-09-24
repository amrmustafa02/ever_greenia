import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/core/theme/app_font_styles.dart';

class ResendCodeSection extends StatefulWidget {
  const ResendCodeSection({super.key});

  @override
  State<ResendCodeSection> createState() => _ResendCodeSectionState();
}

class _ResendCodeSectionState extends State<ResendCodeSection> {
  late Timer timer;
  int curTime = 60;
  bool enabledResend = false;
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  startTime() {
    enabledResend = false;
    curTime = 60;
    setState(() {});
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (curTime == 0) {
        timer.cancel();
        setState(() {
          enabledResend = true;
        });
        return;
      }
      log("curTime: $curTime");
      curTime--;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "00:${curTime < 10 ? "0$curTime" : "$curTime"}",
          style: AppFontStyles.readexPro400_14.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't get code? ",
              style: AppFontStyles.readexPro400_14.copyWith(color: Colors.grey),
            ),
            GestureDetector(
              onTap: enabledResend
                  ? () {
                      startTime();
                    }
                  : null,
              child: Text(
                "Resend code",
                style: AppFontStyles.readexPro400_14.copyWith(
                  color: enabledResend
                      ? AppColors.darkGreen
                      : AppColors.darkGreen.withOpacity(0.5),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
