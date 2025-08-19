// user.dart
import 'role.dart';

class User {
  int? userId;
  String name;
  String email;
  String? password;
  String phoneNumber;
  String address;
  Role role;
  DateTime? createdAt;

  User({
    this.userId,
    required this.name,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.address,
    required this.role,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      role: Role.fromJson(json['role']),
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'role': role.toJson(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
