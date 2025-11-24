import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/extensions/list_string_extension.dart';

class DoctorSpecialties extends StatelessWidget {
  final List<String> specialties;
  final double fontSize;

  const DoctorSpecialties({
    super.key,
    required this.specialties,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final specialtiesText = specialties.buildJoin();

    return Text(
      specialtiesText,
      style: Theme.of(context).listTileTheme.subtitleTextStyle!.copyWith(
        fontSize: fontSize.sp,
        height: 1.3,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w400,
        color: Colors.black54,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
