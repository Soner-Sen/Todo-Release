part of 'observer_bloc.dart';

@immutable
abstract class ObserverEvent {}

//Sobald wir auf dem Homescreen sind: WatchAll Methode aufrufen
class ObserveAllEvent extends ObserverEvent {}

class TodosUpdatedEvent extends ObserverEvent {
  final Either<TodoFailure, List<Todo>> failureOrTodos;
  TodosUpdatedEvent({required this.failureOrTodos});
}
