


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// نقوم بإضافة ميزة التشييد التلقائي لملفات الـ String لتشبه كود الـ Plugin
extension LottieStringAssetExtension on String {
  Widget lottie({
    BoxFit? fit,
    double? width,
    double? height,
  }) {
    return Lottie.asset(
      this, // تعود على مسار الـ String نفسه
      fit: fit,
      width: width,
      height: height,
    );
  }
}