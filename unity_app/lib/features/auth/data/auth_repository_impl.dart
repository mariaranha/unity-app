import 'package:unity_app/features/auth/data/auth_local_data_source.dart';
import 'package:unity_app/features/auth/data/auth_remote_data_source.dart';
import 'package:unity_app/features/auth/domain/auth_repository.dart';
import 'package:unity_app/features/auth/domain/user.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<User> login(String email, String password) async {
    final token = await remote.login(email, password);
    await local.saveToken('token');
    return token;
  }

  @override
  Future<String?> getSavedToken() async {
    return local.getToken();
  }

  @override
  Future<void> logout() async {
    await local.clearToken();
  }
}
