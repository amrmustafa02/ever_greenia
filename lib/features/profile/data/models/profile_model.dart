import 'package:plants_app/features/profile/domain/entities/profile_data.dart';

class ProfileModel {
  ProfileModel({
    required this.message,
    required this.data,
  });

  final String? message;
  final Data? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  ProfileData toEntity() {
    return ProfileData(
      name: data?.name ?? "",
      email: data?.email ?? "",
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.confirmEmail,
  });

  final String? id;
  final String? name;
  final String? email;
  final bool? confirmEmail;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["_id"],
      name: json["name"],
      email: json["email"],
      confirmEmail: json["confirmEmail"],
    );
  }
}
