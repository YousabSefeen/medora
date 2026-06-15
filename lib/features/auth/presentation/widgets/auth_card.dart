import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/extensions/media_query_extension.dart';

import '../../../../core/constants/themes/app_colors.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * 0.85,

      padding: EdgeInsets.all(20.sp),
      // margin: EdgeInsets.symmetric(
      //   vertical: 55.h,
      //
      // ),
      decoration: BoxDecoration(
        color: AppColors.authContainerColor,

        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white24),
      ),
      child: child,
    );
  }
}
