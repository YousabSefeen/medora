import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical  : 30),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(180),

        ),
        shadows: const [
          BoxShadow(
              color: Colors.white,
              blurRadius: 50,
              offset: Offset(0, 1),
              spreadRadius: 25,
          ),

        ],
      ),
      child: CircleAvatar(
        radius: 40.r,
        backgroundColor: const Color(0xff34A853),
        child: Icon(
          FontAwesomeIcons.check,
          color: Colors.white,
          size: 45.sp,
        ),
      ),
    );
  }
}
