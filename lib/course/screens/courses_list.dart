import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/course_bloc.dart';
import '../blocs/course_state.dart';
import 'course_add_update.dart';
import 'course_detail.dart';
import 'course_route.dart';

class CoursesList extends StatelessWidget {
  static const routeName = '/';

  const CoursesList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Courses'),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (_, state) {
          if (state is CourseOperationFailure) {
            return const Text('Could not do course operation');
          }

          if (state is CourseOperationSuccess) {
            final courses = state.courses;

            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (_, idx) => ListTile(
                title: Text(courses.elementAt(idx).title),
                subtitle: Text(courses.elementAt(idx).code),
                onTap: () => Navigator.of(context).pushNamed(
                    CourseDetail.routeName,
                    arguments: courses.elementAt(idx)),
              ),
            );
          }

          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(
          AddUpdateCourse.routeName,
          arguments: CourseArgument(edit: false),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
