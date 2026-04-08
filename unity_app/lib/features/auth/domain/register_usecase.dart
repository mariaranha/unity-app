import 'package:unity_app/features/auth/domain/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<void> call({
    required String name,
    required String email,
    required String username,
    required String password,
    required String birthDate,
  }) {
    return repository.register(
      name: name,
      email: email,
      username: username,
      password: password,
      birthDate: birthDate,
    );
  }
}
