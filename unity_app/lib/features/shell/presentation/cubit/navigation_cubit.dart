import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/shell/presentation/cubit/navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(0));

  void goTo(int index) {
    if (index == state.currentIndex) return;
    emit(NavigationState(index));
  }
}
