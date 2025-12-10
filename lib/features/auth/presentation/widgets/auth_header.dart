import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_duration/app_duration.dart';

class AuthHeader extends StatelessWidget {
  final bool isLogin;

  const AuthHeader({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: AppDurations.milliseconds_1200,
            child: Text(
              isLogin ? 'Welcome back!' : 'Let’s get you started!',
              style: GoogleFonts.poppins(
                fontSize: 22.sp,
                color: Colors.white70,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            'MediLink',
            style: GoogleFonts.poppins(
              fontSize: 36.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 2,
            ),
          ),
          FadeInUp(
            duration: AppDurations.milliseconds_1200,
            child: Text(
              isLogin
                  ? 'Access your appointments and connect with trusted healthcare professionals.'
                  : 'Join MediLink to easily find and book appointments with the right specialists.',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                color: Colors.white70,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
