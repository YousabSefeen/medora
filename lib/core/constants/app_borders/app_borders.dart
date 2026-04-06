import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class AppBorders {
  static const double _defaultBorderWidth = 1.2;
  static final double _defaultRadius = 8.r;

  static final BorderRadius defaultBorderRadius = BorderRadius.circular(
    _defaultRadius,
  );

  static final Border normalBorder = Border.all(
    color: AppColors.fieldBorderColor,
    width: _defaultBorderWidth,
  );

  static final Border errorBorder = Border.all(
    color: AppColors.red,
    width: _defaultBorderWidth,
  );

  static final OutlineInputBorder inputEnabledBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: const BorderSide(
      color: AppColors.fieldBorderColor,
      width: _defaultBorderWidth,
    ),
  );

  static final OutlineInputBorder inputErrorBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: const BorderSide(
      color: AppColors.red,
      width: _defaultBorderWidth,
    ),
  );

  static final OutlineInputBorder inputFocusedBorder = OutlineInputBorder(
    borderRadius: defaultBorderRadius,
    borderSide: const BorderSide(color: AppColors.softBlue, width: 1.5),
  );
}
