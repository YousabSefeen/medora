import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_routes/app_router.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart'
    show AppRouterNames;
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class SeeAllSpecialties extends StatelessWidget {
  const SeeAllSpecialties({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _buildButtonStyle(),
      onPressed: () => _navigateToSpecialties(context),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(AppStrings.seeAll),
      ),
    );
  }

  ButtonStyle _buildButtonStyle() => TextButton.styleFrom(
    backgroundColor: Colors.grey.shade100,
    foregroundColor: AppColors.blueShadowHeader,
    elevation: 1,
    shadowColor: AppColors.lightBlue.withValues(alpha: 0.4),
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: Size.zero,
    padding: EdgeInsets.zero,
    enabledMouseCursor: SystemMouseCursors.click,
    overlayColor: AppColors.black,
    textStyle: GoogleFonts.caladea(
      fontWeight: FontWeight.w600,
      fontSize: 14.sp,
    ),
  );

  void _navigateToSpecialties(BuildContext context) =>
      AppRouter.pushNamed(context, AppRouterNames.medicalSpecialties);
}
