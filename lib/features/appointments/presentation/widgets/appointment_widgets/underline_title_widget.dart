import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class UnderlineTitleWidget extends StatelessWidget {
  final String title;

  const UnderlineTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 2,
        children: [
          Text(
            title,
            style: GoogleFonts.playpenSans(
              fontSize: 16.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              color: AppColors.customBlue,
            ),
          ),
          Container(
            height: 2,
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000),
              ),
              shadows: const [
                BoxShadow(
                  color: Colors.blue,
                  blurRadius: 2,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
