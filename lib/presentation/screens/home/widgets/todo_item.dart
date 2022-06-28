import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/todo/todo.dart';

import '../../../../application/todos/controller/controller_bloc.dart';
import '../../routes/routar.gr.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  void _showDeleteDialog(
      {required BuildContext context, required ControllerBloc bloc}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Selected Todo to delete: '),
            content:
                Text(todo.title, maxLines: 3, overflow: TextOverflow.ellipsis),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('cancel')),
              TextButton(
                  onPressed: () {
                    bloc.add(DeleteTodoEvent(todo: todo));
                    Navigator.pop(context);
                  },
                  child: const Text('delete')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () =>
          AutoRouter.of(context).push(TodoDetailScreenRoute(todo: todo)),
      onLongPress: () {
        final controllerBloc = context.read<ControllerBloc>();
        _showDeleteDialog(context: context, bloc: controllerBloc);
      },
      child: Material(
          elevation: 16,
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: todo.color.color,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    todo.body,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Transform.scale(
                          scale: 1.2,
                          child: Checkbox(
                            shape: const CircleBorder(
                              side: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            activeColor: Colors.white,
                            checkColor: todo.color.color,
                            value: todo.done,
                            onChanged: (value) {
                              if (value != null) {
                                BlocProvider.of<ControllerBloc>(context).add(
                                    UpdateTodoEvent(todo: todo, done: value));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
