import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/course_bloc.dart';
import '../blocs/course_event.dart';
import '../models/course.dart';
import 'course_route.dart';
import 'courses_list.dart';

class AddUpdateCourse extends StatefulWidget {
  static const routeName = 'courseAddUpdate';
  final CourseArgument args;

  const AddUpdateCourse({Key? key, required this.args}) : super(key: key);

  @override
  _AddUpdateCourseState createState() => _AddUpdateCourseState();
}

class _AddUpdateCourseState extends State<AddUpdateCourse> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _course = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit ? "Edit Course" : "Add New Course"}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.course?.code : '',
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter course code';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Course Code'),
                  onSaved: (value) {
                    setState(() {
                      _course["code"] = value;
                    });
                  }),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.course?.title : '',
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter course title';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Course Title'),
                  onSaved: (value) {
                    _course["title"] = value;
                  }),
              TextFormField(
                  initialValue: widget.args.edit
                      ? widget.args.course?.ects.toString()
                      : '',
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter course ects';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Course ECTS'),
                  onSaved: (value) {
                    setState(() {
                      if (value != null) {
                        _course["ects"] = int.parse(value);
                      }
                    });
                  }),
              TextFormField(
                  initialValue:
                      widget.args.edit ? widget.args.course?.description : '',
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please enter course description';
                    }
                    return null;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Course Description'),
                  onSaved: (value) {
                    setState(() {
                      _course["description"] = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form != null && form.validate()) {
                      form.save();
                      final CourseEvent event = widget.args.edit
                          ? CourseUpdate(
                              widget.args.course?.id ?? 0,
                              Course(
                                id: widget.args.course?.id,
                                code: _course["code"],
                                title: _course["title"],
                                ects: _course["ects"],
                                description: _course["description"],
                              ),
                            )
                          : CourseCreate(
                              Course(
                                id: null,
                                code: _course["code"],
                                title: _course["title"],
                                ects: _course["ects"],
                                description: _course["description"],
                              ),
                            );
                      BlocProvider.of<CourseBloc>(context).add(event);
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          CoursesList.routeName, (route) => false);
                    }
                  },
                  label: const Text('SAVE'),
                  icon: const Icon(Icons.save),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
