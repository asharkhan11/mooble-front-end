// course.dart
import 'tuition.dart';
import 'standard.dart';
import 'resource.dart';

class Course {
  int? courseId;
  Tuition tuition;
  Standard standard;
  String? courseName;
  String? courseDuration;
  List<Resource>? resources;

  Course({
    this.courseId,
    required this.tuition,
    required this.standard,
    this.courseName,
    this.courseDuration,
    this.resources,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: json['courseId'],
      tuition: Tuition.fromJson(json['tuition']),
      standard: Standard.fromJson(json['standard']),
      courseName: json['courseName'],
      courseDuration: json['courseDuration'],
      resources: json['resources'] != null
          ? (json['resources'] as List)
              .map((e) => Resource.fromJson(e))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseId': courseId,
      'tuition': tuition.toJson(),
      'standard': standard.toJson(),
      'courseName': courseName,
      'courseDuration': courseDuration,
      'resources': resources?.map((e) => e.toJson()).toList(),
    };
  }
}
