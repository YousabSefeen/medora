import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/themes/app_colors.dart';

class OrderSuccessInfo extends StatelessWidget {
  final String title;
  final String sub;
  final bool isTotalText;

  const OrderSuccessInfo({
    super.key,
    required this.title,
    required this.sub,
    this.isTotalText = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: title == 'Total'
                ? GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 17.sp,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.customWhite,
                    ),
                  )
                : GoogleFonts.raleway(
                    textStyle: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff9AA6B2),
                    ),
                  ),
          ),
          Text(
            sub,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
