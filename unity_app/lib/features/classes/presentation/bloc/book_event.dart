abstract class BookEvent {}

class BookClassRequested extends BookEvent {
  final String classId;

  BookClassRequested(this.classId);
}
