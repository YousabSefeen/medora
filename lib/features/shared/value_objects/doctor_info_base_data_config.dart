import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Configuration class to customize the appearance and behavior of DoctorCard / DoctorSearchCard
class DoctorInfoBaseDataConfig {
  final double imageSize;
  final double baseWidthPadding;

  final bool showFavoriteButton;

  final double nameFontSize;

  final double specialtiesFontSize;
  final double specialtiesFontHeight;

  final double ratingIconSize;

  final double ratingFontSize;
  final double locationIconSize;
  final double locationFontSize;

  final int specialtiesMaxLines;

  final double iconSize;

  final double textSize;

  const DoctorInfoBaseDataConfig({
    required this.imageSize,
    required this.baseWidthPadding,
    required this.showFavoriteButton,
    required this.nameFontSize,
    required this.specialtiesFontSize,
    required this.specialtiesFontHeight,
    required this.ratingIconSize,
    required this.ratingFontSize,
    required this.locationIconSize,
    required this.locationFontSize,
    this.specialtiesMaxLines = 2,

    required this.iconSize,
    required this.textSize,
  });

  factory DoctorInfoBaseDataConfig.defaultConfig() => DoctorInfoBaseDataConfig(
    imageSize: 80,
    baseWidthPadding: 12.w,
    showFavoriteButton: true,
    nameFontSize: 16.sp,
    specialtiesFontSize: 11.sp,
    specialtiesFontHeight: 0,
    ratingIconSize: 11.sp,
    ratingFontSize: 12.sp,
    locationIconSize: 14.sp,
    locationFontSize: 11.sp,
    iconSize: 16.sp,
    textSize: 12.sp,

  );

  factory DoctorInfoBaseDataConfig.homeSearchDoctorCardConfig() => DoctorInfoBaseDataConfig(
    imageSize: 50.r,
    baseWidthPadding: 10.w,
    nameFontSize: 15.sp,
    specialtiesFontSize: 11.sp,
    specialtiesFontHeight: 1.5,
    ratingIconSize: 11.sp,
    ratingFontSize: 12.sp,
    locationIconSize: 14 .sp,
    locationFontSize: 11.sp,
    iconSize: 16.sp,
    textSize: 12.sp, showFavoriteButton: false,
  );
}
