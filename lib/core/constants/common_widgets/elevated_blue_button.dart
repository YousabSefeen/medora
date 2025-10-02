import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class ElevatedBlueButton extends StatelessWidget {
  final String text;

  final void Function() onPressed;

  const ElevatedBlueButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
          backgroundColor: WidgetStatePropertyAll(AppColors.white),
          foregroundColor: const WidgetStatePropertyAll(Colors.blue),
          overlayColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: const BorderSide(color: Colors.blue, width: 1.2),
          ))),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
