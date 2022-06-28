import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

import '../../../domain/entities/todo/todo.dart';

part 'observer_event.dart';
part 'observer_state.dart';

class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  //Verwendet Funktionen aus dem Repository deshalb Injection
  final TodoRepository todoRepository;

  StreamSubscription<Either<TodoFailure, List<Todo>>>? _todoStreamSub;

  ObserverBloc({required this.todoRepository}) : super(ObserverInitial()) {
    //Unser erstes Event ist ObserveAllEvent
    on<ObserveAllEvent>((event, emit) async {
      emit(ObserverLoading());
      //Dort rufen wir die watchAll Funktion auf
      //Listen jedesMal wenn was geändert wird, wird listen ausgeführt
      await _todoStreamSub
          ?.cancel(); //Wenn wir einen Stream haben cancel den Stream
      _todoStreamSub = todoRepository.watchAll().listen((failureOrTodos) =>
          add(TodosUpdatedEvent(failureOrTodos: failureOrTodos)));
    });

    on<TodosUpdatedEvent>((event, emit) {
      event.failureOrTodos.fold(
          (failure) => emit(ObserverFailure(todoFailure: failure)),
          (todos) => emit(ObserverLoaded(todos: todos)));
    });
    //Immer wenn du die Seite neu aufrufst wird eine neue Instance erstellt
    //Irgendwann mehrere Listener => Rip Performance + eventueller Absturz
    @override
    Future<void> close() async {
      await _todoStreamSub?.cancel();
      return super.close();
    }
  }
}
