import 'package:unity_app/features/auth/domain/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);

  Future<String?> getSavedToken();

  Future<void> logout();
}
