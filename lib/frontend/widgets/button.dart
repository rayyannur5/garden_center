import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:garden_center/frontend/widgets/style.dart';

class Button extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  Color color;
  double height;
  double width;

  Button(
      {required this.onPressed, required this.child, this.color = AppColor.primary, this.height = 30, this.width = 50});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
        child: child,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(color),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          elevation: MaterialStatePropertyAll(0),
        ),
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
      ),
    );
  }
}
