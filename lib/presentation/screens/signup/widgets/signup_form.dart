import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/signupform/signupform_bloc.dart';
import 'package:todo/core/failures/auth_failures.dart';
import 'package:todo/presentation/screens/home/home_screen.dart';
import 'package:todo/presentation/screens/routes/routar.gr.dart';
import 'package:todo/presentation/core/custom_btn.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    late String email;
    late String password;

    String? validateEmail(String? input) {
      const emailRegex =
          r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';

      if (input == null || input.isEmpty) {
        return 'Email is required';
      }
      // Validiert
      else if (RegExp(emailRegex).hasMatch(input)) {
        email = input;
        return null;
      } else {
        return 'Email is invalid';
      }
    }

    String? validatePassword(String? input) {
      const emailRegex =
          r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';

      if (input == null || input.isEmpty) {
        return 'Password is required';
      }
      // Validiert
      else if (input.length > 5) {
        password = input;
        return null;
      } else {
        return 'Password is to short';
      }
    }

    String mapFailureMessage(AuthFailure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return 'Something went wrong... please try again';
        case EmailAlreadyInUseFailure:
          return 'E-Mail already used';
        case InvalidEmailAndPasswordCombinationFailure:
          return 'Invalid E-Mail or Password: Please check your input';
        default:
          return 'Something went wrong... please try again';
      }
    }

    return BlocConsumer<SignupformBloc, SignupformState>(
      listenWhen: (p, c) =>
          p.authFailureOrSuccessOption != c.authFailureOrSuccessOption,
      listener: (context, state) {
        //Funktionen ausführen abhängig vom State
        state.authFailureOrSuccessOption.fold(
            //Falls nichts drin steht machen wir nichts
            () => {},
            //Sobald es zu some wird, machen wir was
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                    //Failure
                    (failure) => () {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.redAccent,
                              content: Text(mapFailureMessage(failure))));
                        },
                    //Bekommen Unit also nichts: Alles hat geklappt
                    (_) {
                  AutoRouter.of(context).replace(const HomePageRoute());
                }));
      },
      builder: (context, state) {
        return Form(
            //TODO maybe change
            autovalidateMode: state.isSubmitting
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            key: formKey,

            //Eine Liste von Widgets: Besser als Column?
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: <Widget>[
                const SizedBox(height: 100),
                const Text(
                  'Welcome :)',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 4),
                ),
                const SizedBox(height: 20),
                Text('Please register or sign in'),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'E-Mail',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  validator: validateEmail,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autocorrect: false,
                  validator: validatePassword,
                ),
                const SizedBox(height: 40),
                CustomButton(
                    btnText: 'Sign In',
                    callback: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<SignupformBloc>(context).add(
                          SignInWithEmailAndPasswordPressed(
                              email: email, password: password),
                        );
                      } else {
                        BlocProvider.of<SignupformBloc>(context).add(
                          SignInWithEmailAndPasswordPressed(
                              email: null, password: null),
                        );
                      }
                    }),
                const SizedBox(height: 20),
                CustomButton(
                  btnText: 'Register',
                  callback: () {
                    if (formKey.currentState!.validate()) {
                      BlocProvider.of<SignupformBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: email, password: password),
                      );
                    } else {
                      BlocProvider.of<SignupformBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: null, password: null),
                      );
                      const snackBar = SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text('Invalid Input'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                ),
                //Wenn es Submittet wurde dann zeige diesen Abschnitt an
                if (state.isSubmitting) ...[
                  const SizedBox(height: 20),
                  const Center(
                      child: LinearProgressIndicator(
                    color: Colors.pink,
                  ))
                ]
              ],
            ));
      },
    );
  }
}
