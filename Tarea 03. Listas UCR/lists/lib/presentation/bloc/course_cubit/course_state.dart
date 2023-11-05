part of 'course_cubit.dart';

class CourseState extends Equatable {
  final List<Course> courses;
  final int id;
  final String code;
  final String name;
  final List<Professor?> professor;

  const CourseState({
    this.courses = const [],
    this.id = -1,
    this.code = '',
    this.name = '',
    this.professor = const [],
  });

  CourseState copyWith({
    List<Course>? courses,
    int? id,
    String? code,
    String? name,
    List<Professor?>? professor,
  }) =>
      CourseState(
        courses: courses ?? this.courses,
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        professor: professor ?? this.professor,
      );

  @override
  List<Object> get props => [courses, id, code, name, professor];
}
