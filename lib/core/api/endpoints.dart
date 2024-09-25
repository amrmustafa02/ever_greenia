class Endpoints {
  Endpoints._();
  static const String _authBaseRoute = "auth/";
  static const String login = "$_authBaseRoute/login";
  static const String register = "$_authBaseRoute/register";
  static const String confirmEmail = "$_authBaseRoute/confirmEmail";
  static const String sendPasswordResetEmail = "$_authBaseRoute/restPassword";

  static const String getCategories = "category";
  static const String getProducts = "product";
}
