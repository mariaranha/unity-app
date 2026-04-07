import 'package:unity_app/features/classes/domain/class_entity.dart';

abstract class ClassesState {}

class ClassesInitial extends ClassesState {}

class ClassesLoading extends ClassesState {}

class ClassesLoaded extends ClassesState {
  final List<ClassEntity> classes;

  ClassesLoaded(this.classes);
}

class ClassesError extends ClassesState {
  final String message;

  ClassesError(this.message);
}
