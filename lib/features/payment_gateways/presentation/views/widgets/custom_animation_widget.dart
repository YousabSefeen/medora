import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAnimationWidget extends StatelessWidget {
  final Color color;
  final Widget child;
  final double endPosition;

  const CustomAnimationWidget({
    super.key,
    required this.child,
    required this.endPosition,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.8, end: endPosition),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        builder: (context, scale, _) {
          return Transform.scale(scale: scale, child: child);
        },
      ),
    );
  }
}
