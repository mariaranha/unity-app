import 'package:unity_app/features/classes/domain/class_entity.dart';
import 'package:unity_app/features/classes/domain/classes_repository.dart';

class GetClassesUseCase {
  final ClassesRepository repository;

  GetClassesUseCase(this.repository);

  Future<List<ClassEntity>> call() {
    return repository.getClasses();
  }
}
