import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Configuration class to customize the appearance and behavior of DoctorCard / DoctorSearchCard
class DoctorCardConfig {
  final double imageSize;
  final double imageRadius;

  final bool showFavoriteButton;

  final double nameFontSize;

  final double specialtiesFontSize;

  final double ratingIconSize;

  final double ratingFontSize;

  final int specialtiesMaxLines;

  final double iconSize;

  final double textSize;

  const DoctorCardConfig({
    required this.imageSize,
    required this.imageRadius,
    required this.showFavoriteButton,
    required this.nameFontSize,
    required this.specialtiesFontSize,
    required this.ratingIconSize,
    required this.ratingFontSize,
    this.specialtiesMaxLines = 2,

    required this.iconSize,
    required this.textSize,
  });

  factory DoctorCardConfig.defaultConfig() => DoctorCardConfig(
    imageSize: 80,
    imageRadius: 8,
    showFavoriteButton: true,
    nameFontSize: 18.sp,
    specialtiesFontSize: 13.sp,
    ratingIconSize: 16.sp,
    ratingFontSize: 12,
    iconSize: 16.sp,
    textSize: 12.sp,
  );

  factory DoctorCardConfig.homeSearchDoctorCardConfig() => DoctorCardConfig(
    imageSize: 50,
    imageRadius: 360,
    nameFontSize: 14.sp,
    specialtiesFontSize: 10.sp,
    showFavoriteButton: false,
    ratingIconSize: 14,
    ratingFontSize: 10,

    iconSize: 14.sp,
    textSize: 10.sp,
  );
}
