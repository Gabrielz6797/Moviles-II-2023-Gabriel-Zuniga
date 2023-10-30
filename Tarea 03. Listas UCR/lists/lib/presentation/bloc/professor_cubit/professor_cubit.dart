import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lists/domain/schemas.dart';
import 'package:lists/infrastructure/database/isar_service.dart';

part 'professor_state.dart';

class ProfessorCubit extends Cubit<ProfessorState> {
  final isarService = IsarService();

  ProfessorCubit() : super(const ProfessorState());

  Future<void> addProfessor(Professor professor) async {
    isarService.addProfessor(professor);
  }

  Future<void> getProfessors() async {
    List<Professor> professors = await isarService.getProfessors();
    emit(state.copyWith(professors: professors));
  }

  Future<void> getProfessor(int id) async {
    Professor? professor = await isarService.getProfessor(id);
    if (professor == null) return;
    emit(
      state.copyWith(
        id: professor.id,
        firstName: professor.firstName,
        lastName: professor.lastName,
        courses: professor.courses.toList(),
      ),
    );
  }

  Future<void> deleteProfessor(int id) async {
    isarService.deleteProfessor(id);
  }
}
