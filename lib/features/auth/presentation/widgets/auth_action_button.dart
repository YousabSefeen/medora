import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';

class AuthActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double heightButton;

  const AuthActionButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.heightButton = 50,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: heightButton,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          textStyle: context.textTheme.mediumWhiteBold16,
          backgroundColor: AppColors.primaryButtonBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: const BorderSide(color: Colors.white38),
          ),
          elevation: 1,
        ),
        child: child,
      ),
    );
  }
}
