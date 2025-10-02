import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10,  bottom: 5,left: 5),
      child: Text(
        title,
        style: Theme.of(context).textTheme.mediumBlack.copyWith(fontSize: 13.sp),
      ),
    );
  }
}
