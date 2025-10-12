

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';


class AveragePriceInfo extends StatelessWidget {
  const AveragePriceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme=Theme.of(context).textTheme;
    return  Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '💰',
              style: TextStyle(fontSize: 20.sp),
            ),
            TextSpan(
              text: 'Average consultation: 300-500 EGP',
              style: textTheme.largeWhiteSemiBold.copyWith(
                color: Colors.white70,
                fontSize: 12,fontWeight: FontWeight.w400,

              ),

            ),
          ],
        ),
      ),
    );
  }
}
