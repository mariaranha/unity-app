import 'package:unity_app/features/auth/domain/auth_repository.dart';
import 'package:unity_app/features/auth/domain/user.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}
