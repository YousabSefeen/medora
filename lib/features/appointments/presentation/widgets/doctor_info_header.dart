import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/features/shared/data/models/doctor_model.dart'
    show DoctorModel;
import 'package:medora/features/shared/domain/entities/doctor_entity.dart' show DoctorEntity;

class DoctorInfoHeader extends StatelessWidget {
  final DoctorEntity doctorInfo;

  const DoctorInfoHeader({super.key, required this.doctorInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _customRichText(
          context: context,
          title: 'Specialties: ',
          info: doctorInfo.specialties.join(', '),
        ),
        _customRichText(
          context: context,
          title: '${AppStrings.bioLabel}: ',
          info: doctorInfo.bio,
        ),

        _customRichText(
          context: context,
          title: '${AppStrings.workingDays}: ',

          info: getWorkingDays(),
        ),
      ],
    );
  }

  String getWorkingDays() => doctorInfo.doctorAvailability.workingDays
      .toString()
      .replaceAll('[', '')
      .replaceAll(']', '');

  RichText _customRichText({
    required BuildContext context,
    required String title,
    required String info,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: textTheme.mediumPlaypenBold.copyWith(
              color: AppColors.softBlue,
            ),
          ),
          TextSpan(
            text: info,
            style: TextStyle(
              fontSize: 14.sp,

              color: AppColors.black,
              letterSpacing: 1,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
