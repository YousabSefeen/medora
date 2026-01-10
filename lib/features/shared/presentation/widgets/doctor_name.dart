import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/string_extensions.dart';

class DoctorName extends StatelessWidget {
  final String name;
  final double fontSize;

  const DoctorName({super.key, required this.name, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      name.toCapitalizeFirstLetter(),
      style: Theme.of(context).textTheme.mediumBlack.copyWith(
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
