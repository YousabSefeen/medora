import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class CustomHalfCircle extends StatelessWidget {
  final bool isLeftPosition;

  const CustomHalfCircle({super.key, required this.isLeftPosition});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: isLeftPosition
            ? const BorderRadius.only(
                bottomRight: Radius.circular(100),
                topRight: Radius.circular(100),
              )
            : const BorderRadius.only(
                bottomLeft: Radius.circular(100),
                topLeft: Radius.circular(100),
              ),
        gradient: LinearGradient(
          colors: isLeftPosition
              ? AppColors.colorsLeftPosition
              : AppColors.colorsRightPosition,
        ),
      ),
    );
  }
}
