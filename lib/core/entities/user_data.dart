import 'package:injectable/injectable.dart';

@singleton
class UserData {
  String name = "";
  String email = "";
  String token = "";
  bool isLogin = false;

  void init({String? name, String? email, String? token}) {
    this.name = name ?? "";
    this.email = email ?? "";
    this.token = token ?? "";
    isLogin = name != null && email != null && token != null;
  }
}
