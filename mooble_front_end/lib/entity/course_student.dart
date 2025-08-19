// course_student.dart
import 'course.dart';
import 'user.dart';

class CourseStudent {
  int? courseStudentId;
  Course course;
  User student;

  CourseStudent({
    this.courseStudentId,
    required this.course,
    required this.student,
  });

  factory CourseStudent.fromJson(Map<String, dynamic> json) {
    return CourseStudent(
      courseStudentId: json['courseStudentId'],
      course: Course.fromJson(json['course']),
      student: User.fromJson(json['student']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseStudentId': courseStudentId,
      'course': course.toJson(),
      'student': student.toJson(),
    };
  }
}
