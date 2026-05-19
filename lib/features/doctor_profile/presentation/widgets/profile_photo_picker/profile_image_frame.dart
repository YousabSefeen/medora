import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_colors.dart';

class ProfileImageFrame extends StatelessWidget {
  final Widget child;
  final double size;
  final Color borderColor;

  const ProfileImageFrame({
    super.key,
    required this.child,
    this.size = 110.0,
    this.borderColor = AppColors.black26,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        shape: BoxShape.circle,
      ),
      child: ClipOval(child: child),
    );
  }
}
