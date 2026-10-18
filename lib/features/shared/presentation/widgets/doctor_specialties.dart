import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/list_string_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart';

class DoctorSpecialties extends StatelessWidget {
  final List<String> specialties;
final double? specialtiesFontSize;

  const DoctorSpecialties({super.key, required this.specialties, this.specialtiesFontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
     // specialties.buildJoin(),
      '${specialties[0]}',
      style: context.textTheme.smallGreyMedium.copyWith(
          fontSize: specialtiesFontSize,height: 1.7
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
