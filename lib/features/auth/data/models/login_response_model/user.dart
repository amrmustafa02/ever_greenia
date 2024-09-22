import 'package:collection/collection.dart';

class User {
  final String name;
  String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json['name'] as String,
        email: json['email'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! User) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}
