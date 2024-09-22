import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginHeader extends StatefulWidget {
  const LoginHeader({
    super.key,
  });

  @override
  State<LoginHeader> createState() => _LoginHeaderState();
}

class _LoginHeaderState extends State<LoginHeader> {
  late Image headerImage;
  @override
  void initState() {
    super.initState();
    headerImage = Image.asset(
      "assets/images/logo_bg_header_two.png",
      width: 100.w,
      height: 35.h,
      fit: BoxFit.fill,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(headerImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 35.h,
      child: Stack(
        children: [
          headerImage,
          FadeInRight(
            duration: const Duration(milliseconds: 1500),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Transform.rotate(
                angle: 45,
                child: Image.asset(
                  "assets/images/login_bg_plant.png",
                  width: 20.w,
                  height: 15.h,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
