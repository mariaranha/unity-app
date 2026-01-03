import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/auth/domain/login_usecase.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_event.dart';
import 'package:unity_app/features/auth/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final token = await loginUseCase(event.email, event.password);

      emit(LoginSuccess('123'));
    } catch (_) {
      emit(LoginFailure('Invalid credentials'));
    }
  }
}
