import 'dart:ui';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final Function callback;

  const CustomButton({Key? key, required this.btnText, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => callback(),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
