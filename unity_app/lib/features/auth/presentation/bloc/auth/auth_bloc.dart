import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/auth/domain/auth_repository.dart';
import 'package:unity_app/features/auth/presentation/bloc/auth/auth_event.dart';
import 'package:unity_app/features/auth/presentation/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<AuthCheckRequested>(_onCheckAuth);
    on<AuthLoggedOut>(_onLogout);
  }

  Future<void> _onCheckAuth(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final token = await repository.getSavedToken();

    if (token != null) {
      emit(AuthAuthenticated(token));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onLogout(AuthLoggedOut event, Emitter<AuthState> emit) async {
    // await repository.logout();
    emit(AuthUnauthenticated());
  }
}
