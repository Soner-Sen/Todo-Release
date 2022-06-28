import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/todos/observer/observer_bloc.dart';
import 'package:todo/presentation/screens/home/widgets/progress_bar.dart';
import 'package:todo/presentation/screens/home/widgets/todo_item.dart';

import 'flexible_space.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, state) {
        if (state is ObserverInitial) {
          return Container();
        } else if (state is ObserverLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.pink),
          );
        } else if (state is ObserverLoaded) {
          //CustomScrollView nimmt Silvers: Widgets von eiem speziellen Typ
          return SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverAppBar(
                  //Ganz oben
                  collapsedHeight: 70,
                  //ausgeklappt
                  expandedHeight: 280,
                  pinned: true,
                  flexibleSpace: FlexibleSpacerWidget(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  sliver: SliverToBoxAdapter(
                    child: ProgressBar(todos: state.todos),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(20.0),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      ((context, index) {
                        final todo = state.todos[index];
                        return TodoItem(
                          todo: todo,
                        );
                      }),
                      childCount: state.todos.length,
                    ),
                    //itemCount: state.todos.length,
                    //Verteilen: Abstände etc.
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 30,
                            //Ein Card ist 4 Breit 5 Hoch
                            childAspectRatio: 4 / 5),
                  ),
                ),
              ],
            ),
          );
        } else if (state is ObserverFailure) {
          return const Center(child: Text('Failure'));
        }
        return Container();
      },
    );
  }
}
