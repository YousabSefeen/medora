import 'package:flutter/material.dart';

class StepperIndicator extends StatelessWidget {
  final int activeIndex;
  final int totalSteps;
  final Color? activeColor;
  final Color? inactiveColor;
  final double? activeWidth;
  final double? inactiveWidth;
  final double? height;

  const StepperIndicator({
    super.key,
    required this.activeIndex,
    required this.totalSteps,
    this.activeColor,
    this.inactiveColor,
    this.activeWidth,
    this.inactiveWidth,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final activeColorFinal = activeColor ?? Colors.blue;
    final inactiveColorFinal = inactiveColor ?? Colors.white24;
    final activeWidthFinal = activeWidth ?? 50.0;
    final inactiveWidthFinal = inactiveWidth ?? 25.0;
    final heightFinal = height ?? 4.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          height: heightFinal,
          width: isActive ? activeWidthFinal : inactiveWidthFinal,
          decoration: BoxDecoration(
            boxShadow: [
              if (isActive)
                const BoxShadow(
                  color: Colors.white,
                  spreadRadius: 0.7,
                  blurRadius: 0.5,
                ),
            ],
            color: isActive ? activeColorFinal : inactiveColorFinal,
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
