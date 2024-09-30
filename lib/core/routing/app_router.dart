import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plants_app/core/di/di.dart';
import 'package:plants_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:plants_app/features/auth/presentation/pages/confirm_email_page.dart';
import 'package:plants_app/features/auth/presentation/pages/login_page.dart';
import 'package:plants_app/features/auth/presentation/pages/register_page.dart';
import 'package:plants_app/features/cart/presentation/pages/cart_page.dart';
import 'package:plants_app/core/entities/product_data.dart';
import 'package:plants_app/features/home/presentation/pages/home_page.dart';
import 'package:plants_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:plants_app/features/product_details/presentation/pages/product_details_page.dart';
import 'package:plants_app/features/splash/presentation/pages/splash_page.dart';

part 'routes_name.dart';

class AppRouter {
  AppRouter._();

  static Route generateRoute(RouteSettings settings) {
    log("generateRoute: ${settings.name}");
    switch (settings.name) {
      case RoutesName.home:
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 1250),
        );
      case RoutesName.productDetails:
        var args = settings.arguments as Map;
        var product = args["product"] as ProductData;
        var categoryName = args["categoryName"] as String;
        return PageTransition(
          child: ProductDetailsPage(
            product: product,
            categoryName: categoryName,
          ),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 750),
        );
      case RoutesName.cart:
        return PageTransition(
          child: const CartPage(),
          type: PageTransitionType.bottomToTop,
          duration: const Duration(milliseconds: 750),
        );
      case RoutesName.splash:
        return PageTransition(
          child: const SplashPage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 1000),
        );
      case RoutesName.onboarding:
        return PageTransition(
          child: const OnboardingPage(),
          type: PageTransitionType.scale,
          alignment: Alignment.center,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 500),
        );
      case RoutesName.login:
        return PageTransition(
          child: const LoginPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 750),
        );
      case RoutesName.register:
        return PageTransition(
          child: const RegisterPage(),
          type: PageTransitionType.fade,
          alignment: Alignment.center,
          curve: Curves.linear,
          duration: const Duration(milliseconds: 750),
        );
      case RoutesName.confirmEmail:
        var email = settings.arguments as String;
        return PageTransition(
          child: BlocProvider(
            create: (BuildContext context) =>
                getIt<AuthCubit>()..initEmail(email),
            child: const ConfirmEmailPage(),
          ),
          type: PageTransitionType.rightToLeft,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 500),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Page not found"),
            ),
          ),
        );
    }
  }
}
