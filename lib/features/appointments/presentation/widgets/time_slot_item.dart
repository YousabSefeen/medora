import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../core/constants/themes/app_colors.dart';

class TimeSlotItem extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onTap;

  const TimeSlotItem({
    super.key,
    required this.time,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: _itemDecoration(),
        child: Text(time, style: _itemTextStyle(context)),
      ),
    );
  }

  BoxDecoration _itemDecoration() {
    return BoxDecoration(
      color: isSelected ? Colors.green : Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.black12),
    );
  }

  TextStyle _itemTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.mediumBlackBold.copyWith(
      fontSize: 13.sp,
      color: isSelected ? Colors.white : AppColors.black,
    );
  }
}
