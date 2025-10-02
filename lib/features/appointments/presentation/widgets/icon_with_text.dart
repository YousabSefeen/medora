import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconWithText extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String text;

  final TextStyle textStyle;
  const IconWithText({
    super.key,
    required this.icon,
      this.iconColor,
    required this.text,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, size: 18.sp, color: iconColor ?? textStyle.color),
        Text(text, style: textStyle ,
        ),
      ],
    );
  }
}
