import 'package:flutter/material.dart';
import 'package:medora/core/enum/animation_type.dart' show AnimationType;

class CustomAnimationTransition extends StatelessWidget {
  final Widget child;
  final AnimationType animationType;

  const CustomAnimationTransition({
    super.key,
    required this.child,
    required this.animationType,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),

      transitionBuilder: (Widget child, Animation<double> animation) {
        switch (animationType) {
          case AnimationType.slideUp:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.9),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          case AnimationType.fade:
            return FadeTransition(opacity: animation, child: child);
          case AnimationType.scale:
            return ScaleTransition(scale: animation, child: child);
          case AnimationType.slideDown:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, -0.9),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
        }
      },
      child: child,
    );
  }
}
