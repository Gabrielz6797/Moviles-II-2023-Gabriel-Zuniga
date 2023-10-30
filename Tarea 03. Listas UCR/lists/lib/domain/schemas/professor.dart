import 'package:isar/isar.dart';
import 'course.dart';

part 'professor.g.dart';

@collection
class Professor {
  Id? id = Isar.autoIncrement;

  String? firstName;
  String? lastName;

  @Backlink(to: 'professor')
  final courses = IsarLinks<Course>();
}
