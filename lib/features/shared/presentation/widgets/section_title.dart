import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../core/extensions/theme_extension.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: context.textTheme.authButton.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
        color: Colors.black,
      ),
    );
  }
}
