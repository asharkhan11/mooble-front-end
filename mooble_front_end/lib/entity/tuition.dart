// tuition.dart
import 'user.dart';
import 'course.dart';
import 'subject.dart';

class Tuition {
  int? tuitionId;
  String name;
  String address;
  String contactNumber;
  String? email;
  User admin;
  List<Course>? courses;
  List<Subject>? subjects;

  Tuition({
    this.tuitionId,
    required this.name,
    required this.address,
    required this.contactNumber,
    this.email,
    required this.admin,
    this.courses,
    this.subjects,
  });

  factory Tuition.fromJson(Map<String, dynamic> json) {
    return Tuition(
      tuitionId: json['tuitionId'],
      name: json['name'],
      address: json['address'],
      contactNumber: json['contactNumber'],
      email: json['email'],
      admin: User.fromJson(json['admin']),
      courses: json['courses'] != null
          ? (json['courses'] as List)
              .map((e) => Course.fromJson(e))
              .toList()
          : null,
      subjects: json['subjects'] != null
          ? (json['subjects'] as List)
              .map((e) => Subject.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tuitionId': tuitionId,
      'name': name,
      'address': address,
      'contactNumber': contactNumber,
      'email': email,
      'admin': admin.toJson(),
      'courses': courses?.map((e) => e.toJson()).toList(),
      'subjects': subjects?.map((e) => e.toJson()).toList(),
    };
  }
}
