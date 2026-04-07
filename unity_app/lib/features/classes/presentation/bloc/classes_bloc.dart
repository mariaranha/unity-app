import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/classes/domain/get_classes_usecase.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_event.dart';
import 'package:unity_app/features/classes/presentation/bloc/classes_state.dart';

class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  final GetClassesUseCase getClassesUseCase;

  ClassesBloc(this.getClassesUseCase) : super(ClassesInitial()) {
    on<ClassesLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    ClassesLoadRequested event,
    Emitter<ClassesState> emit,
  ) async {
    emit(ClassesLoading());
    try {
      final classes = await getClassesUseCase();
      emit(ClassesLoaded(classes));
    } catch (e) {
      emit(ClassesError(e.toString()));
    }
  }
}
