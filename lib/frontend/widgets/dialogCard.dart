import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class DialogCard {
  void call(BuildContext context, Widget data) {
    showDialog(
        context: context,
        builder: (context) => BlurryContainer(
              blur: 15,
              child: Dialog(
                elevation: 25,
                insetAnimationCurve: Curves.decelerate,
                insetAnimationDuration: Duration(milliseconds: 300),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: data,
                ),
              ),
            ));
  }
}
