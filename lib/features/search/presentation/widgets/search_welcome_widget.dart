import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';

import 'package:medora/generated/assets.dart';

class SearchWelcomeWidget extends StatelessWidget {
  const SearchWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 30,
        children: [
          SizedBox(
            height: 150.h,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Assets.images.stethoscope.image(
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            AppStrings.searchEmptyMessage,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              color: Colors.grey.shade800,
              height: 1.9,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
