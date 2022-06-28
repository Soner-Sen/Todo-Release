import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/entities/todo/todo.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/infrastructure/extensions/firebase_helpers.dart';
import 'package:todo/infrastructure/models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseFirestore firestore;
  TodoRepositoryImpl({required this.firestore});

  @override
  Stream<Either<TodoFailure, List<Todo>>> watchAll() async* {
    //Vom user erst Mal ein Update was drin ist
    final userDoc = await firestore.userDocument();
    //Gehen in die Reihe Todo => Machen ein Snapshot von dem Inhalt und für jedes Todo erstellen wir eine Snapshot Map
    //Snapshot ist ein Abbild aller Daten
    //Schau dir jedes Todo an und erstelle daraus ein Model
    // Die toDomain funktion wandelt Model in eine Todo um
    yield* userDoc.todoCollection
        .snapshots()
        .map((snapshot) => right<TodoFailure, List<Todo>>(snapshot.docs
            .map((doc) => TodoModel.fromFireStore(doc).toDomain())
            .toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains('PERMISSION_DENIED')) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }

  @override
  Future<Either<TodoFailure, Unit>> create(Todo todo) async {
    try {
      //Zuerst in den Pfad rein
      final userDoc = await firestore.userDocument();
      //Aus Entitiy in ein Model
      final todoModel = TodoModel.fromDomain(todo);
      //Sind im user drin: Erstelle unter dieser ID eine Map Key;Value für JSON Format
      await userDoc.todoCollection.doc(todoModel.id).set(todoModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<TodoFailure, Unit>> delete(Todo todo) async {
    try {
      final userDoc = await firestore.userDocument();
      final todoModel = TodoModel.fromDomain(todo);
      //Sind im user drin: Lösche unter dieser ID
      await userDoc.todoCollection.doc(todoModel.id).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        // NOt Found
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<TodoFailure, Unit>> update(Todo todo) async {
    try {
      final userDoc = await firestore.userDocument();
      final todoModel = TodoModel.fromDomain(todo);
      //Sind im user drin: Update unter dieser ID eine Map Key;Value für JSON Format
      await userDoc.todoCollection.doc(todoModel.id).update(todoModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        //Not Found?
        return left(InsufficientPermissions());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }
}
