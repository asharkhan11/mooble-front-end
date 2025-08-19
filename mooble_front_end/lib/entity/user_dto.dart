// user_dto.dart
class UserDto {
  String name;
  String email;
  String phoneNumber;
  String address;
  int roleId; // Long in Java → int in Dart (can use BigInt if needed)

  UserDto({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.roleId,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      roleId: json['roleId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'roleId': roleId,
    };
  }
}
