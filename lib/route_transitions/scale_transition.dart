import 'package:flutter/material.dart';

class CustomScalePageRoute {
  createRoute({
    Duration duration = const Duration(milliseconds: 350),
    @required Widget route,
    double scale = 0.5,
  }) {
    return PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (_, __, ___) {
        return route;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        animation = CurvedAnimation(
          curve: Curves.easeIn,
          reverseCurve: Curves.easeInCubic,
          parent: animation,
        );
        return ScaleTransition(
          scale: Tween(
            begin: 0.0,
            end: 1.0,
          ).animate(animation),
          child: FadeTransition(
            opacity: Tween(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          ),
        );
      },
    );
  }
}
