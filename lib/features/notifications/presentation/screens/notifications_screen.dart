import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: AppColors.white),
        title: const Text(AppStrings.notifications),
        titleTextStyle: Theme.of(
          context,
        ).appBarTheme.titleTextStyle!.copyWith(color: AppColors.white),
        backgroundColor: AppColors.softBlue,
        centerTitle: true,
      ),
    );
  }
}
