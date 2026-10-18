import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/themes/app_colors.dart';

import '../../domain/entities/specialty_entity.dart';

class SpecialtyCardItem extends StatelessWidget {
  final SpecialtyEntity specialty;

  const SpecialtyCardItem({super.key, required this.specialty});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          context.push(AppRouterNames.specialtyDoctors, extra: specialty.name),
      child: Container(
        constraints: BoxConstraints(minWidth: 90.w, maxWidth: 95.w),
        margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        padding: EdgeInsets.only(top: 10.h, left: 6.w, right: 6.w, bottom: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.softBlue.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50.r,
              height: 50.r,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.softBlue.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                specialty.imageUrl,
                colorFilter: const ColorFilter.mode(
                  AppColors.softBlue,
                  BlendMode.srcIn,
                ),
              ),
            ),

            Expanded(
              child: Center(
                child: AutoSizeText(
                  specialty.name,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F2B48),
                      height: 1.3,
                    ),
                  ),
                  maxLines: 2,
                  minFontSize: 9,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
