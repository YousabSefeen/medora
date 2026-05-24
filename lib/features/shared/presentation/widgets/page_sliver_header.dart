import 'package:flutter/material.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;

class PageSliverHeader extends StatelessWidget {
  final String title;

  const PageSliverHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      key: ValueKey(title),
      pinned: true,
      backgroundColor: AppColors.customWhite,
      title: Text(title),
    );
  }
}
