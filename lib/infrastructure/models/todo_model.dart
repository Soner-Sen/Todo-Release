import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/domain/entities/userID/id.dart';

import '../../domain/entities/todo/todo.dart';
import '../../domain/entities/todo/todo_color.dart';

class TodoModel {
  final String id;
  final String title;
  final String body;

  final bool done;
  final int color;
  final dynamic serverTimeStamp;

  TodoModel(
      {required this.id,
      required this.title,
      required this.body,
      required this.done,
      required this.color,
      required this.serverTimeStamp});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'done': done,
      'color': color,
      'serverTimeStamp': serverTimeStamp,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: '',
      title: map['title'] as String,
      body: map['body'] as String,
      done: map['done'] as bool,
      color: map['color'] as int,
      serverTimeStamp: map['serverTimeStamp'],
    );
  }

  TodoModel copyWith({
    String? id,
    String? title,
    String? body,
    bool? done,
    int? color,
    dynamic serverTimeStamp,
  }) {
    return TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        done: done ?? this.done,
        color: color ?? this.color,
        serverTimeStamp: serverTimeStamp ?? this.serverTimeStamp);
  }

  factory TodoModel.fromFireStore(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    //ID ist leer in der From Map und mit Copywith schreiben wir die ID von Firestore rein
    return TodoModel.fromMap(doc.data()).copyWith(id: doc.id);
  }

  Todo toDomain() {
    return Todo(
        id: UniqueID.fromUniqueString(id),
        title: title,
        body: body,
        done: done,
        color: TodoColor(color: Color(color).withOpacity(1)));
  }

  //Jedesmal wenn ein Model entsteht Factory ansonsten Funktion
  //Factory erstellt Abbilder von Dieser Klasse und dort werden Werte eingetragen
  factory TodoModel.fromDomain(Todo todoItem) {
    return TodoModel(
        id: todoItem.id.value,
        title: todoItem.title,
        body: todoItem.body,
        done: todoItem.done,
        color: todoItem.color.color.value,
        serverTimeStamp: FieldValue.serverTimestamp());
  }
}
