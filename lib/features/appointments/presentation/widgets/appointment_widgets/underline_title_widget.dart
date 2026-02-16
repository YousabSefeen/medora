import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class UnderlineTitleWidget extends StatelessWidget {
  final String title;

  const UnderlineTitleWidget({super.key, required this.title});

  static const double _underlineHeight = 1.5;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 4,
        children: [
          Text(
            title,
            maxLines: 1,
            softWrap: false,
            style: GoogleFonts.playpenSans(
              fontSize: 16.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              color: AppColors.customBlue,
            ),
          ),

          const Material(
            elevation: _underlineHeight,
            shadowColor: AppColors.lightBlue,
            color: AppColors.softBlue,
            shape: StadiumBorder(),
            child: SizedBox(height: _underlineHeight),
          ),
        ],
      ),
    );
  }
}
