import 'package:unity_app/features/auth/domain/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);

  Future<void> register({
    required String name,
    required String email,
    required String username,
    required String password,
    required String birthDate,
  });

  Future<String?> getSavedToken();
  Future<String?> getSavedUserId();

  Future<void> logout();
}
