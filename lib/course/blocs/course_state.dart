import 'package:equatable/equatable.dart';

import '../models/course.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props => [];
}

class CourseLoading extends CourseState {}

class CourseOperationSuccess extends CourseState {
  final Iterable<Course> courses;

  const CourseOperationSuccess([this.courses = const []]);

  @override
  List<Object> get props => [courses];
}

class CourseOperationFailure extends CourseState {
  final Object error;

  const CourseOperationFailure(this.error);
  @override
  List<Object> get props => [error];
}
