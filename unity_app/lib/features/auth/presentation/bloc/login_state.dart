abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String token;

  LoginSuccess(this.token);
}

class LoginUnauthenticated extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
