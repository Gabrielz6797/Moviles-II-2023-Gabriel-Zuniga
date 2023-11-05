import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lists/domain/schemas.dart';
import 'package:lists/presentation/blocs.dart';

class StudentDetailsScreen extends StatelessWidget {
  final int id;

  const StudentDetailsScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return _StudentDetailsView(
      id: id,
    );
  }
}

class _StudentDetailsView extends StatefulWidget {
  final int id;

  const _StudentDetailsView({
    required this.id,
  });

  @override
  State<_StudentDetailsView> createState() => _StudentDetailsViewState();
}

class _StudentDetailsViewState extends State<_StudentDetailsView> {
  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getStudent(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final String studentId = context.watch<StudentCubit>().state.studentId;
    final String firstName = context.watch<StudentCubit>().state.firstName;
    final String lastName = context.watch<StudentCubit>().state.lastName;
    final String email = context.watch<StudentCubit>().state.email;
    final List<Course> courses = context.watch<StudentCubit>().state.courses;

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles sobre $studentId: $firstName $lastName'),
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
                  'Datos personales',
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
            leading: const Icon(Icons.card_travel_rounded),
            title: const Text('Carnet'),
            subtitle: Text(studentId),
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Nombre'),
            subtitle: Text(firstName),
          ),
          ListTile(
            leading: const Icon(Icons.person_rounded),
            title: const Text('Apellido'),
            subtitle: Text(lastName),
          ),
          ListTile(
            leading: const Icon(Icons.mail_rounded),
            title: const Text('Correo'),
            subtitle: Text(email),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  'Lista de cursos',
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
            child: (courses.isNotEmpty)
                ? ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.calendar_today_rounded),
                      title: Text('${courses[index].name}'),
                      subtitle: Text('${courses[index].code}'),
                    ),
                  )
                : const ListTile(
                    leading: Icon(Icons.calendar_today_rounded),
                    title: Text('No hay cursos que mostrar'),
                  ),
          ),
        ],
      ),
    );
  }
}
