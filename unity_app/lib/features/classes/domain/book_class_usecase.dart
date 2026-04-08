import 'package:unity_app/features/auth/domain/auth_repository.dart';
import 'package:unity_app/features/classes/domain/classes_repository.dart';

class BookClassUseCase {
  final ClassesRepository classesRepository;
  final AuthRepository authRepository;

  BookClassUseCase({
    required this.classesRepository,
    required this.authRepository,
  });

  Future<String> call(String classId) async {
    final token = await authRepository.getSavedToken();
    final userId = await authRepository.getSavedUserId();

    if (token == null || userId == null) {
      throw Exception('Usuário não autenticado');
    }

    return classesRepository.bookClass(
      classId: classId,
      token: token,
      userId: userId,
    );
  }
}
