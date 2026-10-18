import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';

class SeeAllSpecialties extends StatelessWidget {
  const SeeAllSpecialties({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      label: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 13,
        color: AppColors.softBlue,
      ),
      style: _buildButtonStyle(),
      onPressed: () => _navigateToSpecialties(context),
      icon: const Text(AppStrings.seeAll),
    );
  }

  ButtonStyle _buildButtonStyle() => TextButton.styleFrom(
    backgroundColor: AppColors.customWhite,
    foregroundColor: AppColors.softBlue,
    elevation: 0,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: Size.zero,
    padding: EdgeInsets.zero,
    enabledMouseCursor: SystemMouseCursors.click,
    overlayColor: AppColors.black,
    textStyle: GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: 13.sp,
    ),
  );

  void _navigateToSpecialties(BuildContext context) =>
      context.push(AppRouterNames.medicalSpecialties);
}
