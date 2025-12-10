import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/constants/app_routes/app_router.dart';
import '../../../../../core/constants/app_routes/app_router_names.dart';

class RegisterErrorSnackBarContent extends StatelessWidget {
  final String errorMessage;
  final String userEmail;

  const RegisterErrorSnackBarContent({
    super.key,
    required this.errorMessage,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            errorMessage,
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 1.6,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            AppRouter.pushNamedAndRemoveUntil(
              context,
              AppRouterNames.login,
              arguments: userEmail,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            // لون النص
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // شكل الزر
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 5,
          ),
          child: Text('Sign In'),
        ),
      ],
    );
  }
}
