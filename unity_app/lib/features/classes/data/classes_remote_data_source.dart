import 'package:unity_app/core/api/api_service.dart';
import 'package:unity_app/features/classes/data/class_model.dart';

class ClassesRemoteDataSource {
  final ApiService client;

  ClassesRemoteDataSource(this.client);

  Future<List<ClassModel>> getClasses() async {
    final response = await client.get('/classes');

    final list = response as List<dynamic>;
    return list.map((e) => ClassModel.fromJson(e)).toList();
  }
}
