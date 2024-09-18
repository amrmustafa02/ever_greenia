import 'package:flutter/material.dart';
import 'package:plants_app/features/home/presentation/pages/home_page.dart';
import 'package:plants_app/features/product_details/presentation/pages/product_details_page.dart';

part 'routes_name.dart';

class AppRouter {
  AppRouter._();

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutesName.productDetails:
        return MaterialPageRoute(builder: (_) => const ProductDetailsPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}
