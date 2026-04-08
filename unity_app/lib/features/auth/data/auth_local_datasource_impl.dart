import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unity_app/features/auth/data/auth_local_data_source.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage storage;

  AuthLocalDataSourceImpl(this.storage);

  @override
  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  @override
  Future<void> clearToken() async {
    await storage.delete(key: 'token');
  }

  @override
  Future<void> saveUserId(String userId) async {
    await storage.write(key: 'user_id', value: userId);
  }

  @override
  Future<String?> getUserId() async {
    return await storage.read(key: 'user_id');
  }
}
