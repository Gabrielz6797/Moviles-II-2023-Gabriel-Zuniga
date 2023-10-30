import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lists/domain/schemas.dart';
import 'package:lists/infrastructure/database/isar_service.dart';

part 'student_state.dart';

class StudentCubit extends Cubit<StudentState> {
  final isarService = IsarService();

  StudentCubit() : super(const StudentState());

  Future<void> addStudent(Student student) async {
    isarService.addStudent(student);
  }

  Future<void> getStudents() async {
    List<Student> students = await isarService.getStudents();
    emit(state.copyWith(students: students));
  }

  Future<void> getStudent(int id) async {
    Student? student = await isarService.getStudent(id);
    if (student == null) return;
    emit(
      state.copyWith(
        id: student.id,
        studentId: student.studentId,
        firstName: student.firstName,
        lastName: student.lastName,
        email: student.email,
        courses: student.courses.toList(),
      ),
    );
  }

  Future<void> deleteStudent(int id) async {
    isarService.deleteStudent(id);
  }
}
