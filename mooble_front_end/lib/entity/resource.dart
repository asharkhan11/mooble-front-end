// resource.dart
import 'course.dart';
import 'user.dart';

class Resource {
  int? resourceId;
  Course course;
  User uploadedBy;
  String name;
  String type;
  String url;
  DateTime? uploadedAt;

  Resource({
    this.resourceId,
    required this.course,
    required this.uploadedBy,
    required this.name,
    required this.type,
    required this.url,
    this.uploadedAt,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      resourceId: json['resourceId'],
      course: Course.fromJson(json['course']),
      uploadedBy: User.fromJson(json['uploadedBy']),
      name: json['name'],
      type: json['type'],
      url: json['url'],
      uploadedAt:
          json['uploadedAt'] != null ? DateTime.parse(json['uploadedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'resourceId': resourceId,
      'course': course.toJson(),
      'uploadedBy': uploadedBy.toJson(),
      'name': name,
      'type': type,
      'url': url,
      'uploadedAt': uploadedAt?.toIso8601String(),
    };
  }
}
