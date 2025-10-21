import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart';

class BottomNavTab extends StatelessWidget {
  const BottomNavTab({
    super.key,
    required this.iconData,
    required this.title,
    required this.isActive,
  });

  final IconData iconData;
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isActive
          ? const EdgeInsets.symmetric(vertical: 5)
          : EdgeInsets.zero,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 2,
        children: [
          Icon(iconData, color: AppColors.white, size: 22.sp),
          !isActive
              ? const SizedBox.shrink()
              : Expanded(
                  child: FittedBox(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
