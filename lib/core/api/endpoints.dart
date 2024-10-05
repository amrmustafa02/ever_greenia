class Endpoints {
  Endpoints._();

  // auth end points
  static const String _authBaseRoute = "auth";
  static const String login = "$_authBaseRoute/login";
  static const String register = "$_authBaseRoute/register";
  static const String confirmEmail = "$_authBaseRoute/confirmEmail";
  static const String sendPasswordResetEmail = "$_authBaseRoute/restPassword";
  static var resendCode = "auth";

  // app data end points
  static const String getCategories = "category";
  static const String getProducts = "product";

  // cart end points
  static const String cart = "cart/";

  // profile end points
  static const String profile = "user";

  // order end points
  static const String order = "order/";
}
