import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class ViewAllSpecialties extends StatelessWidget {
  const ViewAllSpecialties({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.grey),

        minimumSize: MaterialStateProperty.all(Size.zero),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.center,
        mouseCursor: WidgetStateProperty.all(SystemMouseCursors.click),
        foregroundColor: WidgetStateProperty.all(AppColors.lightBlue),
        textStyle: WidgetStateProperty.all(
          GoogleFonts.playpenSans(
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlue,
            fontSize: 11.sp,
          ),
        ),
      ),
      child: Text(AppStrings.viewAll),
      onPressed: () {
        print('ViewAllSpecialties.build');
        // AppRouter.push(context, const DoctorSpecialtiesScreen());
      },
    );
  }
}
