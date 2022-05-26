import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/course_bloc.dart';
import '../blocs/course_event.dart';
import '../models/course.dart';
import 'course_add_update.dart';
import 'course_route.dart';
import 'courses_list.dart';

class CourseDetail extends StatelessWidget {
  static const routeName = 'courseDetail';
  final Course course;

  const CourseDetail({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.code),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddUpdateCourse.routeName,
              arguments: CourseArgument(course: course, edit: true),
            ),
          ),
          const SizedBox(
            width: 32,
          ),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                BlocProvider.of<CourseBloc>(context)
                    .add(CourseDelete(course.id ?? 0));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    CoursesList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Title: ${course.title}'),
              subtitle: Text('ECTS: ${course.ects}'),
            ),
            const Text(
              'Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(course.description ?? ""),
          ],
        ),
      ),
    );
  }
}
