import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/todos/todoForm/todoform_bloc.dart';
import 'package:todo/injection.dart';
import 'package:todo/presentation/screens/routes/routar.gr.dart';
import 'package:todo/presentation/screens/todo_detail/widgets/safe_progress_overlay.dart';
import 'package:todo/presentation/screens/todo_detail/widgets/todo_form.dart';

import '../../../domain/entities/todo/todo.dart';

class TodoDetailScreen extends StatelessWidget {
  final Todo? todo;

  const TodoDetailScreen({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TodoformBloc>()..add(InitializeTodoDetailScreen(todo: todo)),
      child: BlocConsumer<TodoformBloc, TodoformState>(
        //Wenn sich nichts tut, machen wir nichts
        listenWhen: ((previous, current) =>
            previous.failureOrSuccessOption != current.failureOrSuccessOption),
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
              () => () {},
              (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                  (failure) =>
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(failure.toString()),
                        backgroundColor: Colors.redAccent,
                      )),
                  (_) => Navigator.of(context).popUntil(
                      (route) => route.settings.name == HomePageRoute.name)));
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(todo == null ? 'Create Todo' : 'Edit Todo'),
            ),
            body: Stack(
              children: [
                const TodoForm(),
                SafeProgressOverlay(isSaving: state.isSaving),
              ],
            ),
          );
        },
      ),
    );
  }
}
