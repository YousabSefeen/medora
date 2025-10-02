import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/themes/app_colors.dart';

class AuthStyledContainer extends StatelessWidget {
  final Widget body;

  const AuthStyledContainer({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: AppColors.darkBlue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.r),
              topRight: Radius.circular(25.r),
            ),
          ),
        shadows: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 2,
            spreadRadius: 4,
          )
        ]
      ),
      child: body,
    );
  }
}
