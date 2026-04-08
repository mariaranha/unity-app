import 'package:unity_app/core/api/api_service.dart';
import 'package:unity_app/features/auth/data/user_model.dart';

class AuthRemoteDataSource {
  final ApiService client;

  AuthRemoteDataSource(this.client);

  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      '/auth/login',
      body: {'email': email, 'password': password},
    );

    return UserModel.fromJson(response['user']);
  }

  Future<void> register({
    required String name,
    required String email,
    required String username,
    required String password,
    required String birthDate,
  }) async {
    await client.post(
      '/auth/register',
      body: {
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'birth_date': birthDate,
      },
    );
  }
}
