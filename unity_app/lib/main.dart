import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:unity_app/app.dart';
import 'package:unity_app/core/api/api_service.dart';
import 'package:unity_app/features/auth/data/auth_local_datasource_impl.dart';
import 'package:unity_app/features/auth/data/auth_remote_data_source.dart';
import 'package:unity_app/features/auth/data/auth_repository_impl.dart';
import 'package:unity_app/features/auth/domain/login_usecase.dart';
import 'package:unity_app/features/auth/domain/register_usecase.dart';
import 'package:unity_app/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:unity_app/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:unity_app/features/auth/presentation/cubit/user_cubit.dart';
import 'package:unity_app/features/classes/data/classes_remote_data_source.dart';
import 'package:unity_app/features/classes/data/classes_repository_impl.dart';
import 'package:unity_app/features/classes/domain/book_class_usecase.dart';
import 'package:unity_app/features/classes/domain/cancel_class_usecase.dart';
import 'package:unity_app/features/classes/domain/get_classes_usecase.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_bloc.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_event.dart';

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
  final registerUsecase = RegisterUseCase(authRepository);

  // 📚 Classes
  final classesRemoteDatasource = ClassesRemoteDataSource(apiClient);
  final classesRepository = ClassesRepositoryImpl(
    remote: classesRemoteDatasource,
  );
  final getClassesUsecase = GetClassesUseCase(classesRepository);
  final bookClassUsecase = BookClassUseCase(
    classesRepository: classesRepository,
    authRepository: authRepository,
  );
  final cancelClassUsecase = CancelClassUseCase(
    classesRepository: classesRepository,
    authRepository: authRepository,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(authRepository)..add(AuthCheckRequested()),
        ),
        BlocProvider<LoginBloc>(create: (_) => LoginBloc(loginUsecase)),
        BlocProvider<UserCubit>(create: (_) => UserCubit()),
        BlocProvider<ClassesBloc>(
          create: (_) =>
              ClassesBloc(getClassesUsecase)..add(ClassesLoadRequested()),
        ),
      ],
      child: MyApp(
        registerUsecase: registerUsecase,
        bookClassUsecase: bookClassUsecase,
        cancelClassUsecase: cancelClassUsecase,
      ),
    ),
  );
}
