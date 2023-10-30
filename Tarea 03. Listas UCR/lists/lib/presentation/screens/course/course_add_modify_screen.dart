import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lists/domain/schemas.dart';
import 'package:lists/presentation/blocs.dart';
import 'package:lists/presentation/widgets.dart';

class CourseAddModifyScreen extends StatelessWidget {
  final int? id;

  const CourseAddModifyScreen({
    super.key,
    this.id,
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
      ],
      child: _CourseAddModifyScreen(
        id: id,
      ),
    );
  }
}

class _CourseAddModifyScreen extends StatefulWidget {
  final int? id;

  const _CourseAddModifyScreen({
    this.id,
  });

  @override
  State<_CourseAddModifyScreen> createState() => _CourseAddModifyScreenState();
}

class _CourseAddModifyScreenState extends State<_CourseAddModifyScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      context.read<CourseCubit>().getCourse(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final code = context.watch<CourseCubit>().state.code;
    final name = context.watch<CourseCubit>().state.name;

    return Scaffold(
      appBar: AppBar(
        title: (widget.id == null)
            ? const Text('Agregar curso')
            : Text('$code $name'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              _CourseFormView(id: widget.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _CourseFormView extends StatefulWidget {
  final int? id;

  const _CourseFormView({
    this.id,
  });

  @override
  State<_CourseFormView> createState() => _CourseFormViewState();
}

class _CourseFormViewState extends State<_CourseFormView> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  final _professorController = TextEditingController();

  int? professorSelected;

  @override
  void initState() {
    super.initState();
    context.read<ProfessorCubit>().getProfessors();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _professorController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _codeController.clear();
    _nameController.clear();
    _professorController.clear();
  }

  String? _validateCode(String? value) {
    if (value == null) return 'No puede ser vacío';
    if (value.trim().isEmpty) return 'No puede ser vacío';
    if (value.trim().length != 7) return 'Debe tener 7 caracteres';
    return null;
  }

  String? _validateName(String? value) {
    if (value == null) return 'No puede ser vacío';
    if (value.trim().isEmpty) return 'No puede ser vacío';
    if (value.trim().length < 3) return 'Debe tener más de 3 caracteres';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final courseCubit = context.watch<CourseCubit>();
    final colors = Theme.of(context).colorScheme;
    final List<Professor> professors =
        context.watch<ProfessorCubit>().state.professors;
    final List<DropdownMenuEntry<int>> professorEntries =
        <DropdownMenuEntry<int>>[];

    for (int index = 0; index < professors.length; index++) {
      professorEntries.add(
        DropdownMenuEntry<int>(
          value: index,
          label: '${professors[index].firstName} ${professors[index].lastName}',
        ),
      );
    }

    if (widget.id != null) {
      String code = context.read<CourseCubit>().state.code;
      String name = context.read<CourseCubit>().state.name;
      _codeController.text = code;
      _nameController.text = name;
    }

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(30),
      borderSide: BorderSide(
        color: colors.secondaryContainer,
      ),
    );

    return Form(
      key: _keyForm,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _codeController,
            label: 'Código',
            hintText: 'Agregue el código',
            icon: Icons.code_rounded,
            validator: _validateCode,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9\\-\\s]')),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFormField(
            controller: _nameController,
            label: 'Nombre',
            hintText: 'Agregue el nombre',
            icon: Icons.calendar_today_rounded,
            validator: _validateName,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9\\-\\s]')),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: DropdownMenu<int>(
                  controller: _professorController,
                  dropdownMenuEntries: professorEntries,
                  inputDecorationTheme: InputDecorationTheme(
                    isDense: true,
                    enabledBorder: border,
                    focusedBorder: border.copyWith(
                      borderSide: BorderSide(
                        color: colors.primaryContainer,
                        width: 2,
                      ),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width - 30,
                  leadingIcon: const Icon(Icons.school_rounded),
                  label: const Text('Profesor'),
                  onSelected: (value) {
                    setState(() {
                      professorSelected = value;
                    });
                  },
                ),
              ),
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
                    Course course = Course()
                      ..code = _codeController.text
                      ..name = _nameController.text
                      ..professor.value = professors[professorSelected!];
                    if (widget.id != null) course.id = widget.id;
                    courseCubit.addCourse(course);
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
