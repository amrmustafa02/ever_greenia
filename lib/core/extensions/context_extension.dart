import 'package:flutter/material.dart';
import 'package:plants_app/core/routing/app_router.dart';
import 'package:plants_app/features/home/domain/entities/product_data.dart';

extension ContextExtension on BuildContext {
  // theme
  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  void goBack() => Navigator.of(this).pop();

  void goToNamed(String route, {Object? arguments}) =>
      Navigator.of(this).pushNamed(
        route,
        arguments: arguments,
      );

  void goToProductDetails({
    required ProductData product,
    required String categoryName,
  }) {
    goToNamed(
      RoutesName.productDetails,
      arguments: {
        "product": product,
        "categoryName": categoryName,
      },
    );
  }

  void goToNamedReplace(String route, {Object? arguments}) =>
      Navigator.of(this).pushReplacementNamed(
        route,
        arguments: arguments,
      );

  void goBackUntil(String untilRoute) => Navigator.of(this).popUntil(
        (route) => route.settings.name == untilRoute,
      );

  void goBackUntilAndPush(
    String pushRoute,
    String untilRoute, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushNamedAndRemoveUntil(
        pushRoute,
        (route) => route.settings.name == untilRoute,
        arguments: arguments,
      );

  void removeAllAndPush(
    String pushRoute, {
    Object? arguments,
  }) =>
      Navigator.of(this).pushNamedAndRemoveUntil(
        pushRoute,
        (route) => false,
        arguments: arguments,
      );
}
