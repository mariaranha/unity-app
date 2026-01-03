import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unity_app/app.dart';
import 'package:unity_app/core/api/api_service.dart';
import 'package:unity_app/features/auth/data/auth_local_datasource_impl.dart';
import 'package:unity_app/features/auth/data/auth_remote_data_source.dart';
import 'package:unity_app/features/auth/data/auth_repository_impl.dart';
import 'package:unity_app/features/auth/domain/login_usecase.dart';
import 'package:unity_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:unity_app/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔌 Core
  final apiClient = ApiService();

  // 🔐 Auth
  final authRemoteDatasource = AuthRemoteDataSource(apiClient);
  final authLocalDatasource = AuthLocalDataSourceImpl(
    const FlutterSecureStorage(),
  );
  final authRepository = AuthRepositoryImpl(
    remote: authRemoteDatasource,
    local: authLocalDatasource,
  );

  final loginUsecase = LoginUseCase(authRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository)..add(AuthCheckRequested()),
        ),
        BlocProvider<LoginBloc>(create: (_) => LoginBloc(loginUsecase)),
      ],
      child: const MyApp(),
    ),
  );
}
