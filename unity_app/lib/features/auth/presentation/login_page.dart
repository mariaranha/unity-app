import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_event.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushReplacementNamed(context, '/classes');
            }

            if (state is LoginFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            final loading = state is LoginLoading;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: loading
                        ? null
                        : () {
                            context.read<LoginBloc>().add(
                              LoginSubmitted(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                          },
                    child: loading
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
