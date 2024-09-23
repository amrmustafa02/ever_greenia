import 'package:injectable/injectable.dart';

@singleton
class UserData {
  String? name;
  String? email;
  String? token;

  void init({
    String? name,
    String? email,
    String? token,
  }) {
    this.name = name;
    this.email = email;
    this.token = token;
  }
}
