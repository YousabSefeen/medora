import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FaIcon, FontAwesomeIcons;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class SelectionBadge extends StatelessWidget {
  const SelectionBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10.sp,
      backgroundColor: AppColors.softBlue,
      child: FaIcon(
        FontAwesomeIcons.circleCheck,
        size: 15.sp,
        color: AppColors.white,
      ),
    );
  }
}
