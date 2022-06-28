import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/authbloc/auth_bloc.dart';
import 'package:todo/application/todos/controller/controller_bloc.dart';
import 'package:todo/injection.dart';
import 'package:todo/presentation/screens/home/widgets/home_body.dart';
import 'package:todo/presentation/screens/routes/routar.gr.dart';

import '../../../application/todos/observer/observer_bloc.dart';
import '../../../core/failures/todo_failures.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  String _mapFailureToMessage(TodoFailure todoFailure) {
    switch (todoFailure.runtimeType) {
      case InsufficientPermissions:
        return 'You have not the permission to do that';
      case UnexpectedFailure:
        return 'Something went wrong... pls try again';
      default:
        return 'Something went wrong... pls try again';
    }
  }

  @override
  Widget build(BuildContext context) {
    final observerBloc = sl<ObserverBloc>()..add(ObserveAllEvent());
    return MultiBlocProvider(
      providers: [
        BlocProvider<ObserverBloc>(create: (context) => observerBloc),
        BlocProvider<ControllerBloc>(create: (context) => sl<ControllerBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: ((context, state) {
              if (state is AuthStateUnauthenticated) {
                AutoRouter.of(context).push(const SignUpScreenRoute());
              }
            }),
          ),
          BlocListener<ControllerBloc, ControllerState>(
            listener: ((context, state) {
              if (state is ControllerFailure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(_mapFailureToMessage(state.todoFailure))));
              }
            }),
          ),
        ],
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,

          /*
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(SignOutPressedEvent());
                  },
                  icon: const Icon(Icons.exit_to_app)),
            ],
            title: const Text('Todo'),
            centerTitle: true,
          ),*/
          body: HomeBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.greenAccent,
            onPressed: () {
              AutoRouter.of(context).push(TodoDetailScreenRoute(todo: null));
            },
            child: const Icon(
              Icons.add_sharp,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}
