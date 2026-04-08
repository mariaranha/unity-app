import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/auth/domain/user.dart';
import 'package:unity_app/features/auth/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void setUser(User user) => emit(UserLoaded(user));

  void clearUser() => emit(UserInitial());
}
