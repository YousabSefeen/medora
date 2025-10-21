import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class CustomActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomActionButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
      child: ElevatedButton.icon(
        icon: Text(text),
        onPressed: onPressed,
        style: ButtonStyle(
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),

          backgroundColor: const WidgetStatePropertyAll(AppColors.softBlue),
          foregroundColor: const WidgetStatePropertyAll(AppColors.white),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.raleway(fontSize: 15.sp, fontWeight: FontWeight.w800),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        ),
        label: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 18.sp,
          color: Colors.white,
        ),
      ),
    );
  }
}
