import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;




class FilterSectionTitle extends StatelessWidget {
  final String title;
  final bool? showPaddingTop;

  const FilterSectionTitle({
    super.key,
    required this.title,
    this.showPaddingTop = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20, top: showPaddingTop! ? 25 : 10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          color: AppColors.softBlue,
          fontSize: 18.sp,
          letterSpacing: 1,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}