import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/authbloc/auth_bloc.dart';

class FlexibleSpacerWidget extends StatelessWidget {
  const FlexibleSpacerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Padding(
        padding: const EdgeInsets.only(bottom: 90, top: 15),
        child: Image.asset('assets/img/logo.png'),
      ),
      titlePadding: const EdgeInsets.only(left: 20, bottom: 10),
      title: Row(
        children: [
          Text(
            'Todos',
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 1.5,
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutPressedEvent());
              },
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
    );
  }
}
