import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../../generated/assets.dart';

class DoctorLocationDisplay extends StatelessWidget {
  final String location;

  const DoctorLocationDisplay({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade300,
      child: Row(
        spacing: 10,
        children: [
          // Material(
          //   color: Colors.white,
          //   child: Lottie.asset(
          //     Assets.imagesLocation,
          //     fit: BoxFit.fill,
          //     height: 55
          //   ),
          // ),


          Text(location,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: Colors.black87,
              )),
        ],
      ),
    );
  }
}
