import 'package:isar/isar.dart';
import 'professor.dart';
import 'student.dart';

part 'course.g.dart';

@collection
class Course {
  Id? id = Isar.autoIncrement;

  @Index(unique: true)
  String? code;

  String? name;

  final professor = IsarLink<Professor>();

  @Backlink(to: 'courses')
  final students = IsarLinks<Student>();
}
