part of 'student_cubit.dart';

class StudentState extends Equatable {
  final List<Student> students;
  final int id;
  final String studentId;
  final String firstName;
  final String lastName;
  final String email;
  final List<Course> courses;

  const StudentState({
    this.students = const [],
    this.id = -1,
    this.studentId = '',
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.courses = const [],
  });

  StudentState copyWith({
    List<Student>? students,
    int? id,
    String? studentId,
    String? firstName,
    String? lastName,
    String? email,
    List<Course>? courses,
  }) =>
      StudentState(
        students: students ?? this.students,
        id: id ?? this.id,
        studentId: studentId ?? this.studentId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        courses: courses ?? this.courses,
      );

  @override
  List<Object> get props =>
      [students, id, studentId, firstName, lastName, email, courses];
}
