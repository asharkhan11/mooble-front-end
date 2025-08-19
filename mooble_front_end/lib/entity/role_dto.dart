// role_dto.dart
class RoleDto {
  String roleName;

  RoleDto({required this.roleName});

  factory RoleDto.fromJson(Map<String, dynamic> json) {
    return RoleDto(
      roleName: json['roleName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleName': roleName,
    };
  }
}
