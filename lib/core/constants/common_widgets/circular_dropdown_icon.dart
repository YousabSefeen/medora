import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/app_colors.dart';

class CircularDropdownIcon extends StatelessWidget {
  final VoidCallback? onPressed;

  const CircularDropdownIcon({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.only(right: 5),
      icon: CircleAvatar(
        radius: 12.r,
        backgroundColor: Colors.black54,

        child: FaIcon(
          FontAwesomeIcons.circleChevronDown,
          color: AppColors.white,
          size: 15.sp,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
