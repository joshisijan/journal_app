import 'package:flutter/material.dart';

class CustomSlidePageRoute {
  createRoute({
    Duration duration = const Duration(milliseconds: 350),
    @required Widget route,
    @required Offset offset,
  }) {
    return PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (_, __, ___) {
        return route;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(
          curve: Curves.easeIn,
          parent: animation,
        );
        return SlideTransition(
          position: Tween(
            begin: offset,
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
