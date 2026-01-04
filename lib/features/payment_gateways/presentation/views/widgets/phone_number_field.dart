import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'country_code_with_flag.dart';
import 'custom_animation_widget.dart';

class PhoneNumberField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneNumberField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      style: GoogleFonts.inter(
        fontSize: 14.sp,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      textAlignVertical: TextAlignVertical.center,
      cursorColor: Colors.black,
      cursorHeight: 20,
      cursorWidth: 2,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(width: 2),
        ),
        prefixIcon: const CountryCodeWithFlag(),
        fillColor: Colors.white,
        filled: true,
        hintText: '  Phone Number',
        hintStyle: GoogleFonts.poppins(
          fontSize: 12.sp,
          fontWeight: FontWeight.w700,
          color: Colors.grey.shade500,
          // letterSpacing: 1,
        ),
      ),
    );
  }
}
