import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lists/presentation/blocs.dart';
import 'package:lists/presentation/widgets.dart';

class ProfessorListView extends StatefulWidget {
  const ProfessorListView({super.key});

  @override
  State<ProfessorListView> createState() => _ProfessorListViewState();
}

class _ProfessorListViewState extends State<ProfessorListView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfessorCubit>().getProfessors();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final professors = context.watch<ProfessorCubit>().state.professors;

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
                'Lista de profesores',
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
            itemCount: professors.length,
            itemBuilder: (context, index) {
              return CustomCard(
                title: '${professors[index].firstName} '
                    '${professors[index].lastName} ',
                elevation: 2,
                onPressedDelete: () {
                  context
                      .read<ProfessorCubit>()
                      .deleteProfessor(professors[index].id!)
                      .then(
                        (value) => Future.delayed(
                          const Duration(milliseconds: 500),
                          () => context.read<ProfessorCubit>().getProfessors(),
                        ),
                      );
                },
                onPressedEdit: () {
                  context
                      .push('/modify-professor/${professors[index].id}')
                      .then(
                        (value) => Future.delayed(
                          const Duration(milliseconds: 500),
                          () => context.read<ProfessorCubit>().getProfessors(),
                        ),
                      );
                },
                onPressedView: () {
                  context.push('/professor/${professors[index].id}');
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
            context.push('/add-professor').then(
                  (value) => Future.delayed(
                    const Duration(milliseconds: 500),
                    () => context.read<ProfessorCubit>().getProfessors(),
                  ),
                );
          },
          icon: const Icon(Icons.add),
          label: const Text('Agregar profesor'),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
