import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/signupform/signupform_bloc.dart';
import 'package:todo/presentation/screens/signup/widgets/signup_form.dart';

import '../../../injection.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: BlocProvider(
          create: (context) => sl<SignupformBloc>(), child: const SignUpForm()),
    );
  }
}
