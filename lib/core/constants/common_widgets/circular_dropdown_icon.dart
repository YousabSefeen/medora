import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_colors.dart';

class CircularDropdownIcon extends StatelessWidget {
  const CircularDropdownIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 25,
      decoration: ShapeDecoration(
        color: AppColors.white,
        shadows: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 2,
            spreadRadius: 0.5,
            offset: const Offset(0, 1),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000.r),
          //01224380436
          side: const BorderSide(color: AppColors.softBlue, width: 1),
        ),
      ),

      // backgroundColor: Colors.grey.shade100,
      child: Center(
        child: Icon(Icons.keyboard_arrow_down, color: AppColors.black),
      ),
    );
  }
}

/*
    return CircleAvatar(
      radius: 12.r,
     // backgroundColor: Colors.grey.shade100,
      backgroundColor:AppColors.white,

      child: Icon(
        Icons.keyboard_arrow_down,
        size: 25.sp,
        color: AppColors.softBlue,
      ),
    );
 */
