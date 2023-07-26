import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage pageAnimation({
  required Widget page,
  required GoRouterState state,
}) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 500),
    child: page,
    transitionsBuilder: (context, animation, _, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.ease).animate(animation),
        child: child,
      );
    },
  );
}
