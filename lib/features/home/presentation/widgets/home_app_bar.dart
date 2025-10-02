import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(

      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.person, color: Colors.black),
      title: Text(
        'Good Morning!',
        style: Theme.of(context)
            .listTileTheme
            .titleTextStyle!
            .copyWith(color: AppColors.softBlue),
      ),
      subtitle: const Text('Yousab Sefeen'),
      tileColor: AppColors.white,
      trailing: const Icon(Icons.notifications, color: Colors.black),
    );
  }
}
