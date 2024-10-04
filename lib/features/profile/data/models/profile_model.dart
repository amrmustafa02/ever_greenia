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
