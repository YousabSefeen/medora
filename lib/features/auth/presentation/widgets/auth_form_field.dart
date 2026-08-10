import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';

class AuthFormField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final double? titleFontSize;
  final double? verticalPadding;

  const AuthFormField({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.validator,
    this.titleFontSize = 14.0,
    this.verticalPadding = 14.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h, top: 4.h),
          child: Text(
            title,
            style: context.textTheme.extraLargeWhiteBold.copyWith(
              fontSize:titleFontSize!.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: context.textTheme.styleInputField.copyWith(
            color: Colors.white,
            letterSpacing: 0.2,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.white30,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,

            fillColor: const Color(0xFF0A192F).withValues(alpha: 0.5),
            prefixIcon: Icon(prefixIcon, color: Colors.white60, size: 20.sp),
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(vertical: verticalPadding!),

            errorStyle: TextStyle(
              color: AppColors.authErrorColor,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white, width: 1.2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.white24, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.authErrorColor,
                width: 1,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.authErrorColor,
                width: 1.5,
              ),
            ),
          ),
        ),
        SizedBox(height: 14.h),
      ],
    );
  }
}
