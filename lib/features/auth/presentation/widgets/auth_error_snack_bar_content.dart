import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/themes/app_colors.dart';

class AuthErrorSnackBarContent extends StatelessWidget {
  final String errorMessage;

  const AuthErrorSnackBarContent({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),

      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.red, AppColors.primaryColor],
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
              boxShadow: [BoxShadow(color: Colors.white, blurRadius: 1)],
            ),

            child: FaIcon(
              FontAwesomeIcons.xmark,
              color: AppColors.white,
              size: 16.sp,
            ),
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Text(
              errorMessage,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
