import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/themes/app_colors.dart';

class CustomFormField extends StatelessWidget {
  final IconData icon;
  final String title;

  final TextEditingController controller;
  final TextInputType? keyboardType;

  final Widget? suffixIcon;
  final bool? obscureText;

  const CustomFormField({
    super.key,
    required this.icon,
    required this.title,
    required this.controller,
    required this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 17.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(
          height: 35.h,
          child: TextFormField(
            cursorWidth: 2.5,
            cursorHeight: 22,
            cursorColor: Colors.blueGrey,
            style: GoogleFonts.roboto(
              fontSize: 15.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
            keyboardType: keyboardType,
            controller: controller,
            obscureText: obscureText!,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 2),
              suffixIcon: suffixIcon,
              prefixIcon: Container(
                color: AppColors.darkBlue,
                margin: const EdgeInsets.only(right: 8),
                child: Icon(icon, size: 16.sp, color: Colors.white),
              ),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
