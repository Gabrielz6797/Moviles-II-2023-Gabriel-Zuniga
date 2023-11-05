import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lists/domain/schemas.dart';
import 'package:lists/presentation/blocs.dart';

class CourseDetailsScreen extends StatelessWidget {
  final int id;

  const CourseDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseCubit(),
        ),
        BlocProvider(
          create: (context) => ProfessorCubit(),
        ),
        BlocProvider(
          create: (context) => StudentCubit(),
        ),
      ],
      child: _CourseDetailsView(
        id: id,
      ),
    );
  }
}

class _CourseDetailsView extends StatefulWidget {
  final int id;

  const _CourseDetailsView({
    required this.id,
  });

  @override
  State<_CourseDetailsView> createState() => _CourseDetailsViewState();
}

class _CourseDetailsViewState extends State<_CourseDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getCourse(widget.id);
    context.read<ProfessorCubit>().getProfessors();
    context.read<StudentCubit>().getStudents();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final String code = context.watch<CourseCubit>().state.code;
    final String name = context.watch<CourseCubit>().state.name;
    final List<Professor> professors =
        context.watch<ProfessorCubit>().state.professors;
    Professor courseProfessor = Professor();
    final List<Student> students = context.watch<StudentCubit>().state.students;
    List<Student> courseStudents = [];

    for (int index = 0; index < professors.length; index++) {
      final courses = professors[index].courses;
      final searchResults = courses
          .where(
            (course) => course.code == code,
          )
          .toList();
      if (searchResults.isNotEmpty) {
        courseProfessor = professors[index];
      }
    }

    for (int index = 0; index < students.length; index++) {
      final courses = students[index].courses;
      final searchResults = courses
          .where(
            (course) => course.code == code,
          )
          .toList();
      if (searchResults.isNotEmpty) {
        courseStudents.add(students[index]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('$code: $name'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  'Detalles del curso',
                  style: TextStyle(
                    fontSize: 22,
                    color: colors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            leading: const Icon(Icons.code_rounded),
            title: const Text('Código'),
            subtitle: Text(code),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: const Text('Nombre'),
            subtitle: Text(name),
          ),
          ListTile(
            leading: const Icon(Icons.school_rounded),
            title: const Text('Profesor'),
            subtitle: Text((courseProfessor.firstName != null &&
                    courseProfessor.lastName != null)
                ? '${courseProfessor.firstName} ${courseProfessor.lastName}'
                : 'Sin profesor asignado'),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  'Lista de estudiantes',
                  style: TextStyle(
                    fontSize: 22,
                    color: colors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: (courseStudents.isNotEmpty)
                ? ListView.builder(
                    itemCount: courseStudents.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.person_rounded),
                      title: Text('${courseStudents[index].studentId}'),
                      subtitle: Text(
                        '${courseStudents[index].firstName} '
                        '${courseStudents[index].lastName}',
                      ),
                    ),
                  )
                : const ListTile(
                    leading: Icon(Icons.person_rounded),
                    title: Text('No hay estudiantes que mostrar'),
                  ),
          ),
        ],
      ),
    );
  }
}
