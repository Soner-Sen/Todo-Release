part of 'observer_bloc.dart';

@immutable
abstract class ObserverState {}

class ObserverInitial extends ObserverState {}

class ObserverLoading extends ObserverState {}

class ObserverLoaded extends ObserverState {
  final List<Todo> todos;
  ObserverLoaded({required this.todos});
}

class ObserverFailure extends ObserverState {
  final TodoFailure todoFailure;
  ObserverFailure({required this.todoFailure});
}
