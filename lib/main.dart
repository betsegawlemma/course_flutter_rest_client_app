import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course/bloc_observer.dart';
import 'course/blocs/blocs.dart';
import 'course/data_providers/course_data_provider.dart';
import 'course/repository/course_repository.dart';
import 'course/screens/course_route.dart';

void main() {
  final CourseRepository courseRepository =
      CourseRepository(CourseDataProvider());

  BlocOverrides.runZoned(
    () => runApp(
      CourseApp(courseRepository: courseRepository),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class CourseApp extends StatelessWidget {
  final CourseRepository courseRepository;

  const CourseApp({Key? key, required this.courseRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: courseRepository,
      child: BlocProvider(
        create: (context) => CourseBloc(courseRepository: courseRepository)
          ..add(const CourseLoad()),
        child: MaterialApp(
          title: 'Course App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: CourseAppRoute.generateRoute,
        ),
      ),
    );
  }
}
