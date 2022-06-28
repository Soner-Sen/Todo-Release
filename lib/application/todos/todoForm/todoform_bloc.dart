import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

import '../../../core/failures/todo_failures.dart';
import '../../../domain/entities/todo/todo.dart';
import '../../../domain/entities/todo/todo_color.dart';

part 'todoform_event.dart';
part 'todoform_state.dart';

class TodoformBloc extends Bloc<TodoformEvent, TodoformState> {
  final TodoRepository todoRepository;

  TodoformBloc({required this.todoRepository})
      : super(TodoformState.initial()) {
    on<InitializeTodoDetailScreen>((event, emit) {
      if (event.todo != null) {
        emit(state.copyWith(todo: event.todo, isEditing: true));
      } else {
        emit(TodoformState.initial());
      }
    });

    on<UpdateTodoColor>((event, emit) {
      emit(state.copyWith(
          todo: state.todo.copyWith(color: TodoColor(color: event.color))));
    });

    on<SafePressedEvent>((event, emit) async {
      Either<TodoFailure, Unit>? failureOrSuccess;
      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));

      if (event.title != null && event.body != null) {
        final Todo editedTodo = state.todo.copyWith(
          title: event.title,
          body: event.body,
        );
        if (state.isEditing) {
          final failureOrSuccess = await todoRepository.update(editedTodo);
        } else {
          final failureOrSuccess = await todoRepository.create(editedTodo);
        }
      }

      emit(state.copyWith(
        isSaving: false,
        showErrorMessage: true,
        failureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });
  }
}
