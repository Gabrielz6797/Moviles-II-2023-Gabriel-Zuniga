import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lists/domain/schemas.dart';
import 'package:lists/presentation/blocs.dart';
import 'package:lists/presentation/widgets.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

class StudentAddModifyScreen extends StatelessWidget {
  final int? id;

  const StudentAddModifyScreen({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StudentCubit(),
        ),
        BlocProvider(
          create: (context) => CourseCubit(),
        ),
      ],
      child: _StudentAddModifyScreen(
        id: id,
      ),
    );
  }
}

class _StudentAddModifyScreen extends StatefulWidget {
  final int? id;

  const _StudentAddModifyScreen({
    this.id,
  });

  @override
  State<_StudentAddModifyScreen> createState() =>
      _StudentAddModifyScreenState();
}

class _StudentAddModifyScreenState extends State<_StudentAddModifyScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      context.read<StudentCubit>().getStudent(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentId = context.watch<StudentCubit>().state.studentId;
    final firstName = context.watch<StudentCubit>().state.firstName;
    final lastName = context.watch<StudentCubit>().state.lastName;

    return Scaffold(
      appBar: AppBar(
        title: (widget.id == null)
            ? const Text('Agregar estudiante')
            : Text('$studentId: $firstName $lastName'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              _StudentFormView(id: widget.id),
            ],
          ),
        ),
      ),
    );
  }
}

class _StudentFormView extends StatefulWidget {
  final int? id;

  const _StudentFormView({
    this.id,
  });

  @override
  State<_StudentFormView> createState() => _StudentFormViewState();
}

class _StudentFormViewState extends State<_StudentFormView> {
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final MultiSelectController _multiSelectController = MultiSelectController();

  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().getCourses();
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _studentIdController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
  }

  String? _validate(String? value) {
    if (value == null) return 'No puede ser vacío';
    if (value.trim().isEmpty) return 'No puede ser vacío';
    if (value.trim().length < 3) return 'Debe tener más de 3 caracteres';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final studentCubit = context.watch<StudentCubit>();
    final List<Course> courses = context.watch<CourseCubit>().state.courses;
    final List<ValueItem> coursesEntries = <ValueItem>[];
    List<Course> selectedCourses = [];

    for (int index = 0; index < courses.length; index++) {
      coursesEntries.add(
        ValueItem(
          value: index.toString(),
          label: '${courses[index].code}: ${courses[index].name}',
        ),
      );
    }

    if (widget.id != null) {
      String studentId = context.read<StudentCubit>().state.studentId;
      String firstName = context.read<StudentCubit>().state.firstName;
      String lastName = context.read<StudentCubit>().state.lastName;
      String email = context.read<StudentCubit>().state.email;
      _studentIdController.text = studentId;
      _firstNameController.text = firstName;
      _lastNameController.text = lastName;
      _emailController.text = email;
    }

    void selectCourse(List<ValueItem> selectedOptions) {
      selectedCourses = [];
      for (int index = 0; index < selectedOptions.length; index++) {
        selectedCourses.add(courses[int.parse(selectedOptions[index].value!)]);
      }
    }

    return Form(
      key: _keyForm,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _studentIdController,
            label: 'Carnet',
            hintText: 'Agregue el carnet',
            icon: Icons.card_travel,
            validator: _validate,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Z0-9]')),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
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
          CustomTextFormField(
            controller: _emailController,
            label: 'Correo',
            hintText: 'Agregue el correo',
            icon: Icons.mail,
            validator: _validate,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-z0-9\\@\\.]')),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          MultiSelectDropDown(
            controller: _multiSelectController,
            onOptionSelected: (List<ValueItem> selectedOptions) {
              selectCourse(selectedOptions);
            },
            options: coursesEntries,
            selectionType: SelectionType.multi,
            chipConfig: const ChipConfig(wrapType: WrapType.scroll),
            dropdownHeight: 200,
            optionTextStyle: TextStyle(
              fontSize: 15,
              color: colors.onBackground,
            ),
            selectedOptionIcon: const Icon(Icons.check_circle),
            borderRadius: 30,
            borderWidth: 1,
            borderColor: colors.secondaryContainer,
            focusedBorderWidth: 2,
            focusedBorderColor: colors.primaryContainer,
            backgroundColor: colors.background,
            hintColor: colors.onBackground,
            hint: 'Seleccione los cursos',
            optionsBackgroundColor: colors.onSecondary,
            selectedOptionBackgroundColor: colors.primaryContainer,
            selectedOptionTextColor: colors.background,
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
                    Student student = Student()
                      ..studentId = _studentIdController.text
                      ..firstName = _firstNameController.text
                      ..lastName = _lastNameController.text
                      ..email = _emailController.text
                      ..courses.removeAll(courses)
                      ..courses.addAll(selectedCourses);
                    if (widget.id != null) student.id = widget.id;
                    studentCubit.addStudent(student);
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
