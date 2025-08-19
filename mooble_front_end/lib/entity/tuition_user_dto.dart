// tuition_user_dto.dart
import 'user_dto.dart';

class TuitionUserDto {
  int tuitionId;
  UserDto user;

  TuitionUserDto({
    required this.tuitionId,
    required this.user,
  });

  factory TuitionUserDto.fromJson(Map<String, dynamic> json) {
    return TuitionUserDto(
      tuitionId: json['tuitionId'],
      user: UserDto.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tuitionId': tuitionId,
      'user': user.toJson(),
    };
  }
}
