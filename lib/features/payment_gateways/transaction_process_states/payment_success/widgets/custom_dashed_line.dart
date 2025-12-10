import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/themes/app_colors.dart';

class CustomDashedLine extends StatelessWidget {
  const CustomDashedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: List.generate(
          60,
          (index) => Container(
            width: 5,
            height: 2,
            decoration: BoxDecoration(
              color: index.isEven ? AppColors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(50.r),
            ),
          ),
        ),
      ),
    );
  }
}

/*
  return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth; // عرض الشاشة المتاح
        double referenceWidth =
            360; // العرض المرجعي للهاتف الذي يظهر عليه 66 عنصرًا
        int baseItemCount = 66; // عدد العناصر في الهاتف المرجعي

        // حساب عدد العناصر بشكل متجاوب بناءً على نسبة من عرض الجهاز
        int itemCount =
            ((screenWidth / referenceWidth) * baseItemCount).round();

        double containerWidth = 5; // عرض كل عنصر

        print('object: $itemCount');
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
            itemCount + 3,
            (index) => Container(
              width: containerWidth,
              height: 2,
              decoration: BoxDecoration(
                color:
                    index.isEven ? AppColorManager.colorDashLine  : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        );
      },
    );
 */
