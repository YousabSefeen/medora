import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

class FilterActionButton extends StatelessWidget {
  final Color backgroundColor;
  final String text;

  final void Function() onPressed;

  const FilterActionButton({
    super.key,
    required this.backgroundColor,
    required this.text,

    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: SizedBox(
        width: double.infinity,
        height: 45,

        child: ElevatedButton(
          style: _buildButtonStyle(),
          onPressed: onPressed,
          child: Text(
            text,
            style: Theme.of(context).textTheme.largeWhiteSemiBold.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }

  ButtonStyle _buildButtonStyle() {
    return ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      ),
      backgroundColor: WidgetStatePropertyAll(backgroundColor),
      overlayColor: const WidgetStatePropertyAll(Colors.black),
      elevation: const WidgetStatePropertyAll(4),
      shadowColor: const WidgetStatePropertyAll(Colors.black),
    );
  }
}
