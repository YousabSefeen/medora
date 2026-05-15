import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medora/core/constants/app_routes/app_router.dart'
    show AppRouter;
import 'package:medora/core/constants/app_routes/app_router_names.dart'
    show AppRouterNames;
import 'package:medora/core/constants/app_strings/app_strings.dart';
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
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
            Assets.images.doctorAI.image(fit: BoxFit.fill),

              _buildAskNowButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _buildAskNowButton(BuildContext context) => Positioned(
    left: 20,
    bottom: 15,
    child: SizedBox(
      height: 30,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.lightBlue),
          overlayColor: WidgetStateProperty.all(AppColors.grey),
          foregroundColor: WidgetStateProperty.all(AppColors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200),
              side: const BorderSide(color: Colors.white60, width: 1.5),
            ),
          ),
        ),
        onPressed: () =>
            AppRouter.pushNamed(context, AppRouterNames.geminiChat),
        child: const Text(AppStrings.askNow),
      ),
    ),
  );
}
