import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons;
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
      child: HomeAppBarButton(
        icon: FontAwesomeIcons.solidBell,
        onPressed: () {},
      ),
    );
  }
}
