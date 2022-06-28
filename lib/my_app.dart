import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/authbloc/auth_bloc.dart';
import 'package:todo/injection.dart';

import 'presentation/screens/routes/routar.gr.dart' as r;

class MyApp extends StatelessWidget {
  final _appRouter = r.AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            //Checken am Anfang ob wir Eingeloggt sind oder nicht
            create: (context) =>
                sl<AuthBloc>()..add(AuthCheckRequestedEvent())),
      ],
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
