import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class CustomFadeTransition extends CustomTransitionPage<void> {
  final Widget widgetChild;

  CustomFadeTransition({
    required this.widgetChild,
  }) : super(
          child: widgetChild,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Use a FadeTransition for the desired dissolve or fade transition.
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
