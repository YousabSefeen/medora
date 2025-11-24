import 'package:flutter/material.dart';
import 'package:medora/features/home/presentation/constants/home_constants.dart';
import 'package:medora/features/home/presentation/widgets/expandable_search_bar.dart'
    show ExpandableSearchBar;
import 'package:medora/features/home/presentation/widgets/notification_icon_button.dart'
    show NotificationIconButton;
import 'package:medora/features/home/presentation/widgets/user_greeting_section.dart'
    show UserGreetingSection;

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        UserGreetingSection(),

        SizedBox(
          height: HomeConstants.barContentHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,

            spacing: 10,
            children: [ExpandableSearchBar(), NotificationIconButton()],
          ),
        ),
      ],
    );
  }
}
