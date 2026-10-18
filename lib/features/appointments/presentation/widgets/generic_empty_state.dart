import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/appointments/presentation/constants/empty_state_config.dart';

import '../../../../core/constants/themes/app_text_styles.dart';

class GenericEmptyState extends StatelessWidget {
  final String lottiePath;
  final String title;
  final String subtitle;
  final EmptyStateConfig config;

  const GenericEmptyState({
    super.key,
    required this.lottiePath,
    required this.title,
    required this.subtitle,
    this.config = const EmptyStateConfig(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(config.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            lottiePath,
            width: config.lottieSize.w,
            height: config.lottieSize.h,
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: context.textTheme.titleStyle.copyWith(
              fontSize: config.titleSize,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              subtitle,
              style: context.textTheme.subTitle.copyWith(
                fontSize: config.subtitleSize,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
