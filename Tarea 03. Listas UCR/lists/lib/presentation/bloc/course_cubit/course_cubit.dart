import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lists/domain/schemas.dart';
import 'package:lists/infrastructure/database/isar_service.dart';

part 'course_state.dart';

class CourseCubit extends Cubit<CourseState> {
  final isarService = IsarService();

  CourseCubit() : super(const CourseState());

  Future<void> addCourse(Course course) async {
    isarService.addCourse(course);
  }

  Future<void> getCourses() async {
    List<Course> courses = await isarService.getCourses();
    emit(state.copyWith(courses: courses));
  }

  Future<void> getCourse(int id) async {
    Course? course = await isarService.getCourse(id);
    if (course == null) return;
    emit(
      state.copyWith(
        id: course.id,
        code: course.code,
        name: course.name,
        professor: course.professor.toList(),
      ),
    );
  }

  Future<void> deleteCourse(int id) async {
    isarService.deleteCourse(id);
  }
}
