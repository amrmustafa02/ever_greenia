import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:plants_app/features/cart/presentation/pages/cart_page.dart';
import 'package:plants_app/features/home/presentation/pages/home_page.dart';
import 'package:plants_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:plants_app/features/product_details/presentation/pages/product_details_page.dart';
import 'package:plants_app/features/splash/presentation/pages/splash_page.dart';

part 'routes_name.dart';

class AppRouter {
  AppRouter._();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return PageTransition(
          child: const HomePage(),
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 1250),
        );
      case RoutesName.productDetails:
        final args = settings.arguments as int;
        return PageTransition(
          child: ProductDetailsPage(index: args),
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
          type: PageTransitionType.fade,
          duration: const Duration(milliseconds: 1000),
        );
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
