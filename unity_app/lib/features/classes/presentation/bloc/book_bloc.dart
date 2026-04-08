import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unity_app/features/classes/domain/book_class_usecase.dart';
import 'package:unity_app/features/classes/domain/cancel_class_usecase.dart';
import 'package:unity_app/features/classes/presentation/bloc/book_event.dart';
import 'package:unity_app/features/classes/presentation/bloc/book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookClassUseCase bookClassUseCase;
  final CancelClassUseCase cancelClassUseCase;

  BookBloc({
    required this.bookClassUseCase,
    required this.cancelClassUseCase,
  }) : super(BookInitial()) {
    on<BookClassRequested>(_onBookRequested);
    on<CancelClassRequested>(_onCancelRequested);
  }

  Future<void> _onBookRequested(
    BookClassRequested event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading(event.classId));
    try {
      final message = await bookClassUseCase(event.classId);
      emit(BookSuccess(message));
    } catch (e) {
      emit(BookFailure(e.toString()));
    }
  }

  Future<void> _onCancelRequested(
    CancelClassRequested event,
    Emitter<BookState> emit,
  ) async {
    emit(BookLoading(event.classId));
    try {
      final message = await cancelClassUseCase(event.classId);
      emit(BookSuccess(message));
    } catch (e) {
      emit(BookFailure(e.toString()));
    }
  }
}
