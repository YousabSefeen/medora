import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/enum/doctor_info_variant.dart';
import 'package:medora/core/extensions/string_extensions.dart';
import 'package:medora/core/extensions/theme_extension.dart';

class DoctorQuickStatsRow extends StatelessWidget {
  final int fee;
  final String location;

  const DoctorQuickStatsRow({
    super.key,
    required this.fee,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Location
        Icon(Icons.location_on_outlined, color: Colors.grey[500], size: 14.sp),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            location,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Price & Book Action

      ],
    );
  }
}

class _InfoRowItem extends StatelessWidget {
  final FaIconData icon;
  final double iconSize;
  final Color iconColor;
  final String value;
  final double textSize;

  const _InfoRowItem({
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    required this.value,
    required this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        FaIcon(icon, color: iconColor, size: iconSize),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: textSize,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
