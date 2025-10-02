import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/features/doctor_profile/presentation/widgets/section_title.dart' show SectionTitle;
import 'package:medora/features/doctor_profile/presentation/widgets/work_hours_section.dart' show WorkHoursSection;
import 'package:medora/features/doctor_profile/presentation/widgets/working_days_section.dart' show WorkingDaysSection;

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/themes/app_colors.dart';
import 'form_title.dart';

class WeeklyScheduleCard extends StatelessWidget {
  const WeeklyScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormTitle(label: AppStrings.weeklySchedule),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColors.customWhite,
          ),
          margin: const EdgeInsets.only(top: 5, bottom: 15),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: AppStrings.workingDays),
              WorkingDaysSection(),
              SectionTitle(title: AppStrings.workHours),
              WorkHoursSection(),
            ],
          ),
        ),
      ],
    );
  }
}
