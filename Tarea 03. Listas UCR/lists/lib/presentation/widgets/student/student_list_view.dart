import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lists/presentation/blocs.dart';
import 'package:lists/presentation/widgets.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({super.key});

  @override
  State<StudentListView> createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getStudents();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final students = context.watch<StudentCubit>().state.students;

    return Column(
      children: [
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
          child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              return CustomCard(
                title: '${students[index].studentId}: '
                    '${students[index].firstName} '
                    '${students[index].lastName} ',
                elevation: 2,
                onPressedDelete: () {
                  context
                      .read<StudentCubit>()
                      .deleteStudent(students[index].id!)
                      .then(
                        (value) => Future.delayed(
                          const Duration(milliseconds: 500),
                          () => context.read<StudentCubit>().getStudents(),
                        ),
                      );
                },
                onPressedEdit: () {
                  context.push('/modify-student/${students[index].id}').then(
                        (value) => Future.delayed(
                          const Duration(milliseconds: 500),
                          () => context.read<StudentCubit>().getStudents(),
                        ),
                      );
                },
                onPressedView: () {
                  context.push('/student/${students[index].id}');
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        FilledButton.icon(
          onPressed: () {
            context.push('/add-student').then(
                  (value) => Future.delayed(
                    const Duration(milliseconds: 500),
                    () => context.read<StudentCubit>().getStudents(),
                  ),
                );
          },
          icon: const Icon(Icons.add),
          label: const Text('Agregar estudiante'),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
