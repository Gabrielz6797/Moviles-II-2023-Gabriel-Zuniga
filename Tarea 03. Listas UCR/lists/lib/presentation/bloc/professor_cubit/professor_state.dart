part of 'professor_cubit.dart';

class ProfessorState extends Equatable {
  final List<Professor> professors;
  final int id;
  final String firstName;
  final String lastName;
  final List<Course> courses;

  const ProfessorState({
    this.professors = const [],
    this.id = -1,
    this.firstName = '',
    this.lastName = '',
    this.courses = const [],
  });

  ProfessorState copyWith({
    List<Professor>? professors,
    int? id,
    String? firstName,
    String? lastName,
    List<Course>? courses,
  }) =>
      ProfessorState(
        professors: professors ?? this.professors,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        courses: courses ?? this.courses,
      );

  @override
  List<Object> get props => [professors, id, firstName, lastName, courses];
}
