import 'package:unity_app/features/classes/domain/class_entity.dart';

abstract class ClassesRepository {
  Future<List<ClassEntity>> getClasses();

  Future<String> bookClass({
    required String classId,
    required String token,
    required String userId,
  });

  Future<String> cancelClass({
    required String classId,
    required String token,
    required String userId,
  });
}
