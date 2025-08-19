// course_teacher.dart
import 'course.dart';
import 'user.dart';

class CourseTeacher {
  int? courseTeacherId;
  Course course;
  User teacher;

  CourseTeacher({
    this.courseTeacherId,
    required this.course,
    required this.teacher,
  });

  factory CourseTeacher.fromJson(Map<String, dynamic> json) {
    return CourseTeacher(
      courseTeacherId: json['courseTeacherId'],
      course: Course.fromJson(json['course']),
      teacher: User.fromJson(json['teacher']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseTeacherId': courseTeacherId,
      'course': course.toJson(),
      'teacher': teacher.toJson(),
    };
  }
}
