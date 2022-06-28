import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/authbloc/auth_bloc.dart';
import 'package:todo/presentation/screens/routes/routar.gr.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          //Navigate to Home
          context.router.replace(HomePageRoute());
        } else if (state is AuthStateUnauthenticated) {
          //Navigate to SignUp
          context.router.replace(SignUpScreenRoute());
        }
      },
      child: Scaffold(
        body: Center(
            child: CircularProgressIndicator(
          color: Colors.pink,
        )),
      ),
    );
  }
}
