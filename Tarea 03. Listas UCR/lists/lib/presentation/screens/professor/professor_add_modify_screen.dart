import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lists/domain/schemas.dart';
import 'package:lists/presentation/blocs.dart';
import 'package:lists/presentation/widgets.dart';

class ProfessorAddModifyScreen extends StatelessWidget {
  final int? id;

  const ProfessorAddModifyScreen({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfessorCubit(),
        ),
      ],
      child: _ProfessorAddModifyScreen(
        id: id,
      ),
    );
  }
}

class _ProfessorAddModifyScreen extends StatefulWidget {
  final int? id;

  const _ProfessorAddModifyScreen({
    this.id,
  });

  @override
  State<_ProfessorAddModifyScreen> createState() =>
      _ProfessorAddModifyScreenState();
}

class _ProfessorAddModifyScreenState extends State<_ProfessorAddModifyScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      context.read<ProfessorCubit>().getProfessor(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstName = context.watch<ProfessorCubit>().state.firstName;
    final lastName = context.watch<ProfessorCubit>().state.lastName;

    return Scaffold(
      appBar: AppBar(
        title: (widget.id == null)
            ? const Text('Agregar profesor')
            : Text('$firstName $lastName'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              _ProfessorFormView(id: widget.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfessorFormView extends StatefulWidget {
  final int? id;

  const _ProfessorFormView({
    this.id,
  });

  @override
  State<_ProfessorFormView> createState() => _ProfessorFormViewState();
}

class _ProfessorFormViewState extends State<_ProfessorFormView> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _firstNameController.clear();
    _lastNameController.clear();
  }

  String? _validate(String? value) {
    if (value == null) return 'No puede ser vacío';
    if (value.trim().isEmpty) return 'No puede ser vacío';
    if (value.trim().length < 3) return 'Debe tener más de 3 caracteres';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final professorCubit = context.watch<ProfessorCubit>();

    if (widget.id != null) {
      String firstName = context.read<ProfessorCubit>().state.firstName;
      String lastName = context.read<ProfessorCubit>().state.lastName;
      _firstNameController.text = firstName;
      _lastNameController.text = lastName;
    }

    return Form(
      key: _keyForm,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _firstNameController,
            label: 'Nombre',
            hintText: 'Agregue el nombre',
            icon: Icons.person,
            validator: _validate,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            controller: _lastNameController,
            label: 'Apellido',
            hintText: 'Agregue el apellido',
            icon: Icons.person,
            validator: _validate,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  bool isValid = _keyForm.currentState!.validate();
                  if (isValid) {
                    Professor professor = Professor()
                      ..firstName = _firstNameController.text
                      ..lastName = _lastNameController.text;
                    if (widget.id != null) professor.id = widget.id;
                    professorCubit.addProfessor(professor);
                    _clearForm();
                    context.pop();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.save),
                      const SizedBox(
                        width: 10,
                      ),
                      Text((widget.id == null) ? 'Guardar' : 'Modificar')
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
