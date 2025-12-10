import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorIndicatorAvatar extends StatelessWidget {
  const ErrorIndicatorAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.redAccent, width: 5),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 29.r,
        child: FaIcon(
          FontAwesomeIcons.xmark,
          color: Colors.redAccent,
          size: 40.sp,
        ),
      ),
    );
  }
}
