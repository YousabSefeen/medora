import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/extensions/list_string_extension.dart';

class DoctorSpecialties extends StatelessWidget {
  final List<String> specialties;

  const DoctorSpecialties({super.key, required this.specialties});

  @override
  Widget build(BuildContext context) {
    final specialtiesText = specialties.buildJoin();

    return Text(
      specialtiesText,
      style: Theme.of(
        context,
      ).listTileTheme.subtitleTextStyle!.copyWith(fontSize: 13.sp),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
