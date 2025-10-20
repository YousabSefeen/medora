import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NoMatchingDoctorsWidget extends StatelessWidget {
  const NoMatchingDoctorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20.h,
        children: [
          Icon(Icons.search_off, size: 100.sp),
          Text(
            'No doctors found matching your search.',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50.h)
        ],
      ),
    );
  }
}
