import 'package:flutter/material.dart';

import '../constants/app_duration/app_duration.dart';
import '../constants/themes/app_colors.dart';

class AnimatedGradientBackground extends StatefulWidget {
  final Widget? child;

  const AnimatedGradientBackground({super.key, this.child});

  @override
  State<AnimatedGradientBackground> createState() =>
      _AnimatedGradientBackgroundState();
}

class _AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _gradientAnimationController;
  late Animation<Alignment> _startAlignmentAnimation;
  late Animation<Alignment> _endAlignmentAnimation;

  _initializeAnimatedGradient() {
    _gradientAnimationController = AnimationController(
      vsync: this,
      duration: AppDurations.seconds_10,
    );
    _startAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
    ]).animate(_gradientAnimationController);

    _endAlignmentAnimation = TweenSequence<Alignment>([
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomRight,
          end: Alignment.bottomLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.bottomLeft,
          end: Alignment.topLeft,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
        ),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<Alignment>(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        weight: 1,
      ),
    ]).animate(_gradientAnimationController);
    _gradientAnimationController.repeat();
  }

  @override
  void initState() {
    _initializeAnimatedGradient();
    super.initState();
  }

  @override
  void dispose() {
    _gradientAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
      '_AnimatedGradientBackgroundState extends State<AnimatedGradientBackground>',
    );
    final deviceSize = MediaQuery.sizeOf(context);
    return AnimatedBuilder(
      animation: _gradientAnimationController,
      builder: (context, child) => Container(
        height: deviceSize.height,
        width: deviceSize.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: _startAlignmentAnimation.value,
            end: _endAlignmentAnimation.value,
            colors: AppColors.gradientAnimationColor,
          ),
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}
