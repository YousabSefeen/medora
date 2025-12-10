import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorRating extends StatelessWidget {
  final double ratingValue;
  final double iconSize;
  final double fontSize;

  const DoctorRating({
    super.key,
    required this.ratingValue,
    required this.iconSize,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.star, color: Colors.amber, size: iconSize.sp),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            '($ratingValue reviews)',
            style: TextStyle(fontSize: fontSize.sp, color: Colors.black54),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
