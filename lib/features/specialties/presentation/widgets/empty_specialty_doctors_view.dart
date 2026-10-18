import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/generated/assets.dart';

import '../../../../core/constants/app_strings/app_strings.dart';

class EmptySpecialtyDoctorsView extends StatelessWidget {
  final String specialtyName;

  const EmptySpecialtyDoctorsView({super.key, required this.specialtyName});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.stethoscope.image(
              fit: BoxFit.cover,
              height: context.screenHeight * 0.35,
            ),
            const SizedBox(height: 16),
            AutoSizeText(
              AppStrings.noSpecialtyDoctorsYet(specialtyName),
              style: context.textTheme.titleStyle.copyWith(fontSize: 18.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.workingToAddSpecialists,
              textAlign: TextAlign.center,
              style: context.textTheme.subTitle.copyWith(fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
