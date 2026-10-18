import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/extensions/string_extensions.dart';

import '../../../../core/constants/app_routes/app_router_names.dart';
import '../../../../core/enum/navigation_source.dart';
import '../../../favorites/presentation/widgets/toggle_favorite_button.dart';
import '../../domain/entities/doctor_entity.dart' show DoctorEntity;

class DoctorRating extends StatelessWidget {
  final double ratingValue;
  final int ratingCount;
  final double iconSize;
  final double fontSize;

  const DoctorRating({
    super.key,
    required this.ratingValue,
    required this.ratingCount,
    required this.iconSize,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: Colors.amber[800], size: iconSize.sp),
        SizedBox(width: 4.w),
        Text(
          ratingValue.toStringAsFixed(1),
          style: TextStyle(
            fontSize: fontSize.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '( $ratingCount Reviews)',
          style: TextStyle(
            fontSize: (fontSize - 1).sp,
            color: Colors.grey[800] ,
          ),
        ),
      ],
    );
  }
}





