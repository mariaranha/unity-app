import 'package:unity_app/features/auth/domain/user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess(this.user);
}

class LoginUnauthenticated extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
