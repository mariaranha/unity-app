import 'package:unity_app/features/classes/domain/class_entity.dart';

abstract class ClassesRepository {
  Future<List<ClassEntity>> getClasses();
}
