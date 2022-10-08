import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class DialogCard {
  void call(BuildContext context, Widget data) {
    showGeneralDialog(
        context: context,
        barrierColor: Colors.transparent,
        transitionDuration: Duration(milliseconds: 500),
        transitionBuilder: (context, animation, secondaryAnimation, child) =>
            ScaleTransition(
              child: child,
              scale: Tween<double>(end: 1, begin: 0).animate(CurvedAnimation(
                  parent: animation,
                  curve: Interval(0.00, 0.5, curve: Curves.decelerate))),
            ),
        pageBuilder: (context, animation, secondaryAnimation) => Dialog(
              backgroundColor: Colors.transparent,
              elevation: 25,
              insetAnimationCurve: Curves.decelerate,
              insetAnimationDuration: Duration(milliseconds: 300),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: BlurryContainer(
                blur: 20,
                color: Colors.grey.shade50.withAlpha(200),

                // height: ,
                padding: EdgeInsets.all(20),
                child: data,
              ),
            ));
  }
}
