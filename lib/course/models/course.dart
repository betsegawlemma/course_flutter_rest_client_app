class Course {
  final int? id;
  final String code;
  final String title;
  final int ects;
  final String? description;

  Course(
      {required this.id,
      required this.code,
      required this.title,
      required this.ects,
      this.description});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
        id: json['id'],
        code: json['code'],
        title: json['title'],
        ects: json['ects'],
        description: json['description']);
  }
}
