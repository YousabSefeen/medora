import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeConstants {
  const HomeConstants._();

  // Layout Dimensions
  static const double appBarHeight = 60.0;
  static const double appBarIconSize = 33.0;
  static const double elevation = 3.0;
  static const Color backgroundColor = Colors.white;

  // Responsive dimensions
  static double appBarWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.84;

  static const double barContentHeight = appBarHeight - 10;

  static double get iconSize => 15.0.sp;

  static EdgeInsets get homeBodyPadding =>
      EdgeInsets.symmetric(horizontal: 15.w);

  // Decorations
  static BoxDecoration createBarActionDecoration({required bool hasShadow}) =>
      BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: hasShadow ? _createBoxShadow() : const [],
      );

  static List<BoxShadow> _createBoxShadow() => const [
    BoxShadow(
      color: Colors.blueAccent,
      spreadRadius: 1,
      blurRadius: 2,
      offset: Offset(0, 1),
    ),
  ];
}
