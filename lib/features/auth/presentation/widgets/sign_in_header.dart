import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_duration/app_duration.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInDown(
            duration: AppDurations.milliseconds_1200,
            child: Text(
              AppStrings.signInWelcomeBack,
              style: context.textTheme.headerSubtitle,
            ),
          ),
          Text(AppStrings.appName, style: context.textTheme.headerTitle),

          FadeInUp(
            duration: AppDurations.milliseconds_1200,
            child: Text(
              AppStrings.signInDescription,
              style: context.textTheme.headerDescription,
            ),
          ),
        ],
      ),
    );
  }
}
