import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/auth/domain/register_usecase.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_state.dart';
import 'package:unity_app/features/auth/presentation/cubit/user_cubit.dart';
import 'package:unity_app/features/auth/presentation/login_page.dart';
import 'package:unity_app/features/classes/domain/book_class_usecase.dart';
import 'package:unity_app/features/classes/domain/cancel_class_usecase.dart';
import 'package:unity_app/features/classes/presentation/classes_page.dart';

class MyApp extends StatelessWidget {
  final RegisterUseCase registerUsecase;
  final BookClassUseCase bookClassUsecase;
  final CancelClassUseCase cancelClassUsecase;

  const MyApp({
    super.key,
    required this.registerUsecase,
    required this.bookClassUsecase,
    required this.cancelClassUsecase,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unity App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.read<UserCubit>().setUser(state.user);
          }
        },
        builder: (context, state) {
          if (state is LoginSuccess) {
            return ClassesPage(
              bookClassUseCase: bookClassUsecase,
              cancelClassUseCase: cancelClassUsecase,
            );
          }

          return LoginPage(registerUseCase: registerUsecase);
        },
      ),
    );
  }
}
