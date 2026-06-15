import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ObscureTextVisibilityButton extends StatelessWidget {
  final bool isObscured;
  final VoidCallback onTap;

  const ObscureTextVisibilityButton({
    super.key,
    required this.isObscured,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isObscured
            ? Icons.visibility_off_outlined
            : Icons.visibility_outlined,
        color: Colors.white60,
        size: 20.sp,
      ),
      onPressed: onTap,
    );
  }
}