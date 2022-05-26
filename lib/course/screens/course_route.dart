import 'package:flutter/material.dart';

import '../models/course.dart';
import 'course_add_update.dart';
import 'course_detail.dart';
import 'courses_list.dart';

class CourseAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => const CoursesList());
    }

    if (settings.name == AddUpdateCourse.routeName) {
      CourseArgument args = settings.arguments as CourseArgument;
      return MaterialPageRoute(
        builder: (context) => AddUpdateCourse(
          args: args,
        ),
      );
    }

    if (settings.name == CourseDetail.routeName) {
      Course course = settings.arguments as Course;
      return MaterialPageRoute(
        builder: (context) => CourseDetail(
          course: course,
        ),
      );
    }

    return MaterialPageRoute(builder: (context) => const CoursesList());
  }
}

class CourseArgument {
  final Course? course;
  final bool edit;
  CourseArgument({this.course, required this.edit});
}
