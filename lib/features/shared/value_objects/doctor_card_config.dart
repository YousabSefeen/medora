import 'package:flutter/material.dart';


/// Configuration class to customize the appearance and behavior of DoctorCard / DoctorSearchCard
class DoctorCardConfig {
  /// حجم صورة الطبيب (عرض × ارتفاع)
  final double imageSize;
  final double imageRadius;

  /// هل يتم إظهار زر المفضلة أم لا
  final bool showFavoriteButton;

  /// حجم خط اسم الطبيب
  final double nameFontSize;

  /// حجم خط التخصصات
  final double specialtiesFontSize;

  /// حجم أيقونة التقييم
  final double ratingIconSize;

  /// حجم خط التقييم
  final double ratingFontSize;

  /// عدد الأسطر المسموح بها لعرض التخصصات
  final int specialtiesMaxLines;

  /// عدد الأسطر المسموح بها لعرض الموقع والرسوم
  final int footerMaxLines;

  const DoctorCardConfig({
    required this.imageSize,
    required this.imageRadius,
    required this.showFavoriteButton,
    required this.nameFontSize,
    required this.specialtiesFontSize,
    required this.ratingIconSize,
    required this.ratingFontSize,
    this.specialtiesMaxLines = 2,
    this.footerMaxLines = 1,
  });
}
