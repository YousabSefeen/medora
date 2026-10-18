import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

extension AppTextStyles on TextTheme {
  // Original: headlineMedium (DoctorAvailabilityTimeFields)

  TextStyle get appBarTitleStyle => GoogleFonts.poppins(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600, // SemiBold ناعم
    color: const Color(0xFF1E293B), // Slate Navy الداكن المعتمد للعناوين
    letterSpacing: -0.2,
  );
  TextStyle get mediumBlackBold => TextStyle(
    fontSize: 15.sp,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    height: 1,
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

  TextStyle get largeInterBold => GoogleFonts.inter(
    color: Colors.black,
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
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

  TextStyle get errorFieldStyle => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.red,
    letterSpacing: 0.2,
  );

  TextStyle get hintFieldStyle => GoogleFonts.roboto(
    fontSize: 12.sp,
    letterSpacing: 0.5,
    height: 1.5,
    color: Colors.grey.shade600,
  );

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
    color: AppColors.darkBlue,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
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

  TextStyle get robotoMediumStyle => GoogleFonts.roboto(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: Colors.white,
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

  TextStyle get poppinsSemiBoldDark => GoogleFonts.poppins(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
    letterSpacing: 0.5,
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

  TextStyle get arabicStyle => GoogleFonts.cairo(
    wordSpacing: 1.2,
    fontSize: 16.sp,
    color: Colors.black,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  TextStyle get linkTextStyle => TextStyle(
    fontSize: 18.sp,
    color: AppColors.lightBlue,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  TextStyle get headlineMediumEx => GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 20.sp,
      fontWeight: FontWeight.w700,
    ),
  );

  TextStyle get bodyMediumEx => TextStyle(
    color: Colors.black54,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // 1. للنصوص الترحيبية أو العناوين الفرعية (مثل Welcome back!)
  TextStyle get headerSubtitle => GoogleFonts.poppins(
    fontSize: 22.sp,
    color: Colors.white70,
    fontWeight: FontWeight.w400,
  );

  // 2. للعنوان الرئيسي (مثل MediLink)
  TextStyle get headerTitle => GoogleFonts.poppins(
    fontSize: 36.sp,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    height: 2,
  );

  // 3. لنصوص الوصف والشرح (مثل وصف التطبيق في كلا الشاشتين)
  TextStyle get headerDescription => GoogleFonts.poppins(
    fontSize: 16.sp,
    color: Colors.white70,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  TextStyle get authButton => GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
    ),
  );

  TextStyle get forgotButton => TextStyle(
    color: Colors.blue,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  TextStyle get authFieldTitle => TextStyle(
    color: Colors.white60,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
  );

  // 🌟 الستيلات المستخرجة حديثاً لشاشات الـ Auth والاستعادة:

  // للـ Main Headers الكبيرة باللون الأبيض
  TextStyle get largeWhiteBold => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Original: titleSmall
  TextStyle get smallGreyMedium => TextStyle(
    fontSize: 12.sp,
    color: Colors.grey[500],
    fontWeight: FontWeight.w400,
    height: 1.5,
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

  // للنصوص الوصفية الأساسية باللون الرمادي الفاتح
  TextStyle get mediumLightGreyRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: const Color(0xffE0E0E0),
    height: 1.5,
  );

  // للنصوص الوصفية العريضة (مثل بريد المستخدم البارز)
  TextStyle get mediumLightGreyBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: const Color(0xffE0E0E0),
    height: 1.5,
  );

  // للنصوص الإرشادية بلون التنبيه (Amber/Gold)
  TextStyle get smallAmberMedium => TextStyle(
    fontSize: 13.sp,
    color: const Color(0xffFFB300),
    fontWeight: FontWeight.w500,
  );

  // للنصوص الفرعية الخفيفة باللون الرمادي الشفاف (مثل سطر العبد التنازلي)
  TextStyle get mediumWhite60Regular => TextStyle(
    color: Colors.grey.shade300,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );

  TextStyle get mediumWhiteBold16 => TextStyle(
    fontSize: 16.sp,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  TextStyle get mediumBlackBold16 => TextStyle(
    fontSize: 16.sp,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );

  TextStyle get overlayNotificationStyle => TextStyle(
    fontSize: 13.sp,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  TextStyle get largeBlack => TextStyle(
    fontSize: 40.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  TextStyle get subTitle => TextStyle(
    color: Colors.grey.shade600, // Replace with AppColors.customBlueGrey
    fontWeight: FontWeight.w500,
    height: 1.9,
  );

  TextStyle get subTitleX => TextStyle(
    fontSize: 13.sp,
    color: Colors.grey.shade700,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  TextStyle get title => TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  TextStyle get subtitle => TextStyle(
    fontSize: 12.sp,
    color: Colors.grey.shade600,
    height: 1.5,
    fontWeight: FontWeight.w400,
  );

  TextStyle get trailingText => TextStyle(
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.softBlue,
  );

  TextStyle get titleStyle => GoogleFonts.poppins(
    textStyle: const TextStyle(
      color: Colors.black, // Replace with AppColors.darkBlue
      height: 1.9,
      fontWeight: FontWeight.w600,
    ),
  );

  TextStyle get doctorName => GoogleFonts.inter(
    fontSize: 16.sp,
    color: Colors.black,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
  );
}
