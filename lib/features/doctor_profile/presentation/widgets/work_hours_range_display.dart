import 'package:flutter/material.dart';
import 'package:medora/core/constants/app_strings/app_strings.dart'
    show AppStrings;
import 'package:medora/core/constants/common_widgets/label_with_animated_value.dart'
    show LabelWithAnimatedValue;
import 'package:medora/core/constants/themes/app_colors.dart';
import 'package:medora/core/constants/themes/app_text_styles.dart';

import '../../../../core/animations/animated_fade_transition.dart';

class WorkHoursRangeDisplay extends StatelessWidget {
  final Map<String, String> selectedWorkHours;

  const WorkHoursRangeDisplay({super.key, required this.selectedWorkHours});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextStyle labelStyle = _buildLabelStyle(theme);
    final TextStyle valueStyle = _buildValueStyle(theme);

    return AnimatedFadeTransition(
      child: Row(
        spacing: 25,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStartTimeDisplay(labelStyle, valueStyle),
          _buildEndTimeDisplay(labelStyle, valueStyle),
        ],
      ),
    );
  }

  TextStyle _buildLabelStyle(ThemeData theme) => theme.textTheme.mediumBlack
      .copyWith(color: AppColors.blue, letterSpacing: 1.3);

  TextStyle _buildValueStyle(ThemeData theme) =>
      theme.textTheme.numbersStyle.copyWith(fontWeight: FontWeight.w700);

  LabelWithAnimatedValue _buildStartTimeDisplay(
    TextStyle labelStyle,
    TextStyle valueStyle,
  ) => LabelWithAnimatedValue(
    label: AppStrings.from,
    value: selectedWorkHours[AppStrings.from] ?? '',
    labelTextStyle: labelStyle,
    valueTextStyle: valueStyle,
  );

  LabelWithAnimatedValue _buildEndTimeDisplay(
    TextStyle labelStyle,
    TextStyle valueStyle,
  ) => LabelWithAnimatedValue(
    label: AppStrings.to,
    value: selectedWorkHours[AppStrings.to] ?? '',
    labelTextStyle: labelStyle,
    valueTextStyle: valueStyle,
  );
}
