import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';

class EmptySearchListResult extends StatelessWidget {
  const EmptySearchListResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 20.h,
      children: [
        Icon(Icons.search_off, size: 100.sp),
        Text(
          AppStrings.noMatchingDoctorsFoundMessage,
          style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
