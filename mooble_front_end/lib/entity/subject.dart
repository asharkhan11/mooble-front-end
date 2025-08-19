// subject.dart
import 'tuition.dart';

class Subject {
  int? subjectId;
  Tuition tuition;
  String name;

  Subject({
    this.subjectId,
    required this.tuition,
    required this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subjectId'],
      tuition: Tuition.fromJson(json['tuition']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'tuition': tuition.toJson(),
      'name': name,
    };
  }
}
