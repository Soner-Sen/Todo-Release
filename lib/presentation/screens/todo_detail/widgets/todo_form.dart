import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/todos/todoForm/todoform_bloc.dart';
import 'package:todo/presentation/core/custom_btn.dart';

import 'color_field.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final textEditingControllerTitle = TextEditingController();
    final textEditingControllerBody = TextEditingController();

    late String title;
    late String body;

    String? validateBody(String? input) {
      if (input == null || input.isEmpty) {
        return 'Please enter a body';
      } else if (input.length < 300) {
        body = input;
        return null;
      } else {
        return 'Body is too long';
      }
    }

    String? validateTitle(String? input) {
      if (input == null || input.isEmpty) {
        return 'Please enter a title';
      } else if (input.length < 25) {
        title = input;
        return null;
      } else {
        return 'Title is too long';
      }
    }

    return BlocConsumer<TodoformBloc, TodoformState>(
      listenWhen: (previous, current) =>
          previous.isEditing != current.isEditing,
      listener: (context, state) {
        textEditingControllerTitle.text = state.todo.title;
        textEditingControllerBody.text = state.todo.body;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Form(
            key: formKey,
            autovalidateMode: state.showErrorMessage
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: ListView(
              children: [
                TextFormField(
                  controller: textEditingControllerTitle,
                  cursorColor: Colors.white,
                  maxLength: 100,
                  maxLines: 2,
                  minLines: 1,
                  validator: validateTitle,
                  decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: textEditingControllerBody,
                  cursorColor: Colors.white,
                  maxLength: 300,
                  maxLines: 10,
                  minLines: 5,
                  validator: validateBody,
                  decoration: InputDecoration(
                      counterText: '',
                      labelText: 'Body',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                SizedBox(height: 20),
                ColorField(color: state.todo.color),
                SizedBox(height: 20),
                CustomButton(
                    btnText: 'Safe',
                    callback: () {
                      //Form wird validiert
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<TodoformBloc>(context)
                            .add(SafePressedEvent(title: title, body: body));
                        Navigator.of(context).pop();
                      } else {
                        BlocProvider.of<TodoformBloc>(context)
                            .add(SafePressedEvent(title: null, body: null));

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a title and body'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
