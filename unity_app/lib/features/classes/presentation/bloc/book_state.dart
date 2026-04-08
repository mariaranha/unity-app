abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {
  final String classId;

  BookLoading(this.classId);
}

class BookSuccess extends BookState {
  final String message;

  BookSuccess(this.message);
}

class BookFailure extends BookState {
  final String message;

  BookFailure(this.message);
}
