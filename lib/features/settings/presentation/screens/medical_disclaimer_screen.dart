import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_strings/app_strings.dart';
import '../../../../core/constants/themes/app_colors.dart';
import '../../../shared/presentation/widgets/custom_app_bar.dart';

class MedicalDisclaimerScreen extends StatelessWidget {
  const MedicalDisclaimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      appBar: const CustomAppBar(title: AppStrings.disclaimerTitle),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),

                      // Header Badge / Icon
                      Container(
                        width: 80.r,
                        height: 80.r,
                        decoration: BoxDecoration(
                          color: AppColors.softBlue.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.userNurse,
                            size: 36.r,
                            color: AppColors.softBlue,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Subtitle Description
                      Text(
                        AppStrings.disclaimerSubtitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Disclaimer Item Cards
                      const _DisclaimerCard(
                        icon: FontAwesomeIcons.kitMedical,
                        iconColor: Color(0xFF0284C7),
                        title: AppStrings.disclaimerPoint1Title,
                        description: AppStrings.disclaimerPoint1Body,
                      ),
                      SizedBox(height: 14.h),

                      const _DisclaimerCard(
                        icon: FontAwesomeIcons.triangleExclamation,
                        iconColor: Color(0xFFEF4444),
                        title: AppStrings.disclaimerPoint2Title,
                        description: AppStrings.disclaimerPoint2Body,
                      ),
                      SizedBox(height: 14.h),

                      const _DisclaimerCard(
                        icon: FontAwesomeIcons.robot,
                        iconColor: Color(0xFF8B5CF6),
                        title: AppStrings.disclaimerPoint3Title,
                        description: AppStrings.disclaimerPoint3Body,
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),

              // Bottom Action Button
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () => context.pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.softBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.agreeAndContinue,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DisclaimerCard extends StatelessWidget {
  final FaIconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const _DisclaimerCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B4370).withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: FaIcon(icon, size: 20.r, color: iconColor),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
