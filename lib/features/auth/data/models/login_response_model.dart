import 'user_model.dart';

class LoginResponseModel {
  User? user;
  String? token;

  LoginResponseModel({this.user, this.token});

  factory LoginResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return LoginResponseModel(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );
  }
}
