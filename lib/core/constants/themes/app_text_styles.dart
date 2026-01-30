import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

extension AppTextStyles on TextTheme {
  // Original: headlineMedium (DoctorAvailabilityTimeFields)
  TextStyle get mediumBlackBold => TextStyle(
    fontSize: 15.sp,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    height: 1,
  );

  // Original: headlineSmall (DoctorAvailabilityTimeFields)
  TextStyle get mediumWhiteBold => TextStyle(
    color: Colors.white,
    fontSize: 17.sp,
    fontWeight: FontWeight.w700,
  );

  // Original: labelMedium (CustomDateTimeLine)
  TextStyle get smallWhiteRegular => TextStyle(
    fontSize: 12.sp,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  TextStyle get dateTimeBlackStyle => TextStyle(
    color: Colors.black,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle get smallBlack => const TextStyle(
    color: AppColors.black,
    height: 1.2,
    fontWeight: FontWeight.w600,
    fontSize: 10,
  );

  // Original: titleMedium (DoctorList info)
  TextStyle get mediumPlaypenBold => GoogleFonts.playpenSans(
    fontSize: 14.sp,
    height: 0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  // Original: bodySmall (AppointmentBookingScreen - CustomSliverAppBar)
  TextStyle get largeWhiteSemiBold => TextStyle(
    fontSize: 18.sp,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  // Original: bodyMedium (AppointmentBookingScreen - CustomSliverAppBar)
  TextStyle get extraLargeWhiteBold => GoogleFonts.playpenSans(
    fontSize: 22.sp,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  // Original: titleSmall
  TextStyle get smallGreyMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  // Original: titleLarge
  TextStyle get smallOrangeMedium => TextStyle(
    fontSize: 14.sp,
    color: Colors.black87,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  TextStyle get bodyMediumBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade900,
    letterSpacing: 1,
  );

  TextStyle get bodyRegular => TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: Colors.grey.shade700,
    letterSpacing: 1,
  );

  // Original: headlineLarge
  TextStyle get largeBlackBold => GoogleFonts.caladea(
    fontSize: 18.sp,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );

  TextStyle get caladeaWhite => GoogleFonts.caladea(
    color: AppColors.black,
    fontSize: 20.sp,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w600,
  );

  // Original: labelSmall (DoctorProfileFiled - hint)
  TextStyle get smallGreySemiBold => GoogleFonts.actor(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: Colors.grey.shade600,
  );

  // Original: labelLarge (DoctorProfileFiled - hint)
  TextStyle get largeActorBold => GoogleFonts.actor(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: Colors.black,
    letterSpacing: 1.5,
  );

  TextStyle get dialogTitleStyle => GoogleFonts.playpenSans(
    fontSize: 16.sp,
    letterSpacing: 1,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  TextStyle get labelFieldStyle => TextStyle(
    fontSize: 16.sp,
    color: Colors.grey.shade800,
    fontWeight: FontWeight.w600,
  );

  TextStyle get mediumBlack => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    letterSpacing: 0.5,
  );

  TextStyle get hintFieldStyle => GoogleFonts.roboto(
    fontSize: 12.sp,
    letterSpacing: 0.5,
    height: 1.5,
    color: Colors.grey.shade600,
  );

  //سسسس
  TextStyle get smallSoftBlueMedium => TextStyle(
    fontSize: 12.sp,
    color: AppColors.softBlue,
    height: 1.2,
    fontWeight: FontWeight.w500,
  );

  TextStyle get searchScreenTitle => GoogleFonts.caladea(
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 1,
    wordSpacing: 5,
  );

  TextStyle get styleInputField => TextStyle(
    color: Colors.black,
    fontSize: 16.sp,
    letterSpacing: 1.5,
    fontWeight: FontWeight.w500,
  );

  TextStyle get styleInputFieldError => TextStyle(
    color: Colors.red,
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
  );

  TextStyle get numbersStyle => GoogleFonts.roboto(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: Colors.black,
    letterSpacing: 0.5,
  );

  TextStyle get robotoBoldStyle => GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.2,
      color: Colors.white,
    ),
  );

  TextStyle get buttonStyle => GoogleFonts.poppins(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 1,
  );

  TextStyle get latoSemiBoldDark => GoogleFonts.lato(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      shadows: const [
        Shadow(color: Colors.black, blurRadius: 10),
        Shadow(color: Colors.black, blurRadius: 15, offset: Offset(0, 5)),
      ],
    ),
  );

  TextStyle get caladeaMediumLight => GoogleFonts.caladea(
    color: Colors.white,
    fontSize: 18.sp,

    letterSpacing: 1,
    fontWeight: FontWeight.w500,
  );
}
