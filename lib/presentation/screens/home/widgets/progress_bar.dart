import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/home/widgets/progress_bar_painter.dart';

import '../../../../domain/entities/todo/todo.dart';

class ProgressBar extends StatelessWidget {
  //bekommen von außen die Todos rein
  final List<Todo> todos;

  const ProgressBar({Key? key, required this.todos}) : super(key: key);

  double _getDoneTodoPercentage({required List<Todo> todos}) {
    final doneTodoCount = todos.where((todo) => todo.done).length;
    final totalTodoCount = todos.length;
    return doneTodoCount / totalTodoCount;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 18,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Text(
                'Todos Progress',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: LayoutBuilder(builder: (context, constraints) {
                return Center(
                    child: CustomPaint(
                        painter: ProgressBarPainter(
                            donePercent: _getDoneTodoPercentage(todos: todos),
                            parentWidth: constraints.maxWidth,
                            barHeight: 25,
                            backgroundColor: Colors.grey,
                            percentageColor: Colors.orangeAccent)));
              })),
            ],
          ),
        ),
      ),
    );
  }
}
