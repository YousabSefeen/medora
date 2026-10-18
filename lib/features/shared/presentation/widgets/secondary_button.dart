import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/themes/app_colors.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 50,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            elevation: 0,
            foregroundColor: AppColors.darkBlue,
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          onPressed: () => context.pop(),
          child: const Text(AppStrings.cancel),
        ),
      ),
    );
  }
}
