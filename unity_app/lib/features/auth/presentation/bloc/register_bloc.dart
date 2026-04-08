import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/auth/domain/register_usecase.dart';
import 'package:unity_app/features/auth/presentation/bloc/register_event.dart';
import 'package:unity_app/features/auth/presentation/bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc(this.registerUseCase) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      await registerUseCase(
        name: event.name,
        email: event.email,
        username: event.username,
        password: event.password,
        birthDate: event.birthDate,
      );
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
