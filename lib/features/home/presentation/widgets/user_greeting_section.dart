import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/home/presentation/constants/home_constants.dart';

class UserGreetingSection extends StatelessWidget {
  const UserGreetingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: HomeConstants.appBarWidth(context),
      height: HomeConstants.barContentHeight,
      child: Row(
        spacing: 10,
        children: [
          const Icon(Icons.person, color: Colors.black),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                'Good Morning!',
                style: Theme.of(context).listTileTheme.titleTextStyle!.copyWith(
                  color: AppColors.softBlue,
                ),
              ),
              const Text(
                'Yousab Sefeen',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
