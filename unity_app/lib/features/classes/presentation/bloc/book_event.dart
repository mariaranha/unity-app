abstract class BookEvent {}

class BookClassRequested extends BookEvent {
  final String classId;

  BookClassRequested(this.classId);
}

class CancelClassRequested extends BookEvent {
  final String classId;

  CancelClassRequested(this.classId);
}
