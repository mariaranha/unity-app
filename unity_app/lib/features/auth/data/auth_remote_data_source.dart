import 'dart:convert';

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

    final data = jsonDecode(response.body);

    return UserModel.fromJson(data['user']);
  }
}
