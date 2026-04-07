import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
import 'package:medora/core/constants/app_routes/app_router.dart';
import 'package:medora/core/constants/app_routes/app_router_names.dart';
import 'package:medora/features/home/presentation/constants/home_constants.dart'
    show HomeConstants;
import 'package:medora/features/home/presentation/widgets/home_app_bar_button.dart';

class NotificationIconButton extends StatelessWidget {
  const NotificationIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: HomeConstants.appBarIconSize,
      width: HomeConstants.appBarIconSize,

      decoration: HomeConstants.createBarActionDecoration(hasShadow: true),

      child: badges.Badge(
        position: badges.BadgePosition.topEnd(top: -8, end: -4),
        badgeContent: Text(
          '2',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        child: HomeAppBarButton(
          icon: FontAwesomeIcons.solidBell,
          onPressed: () =>
              AppRouter.pushNamed(context, AppRouterNames.notifications),
        ),
      ),
    );
  }
}
