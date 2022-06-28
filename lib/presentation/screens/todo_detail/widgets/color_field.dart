import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/todo/todo_color.dart';

import '../../../../application/todos/todoForm/todoform_bloc.dart';

class ColorField extends StatelessWidget {
  final TodoColor color;
  const ColorField({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              final itemColor = TodoColor.predefinedColors[index];

              return InkWell(
                onTap: () {
                  BlocProvider.of<TodoformBloc>(context).add(
                    UpdateTodoColor(color: itemColor),
                  );
                },
                child: Material(
                  shape: CircleBorder(
                      side: BorderSide(
                          width: 2,
                          color: itemColor == color.color
                              ? Colors.white
                              : Colors.transparent)),
                  color: itemColor,
                  elevation: 10,
                  child: const SizedBox(
                    height: 50,
                    width: 50,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 10);
            },
            itemCount: TodoColor.predefinedColors.length));
  }
}
