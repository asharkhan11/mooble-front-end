// role.dart
class Role {
  int? roleId;
  String roleName;

  Role({this.roleId, required this.roleName});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      roleId: json['roleId'],
      roleName: json['roleName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'roleName': roleName,
    };
  }
}
