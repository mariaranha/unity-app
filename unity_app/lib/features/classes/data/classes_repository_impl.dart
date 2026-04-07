import 'package:unity_app/features/classes/data/classes_remote_data_source.dart';
import 'package:unity_app/features/classes/domain/class_entity.dart';
import 'package:unity_app/features/classes/domain/classes_repository.dart';

class ClassesRepositoryImpl implements ClassesRepository {
  final ClassesRemoteDataSource remote;

  ClassesRepositoryImpl({required this.remote});

  @override
  Future<List<ClassEntity>> getClasses() {
    return remote.getClasses();
  }
}
