// tuition_user.dart
import 'tuition.dart';
import 'user.dart';

class TuitionUser {
  int? tuitionUserId;
  Tuition tuition;
  User user;
  DateTime? joinedAt;

  TuitionUser({
    this.tuitionUserId,
    required this.tuition,
    required this.user,
    this.joinedAt,
  });

  factory TuitionUser.fromJson(Map<String, dynamic> json) {
    return TuitionUser(
      tuitionUserId: json['tuitionUserId'],
      tuition: Tuition.fromJson(json['tuition']),
      user: User.fromJson(json['user']),
      joinedAt:
          json['joinedAt'] != null ? DateTime.parse(json['joinedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tuitionUserId': tuitionUserId,
      'tuition': tuition.toJson(),
      'user': user.toJson(),
      'joinedAt': joinedAt?.toIso8601String(),
    };
  }
}
