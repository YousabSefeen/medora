import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart';
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';
import 'package:medora/core/extensions/theme_extension.dart';
import 'package:medora/features/home/presentation/constants/bottom_nav_constants.dart';
import 'package:medora/features/home/presentation/controller/cubits/bottom_nav_cubit.dart';
import 'package:medora/features/home/presentation/controller/states/bottom_nav_state.dart';

class CustomAnimatedBottomBar extends StatelessWidget {
  final AnimationController hideAnimationController;

  const CustomAnimatedBottomBar({
    super.key,
    required this.hideAnimationController,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        buildWhen: (prev, curr) => prev.index != curr.index,
        builder: (context, state) {
          return AnimatedBottomNavigationBar.builder(
            itemCount: BottomNavConstants.iconList.length,
            tabBuilder: (int index, bool isActive) => _BottomNavTab(
              iconData: BottomNavConstants.iconList[index],
              title: BottomNavConstants.titles[index],
              isActive: isActive,
            ),
            backgroundColor: AppColors.softBlue,
            activeIndex: state.index,
            onTap: (index) =>
                context.read<BottomNavCubit>().changeTabIndex(index),
            hideAnimationController: hideAnimationController,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.defaultEdge,
            leftCornerRadius: 0,
            rightCornerRadius: 0,
          );
        },
      ),
    );
  }
}

class _BottomNavTab extends StatelessWidget {
  final FaIconData iconData;
  final String title;
  final bool isActive;

  const _BottomNavTab({
    super.key,
    required this.iconData,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isActive ? 5 : 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 2,
        children: [
          FaIcon(iconData, color: AppColors.white, size: 22.sp),

          if (isActive) _buildTextContent(context),
        ],
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final textWidget = Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: context.textTheme.mediumWhiteBold16.copyWith(fontSize: 13.sp),
    );

    if (title == AppStrings.appointments) {
      return FittedBox(child: textWidget);
    }
    return textWidget;
  }
}
