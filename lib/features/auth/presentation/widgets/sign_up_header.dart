import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/generated/assets.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Assets.svg.appLogo.svg(
          width: context.screenWidth * 0.5,

          color: Colors.white,
          fit: BoxFit.cover,
        ),

        Text(
          AppStrings.signUpDescription,
          textAlign: TextAlign.center,
          style: context.textTheme.headerDescription.copyWith(fontSize: 12.sp),
        ),
      ],
    );
  }
}
