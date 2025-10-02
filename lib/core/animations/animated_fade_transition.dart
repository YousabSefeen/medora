import 'package:flutter/material.dart';

import '../constants/app_duration/app_duration.dart';

class AnimatedFadeTransition extends StatefulWidget {
  final Widget child;

  const AnimatedFadeTransition({
    required this.child,
    super.key,
  });

  @override
  State<AnimatedFadeTransition> createState() => _AnimatedFadeTransitionState();
}

class _AnimatedFadeTransitionState extends State<AnimatedFadeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  void _initializeAnimation() {

    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.milliseconds_1500,

    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}
