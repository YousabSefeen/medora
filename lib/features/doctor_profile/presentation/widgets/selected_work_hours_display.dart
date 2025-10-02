import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart' show AppStrings;
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../core/animations/animated_fade_transition.dart';

class SelectedWorkHoursDisplay extends StatelessWidget {
  final Map<String, String> workHoursSelected;

  const SelectedWorkHoursDisplay({super.key, required this.workHoursSelected});

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeTransition(
      child: Row(
        spacing: 25,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTimeText(
              context, AppStrings.from, workHoursSelected[AppStrings.from]!),
          _buildTimeText(
              context, AppStrings.to, workHoursSelected[AppStrings.to]!),
        ],
      ),
    );
  }
  Widget _buildTimeText(BuildContext context, String label, String value) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$label: ',
          style: textTheme.mediumBlack.copyWith(
            color: const Color(0xff3A59D1),
            letterSpacing: 1.3,
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(0.0,0.9),
              end: Offset.zero,
            ).animate(animation);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
          child: Text(
            value,
            key: ValueKey(value),
            style: textTheme.numbersStyle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }


}
