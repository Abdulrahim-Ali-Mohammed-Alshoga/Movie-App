import 'package:flutter/material.dart';

class AnimateRoute extends PageRouteBuilder {
  final Widget page;
  final double topOrBottom;
  final double rightOrLeft;

  AnimateRoute({required this.page, required this.topOrBottom, required this.rightOrLeft})
      : super(
     transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(rightOrLeft, topOrBottom);
      const end = Offset.zero;

      const curve = Curves.linear;
      final tween = Tween(begin: begin, end: end);
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,

      );

      // final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,

      );
    },
  );
}
