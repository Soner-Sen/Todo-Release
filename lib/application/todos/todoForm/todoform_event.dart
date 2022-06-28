part of 'todoform_bloc.dart';

@immutable
abstract class TodoformEvent {}

class InitializeTodoDetailScreen extends TodoformEvent {
  final Todo? todo;

  InitializeTodoDetailScreen({required this.todo});
}

class UpdateTodoColor extends TodoformEvent {
  final Color color;

  UpdateTodoColor({required this.color});
}

class SafePressedEvent extends TodoformEvent {
  final String? title;
  final String? body;

  SafePressedEvent({required this.title, required this.body});
}
