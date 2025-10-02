import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../core/constants/themes/app_colors.dart';



class StripePaymentMethodInfo extends StatelessWidget {
  const StripePaymentMethodInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
      margin: EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
                color: AppColors.softBlue,
                borderRadius: BorderRadius.circular(2.r)),
            child: FaIcon(
              FontAwesomeIcons.ccVisa,
              color: Colors.white,
              size: 35.sp,
            ),
          ),
          const SizedBox(width: 23),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Stripe\n', //
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const TextSpan(
                  text: '**** **** **** 2424',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 1.2,
                    height: 0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
