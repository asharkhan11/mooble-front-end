// tuition_dto.dart
class TuitionDto {
  String name;
  String address;
  String contactNumber;
  String email;
  int adminId;

  TuitionDto({
    required this.name,
    required this.address,
    required this.contactNumber,
    required this.email,
    required this.adminId,
  });

  factory TuitionDto.fromJson(Map<String, dynamic> json) {
    return TuitionDto(
      name: json['name'],
      address: json['address'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      adminId: json['adminId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'contactNumber': contactNumber,
      'email': email,
      'adminId': adminId,
    };
  }
}
