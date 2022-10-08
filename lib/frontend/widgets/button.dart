import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Button extends StatelessWidget {
  final Text text;
  Color color;
  final Function onPressed;

  Button(
      {required this.text,
      required this.onPressed,
      this.color = Colors.lightBlue});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: text,
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(color),
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }
}
