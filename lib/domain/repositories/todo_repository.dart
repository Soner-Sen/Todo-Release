import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/todo_failures.dart';

import '../entities/todo/todo.dart';

abstract class TodoRepository {
  //Ich höre auf alles
  //Stream weil wir drauf hören können
  Stream<Either<TodoFailure, List<Todo>>> watchAll();

  Future<Either<TodoFailure, Unit>> create(Todo todo);
  Future<Either<TodoFailure, Unit>> update(Todo todo);
  Future<Either<TodoFailure, Unit>> delete(Todo todo);
}
