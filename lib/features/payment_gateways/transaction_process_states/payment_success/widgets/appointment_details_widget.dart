import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/media_query_extension.dart';
import 'package:medora/core/extensions/theme_extension.dart';

class AppointmentDetailsWidget extends StatelessWidget {
  final String label;
  final String value;

  const AppointmentDetailsWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final latoSemiBoldDark = context.textTheme.latoSemiBoldDark;
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.screenWidth * 0.32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: latoSemiBoldDark),
                Text(
                  ':   ',
                  style: latoSemiBoldDark.copyWith(
                    fontWeight: FontWeight.w900,
                    shadows: [],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Text(
              value,
              style: context.textTheme.robotoMediumStyle.copyWith(
                fontSize: 16.sp,
                letterSpacing: 0.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
