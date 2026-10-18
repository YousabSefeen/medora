import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../core/extensions/theme_extension.dart';

class DoctorDetailsSection extends StatelessWidget {
  final List<String> specialties;
  final String bio;
  final List<String> workingDays;
  final String workingHours;
  final String location;

  const DoctorDetailsSection({
    super.key,
    required this.specialties,
    required this.bio,
    required this.workingDays,
    required this.workingHours,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(context, AppStrings.aboutDoctor),
          SizedBox(height: 8.h),
          Text(bio, style: context.textTheme.subTitleX),
          SizedBox(height: 20.h),

          _buildSectionTitle(context, AppStrings.specialties),
          SizedBox(height: 10.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: specialties
                .map(
                  (specialty) => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.softBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      specialty,
                      style: context.textTheme.smallSoftBlueMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          SizedBox(height: 20.h),

          _buildSectionTitle(context, AppStrings.workingSchedule),
          SizedBox(height: 10.h),
          _buildInfoCard(
            context: context,
            icon: FontAwesomeIcons.calendarCheck,
            iconColor: Colors.orange.shade700,
            title: AppStrings.workingDays,
            subtitle: workingDays.join(', '),
            trailingText: workingHours,
          ),
          SizedBox(height: 12.h),

          _buildSectionTitle(context, AppStrings.clinicLocation),
          SizedBox(height: 10.h),
          _buildInfoCard(
            context: context,
            icon: FontAwesomeIcons.locationDot,
            iconColor: Colors.redAccent,
            title: AppStrings.practiceAddress,
            subtitle: location,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) =>
      Text(title, style: context.textTheme.mediumBlackBold16);

  Widget _buildInfoCard({
    required BuildContext context,
    required FaIconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    String? trailingText,
  }) => Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: FaIcon(icon, color: iconColor, size: 18.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.textTheme.title),
              SizedBox(height: 2.h),
              Text(subtitle, style: context.textTheme.subtitle),
              if (trailingText != null) ...[
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 12.sp,
                      color: AppColors.softBlue,
                    ),
                    SizedBox(width: 4.w),

                    Text(trailingText, style: context.textTheme.trailingText),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}
