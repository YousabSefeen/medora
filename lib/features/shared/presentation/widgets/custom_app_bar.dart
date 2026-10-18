import 'package:flutter/material.dart';

import '../../../../core/constants/themes/app_colors.dart';
import '../../../../core/constants/themes/app_text_styles.dart';
import '../../../../core/extensions/theme_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.leading,
    this.backgroundColor = AppColors.customWhite,
  });

  static SliverAppBar sliver({
    required String title,
    required BuildContext context,
    bool pinned = true,
    List<Widget>? actions,
    Widget? leading,
    Color backgroundColor = AppColors.customWhite,
  }) => SliverAppBar(
    key: ValueKey(title),
    pinned: pinned,
    backgroundColor: backgroundColor,
    elevation: 0,
    centerTitle: true,
    title: Text(title, style: context.textTheme.appBarTitleStyle),
    actions: actions,
    leading: leading,
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: ValueKey(title),
      backgroundColor: backgroundColor,
      elevation: 0,
      centerTitle: centerTitle,
      title: Text(title, style: context.textTheme.appBarTitleStyle),
      actions: actions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
