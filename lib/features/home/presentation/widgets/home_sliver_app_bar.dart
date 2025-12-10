import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/themes/app_colors.dart' show AppColors;
import 'package:medora/features/home/presentation/constants/home_constants.dart'
    show HomeConstants;
import 'package:medora/features/home/presentation/widgets/home_app_bar.dart'
    show HomeAppBar;
import 'package:medora/generated/assets.dart' show Assets;

class HomeSliverAppBar extends StatelessWidget {
  const HomeSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    final deviceHeight = deviceSize.height;

    return SliverAppBar(
      pinned: true,

      titleSpacing: 0,
      floating: false,

      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: const HomeAppBar(),
      ),
      elevation: 0,
      toolbarHeight: HomeConstants.appBarHeight,
      expandedHeight: deviceHeight * 0.2 + kToolbarHeight,

      backgroundColor: AppColors.customWhite,

      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: EdgeInsets.only(
            top: 15.h + kToolbarHeight,
            right: 10,
            left: 10,
          ),
          child: Image.asset(Assets.imagesAiDoctor, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
