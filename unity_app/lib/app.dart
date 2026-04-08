import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/auth/domain/register_usecase.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_state.dart';
import 'package:unity_app/features/auth/presentation/login_page.dart';
import 'package:unity_app/features/classes/presentation/classes_page.dart';

class MyApp extends StatelessWidget {
  final RegisterUseCase registerUsecase;

  const MyApp({super.key, required this.registerUsecase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unity App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            return const ClassesPage();
          }

          return LoginPage(registerUseCase: registerUsecase);
        },
      ),
    );
  }
}
